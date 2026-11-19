# Homebrew tap

Homebrew casks by JanHaan.

## ICA Viewer

[ICA Viewer](https://github.com/JanHaan/swift-ica-client) is an independent native macOS client for Citrix ICA sessions.

```sh
brew install --cask janhaan/tap/icaviewer   # install (adds and trusts this tap's ICA Viewer cask)
brew upgrade --cask icaviewer               # update (quit ICA Viewer first)
brew uninstall --cask icaviewer             # remove the app
brew uninstall --zap --cask icaviewer       # also remove its settings, logs and caches
```

Homebrew 7 loads casks only from trusted taps. The install command above trusts the one cask it names. To trust the
whole tap instead (for example before `brew install --cask icaviewer` by its short name):

```sh
brew tap janhaan/tap && brew trust janhaan/tap
```

Quit ICA Viewer before an upgrade or an uninstall. Homebrew replaces or removes the app but does not quit a running
one, so the old version keeps running until you quit it. `brew uninstall --zap` never touches the shared folder
`~/Citrix Shared`.

The cask installs the signed and notarized disk image from the project's
[GitHub releases](https://github.com/JanHaan/swift-ica-client/releases). Passwords that ICA Viewer saved stay in the
Keychain after an uninstall; use **Forget All Saved Credentials** in the app's **Settings** to remove them first.

Not affiliated with Citrix. Citrix and ICA are trademarks of Cloud Software Group, Inc.
