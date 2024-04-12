{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = false;
    theme = {
      name = "Catppuccin-Frappe-Standard-Peach-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["peach"];
        size = "standard";
        variant = "frappe";
      };
    };
    cursorTheme.name = "default";
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "frappe";
        accent = "peach";
      };
      name = "Papirus-Dark";
    };
  };

  # Symlink the `~/.config/gtk-4.0/` folder declaratively to theme GTK-4 apps as well.
  xdg.configFile = let
    g = config.gtk.theme.package;
  in {
    "gtk-4.0/assets".source = "${g}/share/themes/${g}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${g}/share/themes/${g}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${g}/share/themes/${g}/gtk-4.0/gtk-dark.css";
  };
}
