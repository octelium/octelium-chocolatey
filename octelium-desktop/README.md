# Octelium Desktop Chocolatey package

The package downloads the official desktop MSI from `octelium/octelium-desktop`, verifies its SHA256 checksum and installs it silently for all users. It selects the native x64 or ARM64 installer even when Chocolatey runs under emulation. The MSI includes the UI, daemon service, WireGuard and Wintun libraries, and installs WebView2 if needed. The separate `octelium` CLI package is not required.

Once the package is approved on the Chocolatey Community Repository, run these commands from an elevated terminal:

```powershell
choco install octelium-desktop -y
choco upgrade octelium-desktop -y
choco uninstall octelium-desktop -y
```

Uninstallation targets the desktop MSI explicitly. The package disables Chocolatey's automatic uninstaller so a WebView2 runtime installed by the MSI is not also removed.

Unsigned MSI releases can be packaged, but Chocolatey does not make unsigned code trusted by Windows. SHA256 verifies that the downloaded bytes match the published package; it does not establish an Authenticode publisher identity. SmartScreen warnings and antivirus or enterprise policy blocks remain possible. Windows 11 Smart App Control can block an unsigned installer or executable even when it was installed through a package manager. See [Microsoft's SmartScreen guidance](https://learn.microsoft.com/en-us/windows/apps/package-and-deploy/smartscreen-reputation) and [Smart App Control signing requirements](https://learn.microsoft.com/en-us/windows/apps/develop/smart-app-control/code-signing-for-smart-app-control).

Adding signatures in a later release does not require a new Chocolatey package ID. For upgrades from unsigned to signed releases:

- Keep the ID `octelium-desktop` and publish a higher app and package version, such as `0.2.6` after `0.2.5`.
- Preserve the MSI UpgradeCode, install scope and language. Both published `0.2.5` MSIs use `{51EBC8D5-E7EA-5338-8E65-5747A41CC23B}`, `ALLUSERS=1` and language `1033`.
- Pin that existing UpgradeCode in the app's `bundle.windows.wix.upgradeCode` before changing the product name. Tauri currently derives it from `Octelium Desktop`; changing the name can otherwise produce a different app identity.
- Sign the UI and daemon executables before bundling, sign the finished installer, and preserve valid signatures on third-party driver libraries. Validate all executable components and installer scripts against the Windows policies you support.
- Publish new release assets and checksums. Replacing an already published unsigned MSI with signed bytes at the same URL invalidates the checksum in existing Chocolatey packages.

MSI upgrades depend on the installer identity, version and scope, rather than whether the previous release was signed. See [Microsoft's MSI upgrade documentation](https://learn.microsoft.com/en-us/windows/win32/msi/major-upgrades) and [Tauri's UpgradeCode configuration](https://v2.tauri.app/reference/config/#upgradecode). Signing also does not guarantee immediate SmartScreen reputation for a new release.

To publish the first package after these files are on the default branch:

1. Configure the repository's `CHOCO_API_KEY` secret with a Chocolatey account API key that can publish `octelium-desktop`.
2. Run **Update Desktop Chocolatey Package** with `version=v0.2.5` and `push_to_community=false` to build and test it. Download the `octelium-desktop-nupkg` artifact for review.
3. Run it again with `version=v0.2.5` and `push_to_community=true` to submit the package for moderation.

The scheduled workflow checks for new stable desktop releases every 30 minutes. It validates the release assets, manifest hashes and GitHub asset digests, downloads and checks both MSIs, then tests installation and uninstallation on x64 and ARM64 runners before publishing. When the target version is newer than the package recorded in this repository, it also tests `choco upgrade` from that recorded version and verifies that daemon state survives. The workflow records changed package files only after successful publication; repository rules must permit the Actions bot to push those updates, as with the existing CLI workflow.

The first `0.2.5` submission needs an explicit version or `push_to_community=true`, since that version is already recorded locally. A manual run with publishing disabled only creates artifacts. Community publication remains subject to [Chocolatey's moderation process](https://docs.chocolatey.org/en-us/community-repository/moderation/).

Local checks:

```sh
python3 -m unittest discover -s .github/scripts -p 'test_*.py'
pwsh -NoProfile -File .github/scripts/test-desktop-install.ps1
pwsh -NoProfile -File .github/scripts/test-desktop-uninstall.ps1
```

Actual MSI installation tests run on Windows in **Test Desktop Chocolatey Package**. These hosted runners do not establish that the app will pass Smart App Control or every managed Windows policy.
