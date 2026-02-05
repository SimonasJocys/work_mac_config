{ pkgs, lib, config,  ... }:
let
  albert_home = "${config.home.homeDirectory}/Library/Application Support/Albert/python/plugins/";
#   point to specific version of albert - future updates will brake it 
  albert_brew = "/opt/homebrew/Caskroom/albert/0.31.1/Albert.app/Contents/Resources/python/plugins/";
  albert_plugin_dir = "oryx";

in
{
  home.file."${albert_home}/${albert_plugin_dir}/__init__.py" = {
    # according to https://github.com/Mr-Aaryan/rofi-drun-search-web
    executable = true;
    text = ''
# -*- coding: utf-8 -*-
from albert import *
import cv2 #albert implicitly installs this in the separate pyenv. Takes some time

md_iid = "3.0"
md_version = "1.0"
md_name = "oryx"
md_description = "Display a hardcoded image in a minimal Tkinter window"
md_license = "MIT"
md_authors = ["you"]
md_lib_dependencies = ["opencv-python"]

IMAGE_PATH = "/Users/simon/Desktop/test_img.png"
WINDOW_NAME = "Image Viewer"

class Plugin(PluginInstance, TriggerQueryHandler):
    def __init__(self):
        PluginInstance.__init__(self)
        TriggerQueryHandler.__init__(self)

    def extensions(self):
        return [self]

    def defaultTrigger(self):
        return "imgview "

    def handleTriggerQuery(self, query):
        query.add(StandardItem(
            id="show_image",
            text="Show Image",
            subtext=f"Display image: {IMAGE_PATH}",
            actions=[Action("exec", "Open image", lambda: self.show_image())]
        ))

    def show_image(self):
        img = cv2.imread(IMAGE_PATH)
        if img is None:
            return

        # Create normal window first
        cv2.namedWindow(WINDOW_NAME, cv2.WINDOW_NORMAL)
        cv2.imshow(WINDOW_NAME, img)

        # Resize window to image size
        height, width = img.shape[:2]
        cv2.resizeWindow(WINDOW_NAME, width, height)

        # Center window (OpenCV does not have direct API, use OS coordinates via moveWindow)
        screen_width = 1920  # Hardcoded, can be dynamically fetched if needed
        screen_height = 1080
        x = (screen_width - width) // 2
        y = (screen_height - height) // 2
        cv2.moveWindow(WINDOW_NAME, x + 2, y + 1) #manual moving of the window - easier with alot of moving parts (aerospace, screen, macos). Also probably float issue

        # Keep window on top (platform dependent)
        cv2.setWindowProperty(WINDOW_NAME, cv2.WND_PROP_TOPMOST, 1)

        # Wait until ESC key
        while True:
            key = cv2.waitKey(10)
            if key == 27:
                break

        cv2.destroyWindow(WINDOW_NAME)

    '';
  };

# since I cannot add plugins (with home-manager) to homebrew directory, resorting to creating symlinks. Seems to be working 
# also since macos uses spaces in folders, note quotes for the paths 
  home.activation.link_albert_oryx = lib.hm.dag.entryAfter ["writeBoundary"] ''
  mkdir -p "${albert_brew}/${albert_plugin_dir}"
  ln -sf "${albert_home}/${albert_plugin_dir}/__init__.py" "${albert_brew}/${albert_plugin_dir}/__init__.py"
'';
}
