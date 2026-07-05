cask "cleverswitch" do
  version "0.2.2"
  sha256 "dfc38ffb59737c4f3be3865a1d41455c7b0ee04e3edd9d352b583ed26b951b30"

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
