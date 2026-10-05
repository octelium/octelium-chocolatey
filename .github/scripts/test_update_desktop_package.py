import copy
import importlib.util
import tempfile
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent
PACKAGE_DIR = SCRIPT_DIR.parents[1] / "octelium-desktop"
SPEC = importlib.util.spec_from_file_location("update_desktop_package", SCRIPT_DIR / "update-desktop-package.py")
UPDATE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(UPDATE)


class DesktopPackageTests(unittest.TestCase):
    def setUp(self):
        self.release = {"tag_name": "v0.2.5", "draft": False, "prerelease": False, "assets": []}
        self.lines = []
        for arch, msi_arch, checksum in (("amd64", "x64", "a" * 64), ("arm64", "arm64", "b" * 64)):
            filename = f"octelium-desktop-windows-{arch}-Octelium Desktop_0.2.5_{msi_arch}_en-US.msi"
            asset_name = filename.replace(" ", ".")
            self.lines.append(f"{checksum}  {filename}")
            self.release["assets"].append({
                "name": asset_name,
                "browser_download_url": f"https://github.com/octelium/octelium-desktop/releases/download/v0.2.5/{asset_name}",
                "digest": f"sha256:{checksum}",
            })
        self.checksums = "\n".join(self.lines) + "\n"

    def test_github_asset_names_match_manifest_spaces(self):
        downloads = UPDATE.release_downloads(self.release, self.checksums)
        self.assertEqual(downloads["amd64"]["checksum"], "a" * 64)
        self.assertEqual(downloads["arm64"]["checksum"], "b" * 64)
        self.assertIn("Octelium.Desktop_0.2.5_x64_en-US.msi", downloads["amd64"]["url"])
        self.assertIn("Octelium.Desktop_0.2.5_arm64_en-US.msi", downloads["arm64"]["url"])

    def test_binary_marker_uppercase_hash_and_crlf(self):
        checksums = self.checksums.replace("  ", " *").replace("a" * 64, "A" * 64).replace("\n", "\r\n")
        self.assertEqual(UPDATE.release_downloads(self.release, checksums)["amd64"]["checksum"], "a" * 64)

    def test_dotted_manifest_names(self):
        checksums = self.checksums.replace("Octelium Desktop", "Octelium.Desktop")
        self.assertEqual(UPDATE.release_downloads(self.release, checksums)["arm64"]["checksum"], "b" * 64)

    def test_missing_invalid_or_duplicate_checksum_is_rejected(self):
        for checksums in (self.lines[0], self.checksums.replace("b" * 64, "b" * 63), self.checksums + self.lines[0]):
            with self.subTest(checksums=checksums), self.assertRaises(ValueError):
                UPDATE.release_downloads(self.release, checksums)

    def test_missing_duplicate_asset_or_changed_digest_is_rejected(self):
        releases = []
        for mutation in ("missing", "duplicate", "digest", "url"):
            release = copy.deepcopy(self.release)
            if mutation == "missing":
                release["assets"].pop()
            elif mutation == "duplicate":
                release["assets"].append(release["assets"][0])
            elif mutation == "digest":
                release["assets"][0]["digest"] = "sha256:" + "c" * 64
            else:
                release["assets"][0]["browser_download_url"] = "https://example.com/installer.msi"
            releases.append((mutation, release))
        for mutation, release in releases:
            with self.subTest(mutation=mutation), self.assertRaises(ValueError):
                UPDATE.release_downloads(release, self.checksums)

    def test_older_releases_without_github_digest(self):
        for asset in self.release["assets"]:
            asset.pop("digest")
        self.assertEqual(UPDATE.release_downloads(self.release, self.checksums)["amd64"]["checksum"], "a" * 64)

    def test_invalid_versions_drafts_and_prereleases_are_rejected(self):
        for tag in ("v0.2.5-beta.1", "v0.2.5+signed", "v0.2", "v00.2.5", "v256.2.5", "v0.256.5", "v0.2.65536", "v0.2.5\n"):
            with self.subTest(tag=tag), self.assertRaises(ValueError):
                UPDATE.release_version({"tag_name": tag})
        for field in ("draft", "prerelease"):
            with self.subTest(field=field), self.assertRaises(ValueError):
                UPDATE.release_version({"tag_name": "v0.2.5", field: True})
        self.assertEqual(UPDATE.release_version({"tag_name": "0.2.5"}), "0.2.5")

    def test_templates_preserve_powershell_variables_and_exclude_templates(self):
        with tempfile.TemporaryDirectory() as directory:
            package_dir = Path(directory)
            (package_dir / "tools").mkdir()
            for filename in ("octelium-desktop.nuspec", "tools/chocolateyInstall.ps1"):
                (package_dir / f"{filename}.tmpl").write_bytes((PACKAGE_DIR / f"{filename}.tmpl").read_bytes())
            UPDATE.generate_package(self.release, self.checksums, package_dir)
            nuspec = ET.parse(package_dir / "octelium-desktop.nuspec")
            self.assertEqual(nuspec.findtext("./{*}metadata/{*}id"), "octelium-desktop")
            self.assertEqual(nuspec.findtext("./{*}metadata/{*}version"), "0.2.5")
            self.assertEqual(nuspec.find("./{*}files/{*}file").get("src"), "tools\\*.ps1")
            script = (package_dir / "tools/chocolateyInstall.ps1").read_text()
            self.assertIn("$ErrorActionPreference = 'Stop'", script)
            self.assertIn("Install-ChocolateyPackage @packageArgs", script)
            self.assertNotIn("${", script)

    def test_invalid_release_does_not_overwrite_package(self):
        with tempfile.TemporaryDirectory() as directory:
            package_dir = Path(directory)
            nuspec = package_dir / "octelium-desktop.nuspec"
            nuspec.write_text("original package")
            with self.assertRaises(ValueError):
                UPDATE.generate_package(self.release, self.lines[0], package_dir)
            self.assertEqual(nuspec.read_text(), "original package")


if __name__ == "__main__":
    unittest.main()
