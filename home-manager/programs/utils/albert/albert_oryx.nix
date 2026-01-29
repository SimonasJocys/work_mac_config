{ pkgs, lib, config,  ... }:
let
  albert_home = "${config.home.homeDirectory}/Library/Application Support/Albert/python/plugins/";
#   point to specific version of albert - future updates will brake it 
  albert_espanso_brew = "/opt/homebrew/Caskroom/albert/0.31.1/Albert.app/Contents/Resources/python/plugins/";
  albert_plugin_dir = "oryx";


in
{
  home.file."${albert_home}/${albert_plugin_dir}/__init__.py" = {
    # according to https://github.com/Mr-Aaryan/rofi-drun-search-web
    executable = true;
    text = ''
# -*- coding: utf-8 -*-
from albert import *
import subprocess
import os

md_iid = "3.0"
md_version = "1.0"
md_name = "oryx"
md_description = "Open a fixed image in PureRef"
md_license = "MIT"
md_authors = ["you"]

IMAGE_PATH = "/Users/simon/Desktop/test_img.png"

class Plugin(PluginInstance, TriggerQueryHandler):

    def __init__(self):
        PluginInstance.__init__(self)
        TriggerQueryHandler.__init__(self)

    def extensions(self):
        return [self]

    def defaultTrigger(self):
        return "pr"

    def handleTriggerQuery(self, query):
        if not os.path.isfile(IMAGE_PATH):
            return

        query.add(StandardItem(
            id="pureref_open_fixed",
            text="Open image in PureRef",
            subtext=IMAGE_PATH,
            actions=[
                Action(
                    "open",
                    "Open in PureRef",
                    self.open_pureref
                )
            ]
        ))

    def open_pureref(self):
        subprocess.Popen([
            "open",
            "-a",
            "PureRef",
            "--args",
            IMAGE_PATH
        ])

    '';
  };

# since I cannot add plugins (with home-manager) to homebrew directory, resorting to creating symlinks. Seems to be working 
# also since macos uses spaces in folders, note quotes for the paths 
  home.activation.link_albert_shortcuts = lib.hm.dag.entryAfter ["writeBoundary"] ''
  mkdir -p "${albert_espanso_brew}/${albert_plugin_dir}"
  ln -sf "${albert_home}/${albert_plugin_dir}/__init__.py" "${albert_espanso_brew}/${albert_plugin_dir}/__init__.py"
'';
}
