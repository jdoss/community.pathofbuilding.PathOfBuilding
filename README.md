# Path of Building Dev Flatpak

In order to build a Flatpak for the dev version of Path of Building you will need to clone this repo and do the following:

1. Install the KDE SDK Flatpak
  ```bash
  flatpak install org.kde.Sdk/x86_64/6.6
  ```
1. Get the sha of the current dev branch
  ```bash
  curl -sL https://api.github.com/repos/PathOfBuildingCommunity/PathOfBuilding/git/trees/dev|jq -r .sha
  f101dde1f11b77fb76e99b4851cb6cfa8966e5f2
  ```
1. Edit `community.pathofbuilding.PathOfBuilding.yml` and update the `commit` for the
  ```yaml
  modules:
  - name: PathOfBuildingCommunity
    buildsystem: simple
    build-commands:
      - unzip runtime-win32.zip lua/xml.lua lua/base64.lua lua/sha1.lua
      - mv lua/*.lua .
      - rm -rf lua runtime-win32.zip runtime/*.dll runtime/*.exe
      - cp -r $FLATPAK_BUILDER_BUILDDIR/. $FLATPAK_DEST/pathofbuilding
    sources:
      - type: git
        url: https://github.com/PathOfBuildingCommunity/PathOfBuilding.git
        commit: f101dde1f11b77fb76e99b4851cb6cfa8966e5f2
    ```
1. Build the Flatpak locally and install
  ```bash
  flatpak-builder flatpak-build --user --force-clean --install community.pathofbuilding.PathOfBuilding.yml
  ```
1. Spend the rest of your day theory crafting a Path of Exile league start
