{ pkgs, lib, config,  ... }:
let
  albert_home = "${config.home.homeDirectory}/Library/Application Support/Albert/python/plugins/";
  albert_espanso_brew = "/opt/homebrew/Caskroom/albert/0.31.1/Albert.app/Contents/Resources/python/plugins/";
  albert_plugin_dir = "shortcuts";
in
{
  home.file."${albert_home}/${albert_plugin_dir}/shortcuts.txt" = {
    executable = true;
    text = ''
      🛠️ System:
      ▲ Ctrl + ↑ Shift + ⎵ Space  → Rofi (Espanso)
      ▲ Ctrl + ↑ Shift + ?  → Rofi (Shortcuts)
      ▲ Ctrl + ↑ Shift + b  → Rofi (Search on brave)
      
      🖥️ Window manager:
      ▲ Ctrl + ⎇ Alt + ↑ Up  → Workspace selection screen
      ▲ Ctrl + ⎇ Alt + ↓ Down  → Window selection screen
      ⎇ Alt + ↹ Tab → Cycle through open windows
      ↑ Shift + ⎇ Alt + ↹ Tab → Reverse Cycle through open windows

      💻 Terminal:

      🐃 Gnu Screen:
      ▲ Ctrl + A + ✖ Esc
    '';
  };

    home.file."${albert_home}/${albert_plugin_dir}/__init__.py" = {
    executable = true;
    text = ''
# -*- coding: utf-8 -*-
from albert import *
import os
import re

md_iid = "3.0"
md_version = "1.2"
md_name = "Shortcuts Cheat Sheet"
md_description = "Search and display your custom shortcuts in Albert"
md_license = "MIT"
md_authors = ["you"]

# Path to your shortcut file
SHORTCUTS_FILE = "/opt/homebrew/Caskroom/albert/0.31.1/Albert.app/Contents/Resources/python/plugins/shortcuts/shortcuts.txt"

class Plugin(PluginInstance, TriggerQueryHandler):
    def __init__(self):
        PluginInstance.__init__(self)
        TriggerQueryHandler.__init__(self)
        self.shortcuts = []
        self._load_shortcuts()

    def extensions(self):
        return [self]

    def defaultTrigger(self):
        return "sh "  # changed from "sc "

    def synopsis(self, query=None):
        return "Browse your shortcuts"

    def _load_shortcuts(self):
        """Parse the shortcuts file into categories + entries."""
        self.shortcuts.clear()
        if not os.path.exists(SHORTCUTS_FILE):
            warning(f"Shortcuts file not found: {SHORTCUTS_FILE}")
            return

        current_group = None
        with open(SHORTCUTS_FILE, "r", encoding="utf-8") as f:
            for raw in f:
                line = raw.strip()
                if not line:
                    continue

                # Detect category headers (end with :)
                if line.endswith(":"):
                    current_group = line.rstrip(":").strip()
                    continue

                # Parse "combo → description"
                match = re.match(r"(.+?)\s*→\s*(.+)", line)
                if match:
                    combo, desc = match.groups()
                else:
                    combo, desc = line, ""

                self.shortcuts.append({
                    "group": current_group or "",
                    "combo": combo.strip(),
                    "desc": desc.strip()
                })

    def handleTriggerQuery(self, query):
        """Show shortcuts filtered by combo, description, or group."""
        search = query.string.strip().lower()
        items = []

        for sc in self.shortcuts:
            combo = sc["combo"]
            desc = sc["desc"]
            group = sc["group"]

            # Match if search text is in combo, description, or group
            if search:
                if search not in combo.lower() and search not in desc.lower() and search not in group.lower():
                    continue

            # Show combo as main text, and description + group as subtext
            text = combo
            subtext = f"{desc} — {group}" if desc else group

            items.append(
                StandardItem(
                    id=f"sc_{combo}",
                    text=text,
                    subtext=subtext,
                    actions=[]  # no actions needed, just display
                )
            )

        # If nothing matched, show a placeholder
        if not items:
            items.append(
                StandardItem(
                    id="sc_none",
                    text="No matching shortcuts",
                    subtext="",
                    actions=[]
                )
            )

        query.add(items)

    '';
  };

  home.activation.linkAlbertEspanso = lib.hm.dag.entryAfter ["writeBoundary"] ''
  mkdir -p "${albert_espanso_brew}/${albert_plugin_dir}"
  ln -sf "${albert_home}/${albert_plugin_dir}/__init__.py" "${albert_espanso_brew}/${albert_plugin_dir}/__init__.py"
  ln -sf "${albert_home}/${albert_plugin_dir}/shortcuts.txt" "${albert_espanso_brew}/${albert_plugin_dir}/shortcuts.txt"

'';


}