cask "nerder" do
  version "0.1.0"
  sha256 "ca8de23d6d2f8784ca7801a51da73562087a0434c9202c6c01b87f71df44f548"

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
