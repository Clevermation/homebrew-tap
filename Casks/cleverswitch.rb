cask "cleverswitch" do
  version "0.2.0"
  sha256 "5cef1f57cedd712455c7143988e19c993d7b3bad46090e3dc62e1fd910cd0aac"

  url "https://github.com/Clevermation/cleverswitch/releases/download/v#{version}/CleverSwitch-#{version}.zip"
  name "CleverSwitch"
  desc "Menubar switcher for multiple AI CLI accounts (Claude Code & Codex)"
  homepage "https://github.com/Clevermation/cleverswitch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "CleverSwitch.app"

  # Quarantaene nach dem Stagen entfernen (ad-hoc signiert, nicht notarisiert).
  # Ersetzt das ab 2026-09-01 entfernte --no-quarantine-Flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/CleverSwitch.app"]
  end

  uninstall quit: "com.clevermation.cleverswitch"

  zap trash: [
    "~/Library/Application Support/CleverSwitch",
    "~/Library/Logs/CleverSwitch.log",
    "~/Library/Logs/CleverSwitch.old.log",
  ]
end
