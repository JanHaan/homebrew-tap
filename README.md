# Homebrew tap

Homebrew casks by JanHaan.

## ICA Viewer

[ICA Viewer](https://github.com/JanHaan/swift-ica-client) is an independent native macOS client for Citrix ICA sessions.

```sh
brew install --cask janhaan/tap/icaviewer    # install
brew upgrade --cask icaviewer                # update (quit ICA Viewer first)
brew uninstall --cask icaviewer              # remove the app
brew uninstall --zap --cask icaviewer        # also remove its settings, logs and caches
```

The cask installs the signed and notarized disk image from the project's
[GitHub releases](https://github.com/JanHaan/swift-ica-client/releases). Passwords that ICA Viewer saved stay in the
Keychain after an uninstall; use **Forget All Saved Credentials** in the app's **Settings** to remove them first.

Not affiliated with Citrix. Citrix and ICA are trademarks of Cloud Software Group, Inc.
