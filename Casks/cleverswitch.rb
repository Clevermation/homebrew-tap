cask "cleverswitch" do
  version "0.1.5"
  sha256 "1d5981d611ee45e1ba7b7b8f1f840c4c3ca0b47193ebdb02414eebad78fd0c49"

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
