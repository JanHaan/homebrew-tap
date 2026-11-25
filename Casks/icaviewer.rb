cask "icaviewer" do
  version "0.11.4"
  sha256 "1432ade5625abb4af8bb1aa7ae637351f81a45c0496a9e190c306c5afb3e3c7c"

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
