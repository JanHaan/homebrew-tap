cask "icaviewer" do
  version "0.11.0"
  sha256 "3237fbafcbe88861b69827f336b68a142fa22f02575495e22bff931fc972b358"

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
