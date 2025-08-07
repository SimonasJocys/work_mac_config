{ config, pkgs, nixvim, ... }:

{
  programs.nixvim.enable = true;
  programs.nixvim.colorschemes.gruvbox.enable = true;

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-be-good
    ];
  };
  programs.nixvim.plugins = {

    bufferline.enable = true;
    web-devicons.enable = true;
    
    which-key = {
      enable = true;
      settings.preset = "modern";
      settings.triggers = [
        {
          __unkeyed-1 = "<auto>";
          mode = "nxsot";
        }
          ];
    };

    lualine.enable = true;
    # neo-tree.enable = true;
    oil.enable = true;
    
    lsp = {
    enable = true;
    servers = {
      pylsp.enable = true;
      };
          };
    telescope.enable = true;

    treesitter = {
    enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      make
      markdown
      nix
      regex
      toml
      vim
      vimdoc
      xml
      yaml
      python
    ];
  };
};

programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;
    };
  };

programs.nixvim.globals = {
    mapleader = " ";
  };

programs.nixvim = {
    keymaps = [
      # {
      #   mode = "n";
      #   key = "<leader>pv";
      #   options.silent = true;
      #   action = "<cmd>Ex<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<leader>pv";
      #   options.silent = true;
      #   action = "<cmd>Neotree<CR>";
      # }
      {
        mode = "n";
        key = "<leader>pv";
        options.silent = true;
        action = "<cmd>Oil<CR>";
      }
      {
        mode = "n";
        key = "<leader><leader>c";
        options.silent = true;
        action = "<cmd>bd<CR>";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
      }
    ];
};

}