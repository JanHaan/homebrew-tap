cask "icaviewer" do
  version "0.10.1"
  sha256 "d4e27cc9005f1a59127a81384faa3f497b3fa2831c5b4d3ae8e7dcd8704ff23a"

  url "https://github.com/JanHaan/swift-ica-client/releases/download/v#{version}/swift-ica-client-#{version}.dmg"
  name "ICA Viewer"
  desc "Independent native client for Citrix ICA sessions"
  homepage "https://github.com/JanHaan/swift-ica-client"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

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
