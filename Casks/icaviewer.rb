cask "icaviewer" do
  version "0.11.2"
  sha256 "eefd6b9e359f726bffa4fd7f42814bf737c422ea6d9f16f8a3d4b2a2fac075f8"

  url "https://github.com/JanHaan/swift-ica-client/releases/download/v#{version}/swift-ica-client-#{version}.dmg"
  name "ICA Viewer"
  desc "Independent native client for Citrix ICA sessions"
  homepage "https://github.com/JanHaan/swift-ica-client"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "ICAViewer.app"

  zap trash: [
    "~/Library/Application Support/ICAViewer",
    "~/Library/Caches/ICAViewer",
    "~/Library/Logs/ICAViewer",
    "~/Library/Preferences/local.alttab.ICAViewer.plist",
  ]

  caveats <<~EOS
    Quit ICA Viewer before upgrading: an upgrade replaces the app,
    and running sessions should end through the app, not underneath it.
  EOS
end
