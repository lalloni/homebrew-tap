cask "nerder" do
  version "0.1.0"
  # Placeholder until the first release: the update workflow fills in the real checksum.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/lalloni/nerder/releases/download/v#{version}/nerder-macos-universal.zip"
  name "nerder"
  desc "Browse and install Nerd Fonts"
  homepage "https://github.com/lalloni/nerder"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "nerder.app"

  # The app is not signed or notarized yet, so clear the quarantine flag that
  # would otherwise make Gatekeeper refuse the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/nerder.app"]
  end

  zap trash: [
    "~/Library/Application Support/nerder",
    "~/Library/Caches/nerder",
  ]

  caveats <<~EOS
    Fonts you install with nerder are kept when you uninstall it. They live in
    ~/Library/Fonts/NerdFonts.
  EOS
end
