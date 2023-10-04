{ ... }: {
  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # Enable aliases
    viAlias = true;
    vimAlias = true;

    # Enable providers
    withNodeJs = true;
    withPython3 = true;
  };
}
