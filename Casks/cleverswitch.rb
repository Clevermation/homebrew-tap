cask "cleverswitch" do
  version "0.1.1"
  sha256 "6dc77199ceaa7dca946386d7250911686a14cdc56f1e334148a584c7ce974b52"

  url "https://github.com/Clevermation/cleverswitch/releases/download/v#{version}/CleverSwitch-#{version}.zip"
  name "CleverSwitch"
  desc "Menubar switcher for multiple AI CLI accounts (Claude Code & Codex)"
  homepage "https://github.com/Clevermation/cleverswitch"

  depends_on macos: :sonoma

  app "CleverSwitch.app"

  # Quarantaene nach dem Stagen entfernen (ad-hoc signiert, nicht notarisiert).
  # Ersetzt das ab 2026-09-01 entfernte --no-quarantine-Flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/CleverSwitch.app"]
  end

  zap trash: [
    "~/Library/Application Support/CleverSwitch",
    "~/Library/Logs/CleverSwitch.log",
  ]
end
