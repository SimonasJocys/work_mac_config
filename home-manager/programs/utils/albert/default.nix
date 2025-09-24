{ pkgs, lib, config,  ... }:
let
  albert_espanso_home = "${config.home.homeDirectory}/Library/Application Support/Albert/python/plugins/";
#   point to specific version of albert - future updates will brake it 
  albert_espanso_brew = "/opt/homebrew/Caskroom/albert/0.31.1/Albert.app/Contents/Resources/python/plugins/";
  albert_espanso_dir = "espanso";


in
{
  home.file."${albert_espanso_home}/${albert_espanso_dir}/__init__.py" = {
    # according to https://github.com/Mr-Aaryan/rofi-drun-search-web
    executable = true;
    text = ''
      # -*- coding: utf-8 -*-
      from albert import *
      import subprocess

      md_iid = "3.0"
      md_version = "1.0"
      md_name = "espanso"
      md_description = "Browse and execute Espanso matches"
      md_license = "MIT"
      md_authors = ["you"]

      ESPANSO_BIN = "/Users/simon/.nix-profile/bin/espanso"  # full path to espanso

      class Plugin(PluginInstance, TriggerQueryHandler):
          def __init__(self):
              PluginInstance.__init__(self)
              TriggerQueryHandler.__init__(self)

          def extensions(self):
              return [self]

          def defaultTrigger(self):
              return "espanso "

          def handleTriggerQuery(self, query):
              stripped = query.string.strip()

              try:
                  # Run espanso match list with absolute path
                  result = subprocess.run(
                      [ESPANSO_BIN, "match", "list"],
                      capture_output=True,
                      text=True,
                      check=True
                  )
                  lines = result.stdout.strip().splitlines()
              except Exception as e:
                  query.add(StandardItem(
                      id="espanso_error",
                      text="Espanso not available",
                      subtext=str(e),
                      actions=[]
                  ))
                  return

              items = []
              for line in lines:
                  # Default format: "trigger - description"
                  parts = line.split(" - ", 1)
                  trigger = parts[0].strip()
                  desc = parts[1].strip() if len(parts) > 1 else ""

                  # Only show filtered items if user typed more
                  if stripped and stripped.lower() not in trigger.lower() and stripped.lower() not in desc.lower():
                      continue

                  items.append(StandardItem(
                      id=f"espanso_{trigger}",
                      text=trigger,
                      subtext=desc,
                      actions=[
                          Action("exec", "Run espanso match", lambda t=trigger: self.run_match(t)),
                          Action("copy", "Copy trigger", lambda t=trigger: setClipboardText(t))
                      ]
                  ))

              if not items:
                  items.append(StandardItem(
                      id="espanso_none",
                      text="No matches",
                      subtext="No Espanso triggers found",
                      actions=[]
                  ))

              query.add(items)

          def run_match(self, trigger: str):
              try:
                  subprocess.run(
                      [ESPANSO_BIN, "match", "exec", "--trigger", trigger],
                      check=True
                  )
                  info(f"Executed Espanso trigger: {trigger}")
              except Exception as e:
                  warning(f"Failed to execute Espanso trigger {trigger}: {e}")

    '';
  };

# since I cannot add plugins (with home-manager) to homebrew directory, resorting to creating symlinks. Seems to be working 
# also since macos uses spaces in folders, note quotes for the paths 
  home.activation.linkAlbertEspanso = lib.hm.dag.entryAfter ["writeBoundary"] ''
  mkdir -p "${albert_espanso_brew}/${albert_espanso_dir}"
  ln -sf "${albert_espanso_home}/${albert_espanso_dir}/__init__.py" "${albert_espanso_brew}/${albert_espanso_dir}/__init__.py"
'';
}
