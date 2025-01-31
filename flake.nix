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

    # tmuxWithConfig = pkgs.tmux.overrideAttrs (old: {
    #   postInstall = ''
    #     mkdir -p $out/etc/tmux
    #     echo "${tmuxConfig}" > $out/etc/tmux/tmux.conf
    #   '';
    # });
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      packages = [ pkgs.tmux ];
      shellHook = ''
        echo "${tmuxConfig}" > ./tmux.conf
        echo "helo"
      '';
    };
  };
}
