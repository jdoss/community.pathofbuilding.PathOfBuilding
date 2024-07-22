# Path of Building Dev Flatpak

In order to build a Flatpak for the dev version of Path of Building you will need to clone this repo and do the following:

## Manual

1. Install the KDE SDK Flatpak
  ```bash
  flatpak install org.kde.Sdk/x86_64/6.6
  ```

2. Get the sha of the current dev branch
  ```bash
  curl -sL https://api.github.com/repos/PathOfBuildingCommunity/PathOfBuilding/git/trees/dev|jq -r .sha
  f101dde1f11b77fb76e99b4851cb6cfa8966e5f2
  ```

3. Edit `community.pathofbuilding.PathOfBuilding.yml` and update the `commit` for the
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

4. Build the Flatpak locally and install
  ```bash
  flatpak-builder flatpak-build --user --force-clean --install community.pathofbuilding.PathOfBuilding.yml
  ```

5. Spend the rest of your day theory crafting a Path of Exile league start

## Automated

You can also just run `./build.sh` which will build off of the current SHA on the dev branch of `PathOfBuildingCommunity/PathOfBuilding` on GitHub. You can also pass the SHA you want to build:

```bash
./build.sh 2b7a951643dfc27c4ad2a9d71f7234c1edd883e3
```

Note: You will need to have https://github.com/mikefarah/yq installed for this script to work.
