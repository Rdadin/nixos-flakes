{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    extraPackages = with pkgs; [ git gcc ripgrep fd ];
  };

  # IMPORTANT: remove any previous xdg.configFile."nvim" that pointed to fetchGit starter
  
  xdg.configFile."nvim/lua/plugins/init.lua".text = "return {}";

  # Minimal, writable bootstrap for LazyVim
  xdg.configFile."nvim/init.lua".text = ''
    -- leader early (LazyVim expects this)
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git","clone","--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git","--branch=stable", lazypath
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
      -- Load LazyVim defaults + allow local overrides under lua/plugins (optional)
      spec = {
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "plugins" },
      },
      -- WRITE LOCKFILE IN A WRITABLE PLACE
      lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
      checker = { enabled = false },

      -- Don’t let lazy reset rtp if you later add Nix-provided plugins
      performance = { reset_packpath = false, rtp = { reset = false } },
    })
  '';

  # Optional empty dir so you can add your own plugins later
  xdg.configFile."nvim/lua/plugins/.keep".text = "";
}

