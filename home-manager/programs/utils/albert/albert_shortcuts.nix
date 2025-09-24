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
md_version = "1.0"
md_name = "shortcuts"
md_description = "Browse and execute Espanso matches"
md_license = "MIT"
md_authors = ["you"]

shortcuts = []

def initialize():
    """Load shortcuts from text file"""
    global shortcuts
    shortcuts.clear()
    config_file = os.path.expanduser("~/.config/albert/shortcuts.txt")

    if not os.path.exists(config_file):
        warning(f"No shortcuts file found at {config_file}")
        return

    current_group = None
    with open(config_file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            # Detect category/group lines (end with ":")
            if line.endswith(":"):
                current_group = line.strip(":")
                continue

            # Detect "shortcut → description"
            match = re.match(r"(.+?)\s*→\s*(.+)", line)
            if match:
                combo, desc = match.groups()
                shortcuts.append({
                    "group": current_group,
                    "combo": combo.strip(),
                    "desc": desc.strip()
                })

def handleQuery(query):
    if not query.isTriggered:
        return

    q = query.string.strip().lower()
    results = []

    for sc in shortcuts:
        # Match on combo, description, or group
        if q in sc["combo"].lower() or q in sc["desc"].lower() or q in sc["group"].lower():
            results.append(
                Item(
                    id=sc["combo"],
                    text=f"{sc['combo']} → {sc['desc']}",
                    subtext=f"{sc['group']}",
                    actions=[
                        ClipAction("Copy shortcut", sc["combo"]),
                        ClipAction("Copy description", sc["desc"])
                    ]
                )
            )

    return results

    '';
  };

  home.activation.linkAlbertEspanso = lib.hm.dag.entryAfter ["writeBoundary"] ''
  mkdir -p "${albert_espanso_brew}/${albert_plugin_dir}"
  ln -sf "${albert_home}/${albert_plugin_dir}/__init__.py" "${albert_espanso_brew}/${albert_plugin_dir}/__init__.py"
'';


}