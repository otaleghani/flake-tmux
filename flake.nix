{
  description = "flake tmux";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      tmuxConfig = ''
        set -g status-bg colour235
        set -g status-fg colour136
      '';

      tmuxWithConfig = pkgs.tmux.overrideAttrs (old: {
        postInstall = ''
          mkdir -p $out/etc/tmux
          echo "${tmuxConfig}" > $out/etc/tmux/tmux.conf
        '';
      });
    in
    {

      # default =
      #   pkgs.mkShell {
      #     buildInputs = [
      #       pkgs.tmux
      #     ];

      #     shellHook = ''
      #       echo "Hello from tmux derivation"
      #     '';
      #   };

      packages.${system} = {
        tmuxWithConfig = tmuxWithConfig;
        default = tmuxWithConfig;
        # pkgs.tmux;
      };
    };
}
