cask "cleverswitch" do
  version "0.1.3"
  sha256 "4a3014ebbbd339c07b5f2c741fcaef65acdedd5d9905df58937eaca6c0c3f42a"

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

  uninstall quit: "com.clevermation.cleverswitch"

  zap trash: [
    "~/Library/Application Support/CleverSwitch",
    "~/Library/Logs/CleverSwitch.log",
    "~/Library/Logs/CleverSwitch.old.log",
  ]

  livecheck do
    url :url
    strategy :github_latest
  end
end
