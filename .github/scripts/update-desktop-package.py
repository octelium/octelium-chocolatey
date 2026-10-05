import argparse
import json
import re
from pathlib import Path
from urllib.parse import quote


def release_version(release):
    tag = release["tag_name"]
    if release.get("draft") or release.get("prerelease"):
        raise ValueError("Only published stable desktop releases can be packaged.")
    if not re.fullmatch(r"v?(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)", tag):
        raise ValueError(f"Invalid stable release tag: {tag}")
    version = tag.removeprefix("v")
    if any(int(part) > limit for part, limit in zip(version.split("."), (255, 255, 65535))):
        raise ValueError(f"Release version exceeds MSI limits: {version}")
    return version


def release_downloads(release, checksums):
    version = release_version(release)
    hashes = {}
    for line in checksums.splitlines():
        match = re.fullmatch(r"([0-9a-fA-F]{64}) [ *](.+)", line)
        if match:
            checksum, filename = match.groups()
            filename = filename.replace(" ", ".")
            if filename in hashes:
                raise ValueError(f"Duplicate checksum for {filename}")
            hashes[filename] = checksum.lower()

    downloads = {}
    for arch, msi_arch in (("amd64", "x64"), ("arm64", "arm64")):
        filename = f"octelium-desktop-windows-{arch}-Octelium.Desktop_{version}_{msi_arch}_en-US.msi"
        assets = [asset for asset in release["assets"] if asset["name"].replace(" ", ".") == filename]
        if len(assets) != 1 or filename not in hashes:
            raise ValueError(f"Missing or ambiguous MSI asset/checksum for {filename}")
        asset = assets[0]
        url = f"https://github.com/octelium/octelium-desktop/releases/download/{release['tag_name']}/{quote(asset['name'], safe='')}"
        if asset["browser_download_url"] != url:
            raise ValueError(f"Unexpected MSI download URL: {asset['browser_download_url']}")
        if asset.get("digest") and asset["digest"] != f"sha256:{hashes[filename]}":
            raise ValueError(f"GitHub digest does not match SHA256SUMS for {filename}")
        downloads[arch] = {"url": url, "checksum": hashes[filename]}
    return downloads


def generate_package(release, checksums, package_dir):
    downloads = release_downloads(release, checksums)
    values = {"TAG": release["tag_name"], "CLEAN_VERSION": release_version(release)}
    for arch, download in downloads.items():
        values[f"URL_MSI_{arch.upper()}"] = download["url"]
        values[f"SHA_MSI_{arch.upper()}"] = download["checksum"]

    generated = {}
    for filename in ("octelium-desktop.nuspec", "tools/chocolateyInstall.ps1"):
        content = (package_dir / f"{filename}.tmpl").read_text(encoding="utf-8")
        for key, value in values.items():
            content = content.replace("${" + key + "}", value)
        if re.search(r"\$\{[A-Z_]+\}", content):
            raise ValueError(f"Unresolved template variable in {filename}")
        generated[filename] = content

    for filename, content in generated.items():
        (package_dir / filename).write_text(content, encoding="utf-8")
    return downloads


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--release-json", required=True, type=Path)
    parser.add_argument("--checksums", required=True, type=Path)
    parser.add_argument("--package-dir", type=Path, default=Path("octelium-desktop"))
    args = parser.parse_args()
    downloads = generate_package(
        json.loads(args.release_json.read_text(encoding="utf-8")),
        args.checksums.read_text(encoding="utf-8"),
        args.package_dir,
    )
    print(json.dumps(downloads))
