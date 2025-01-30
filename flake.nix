{
  description = "flake tmux";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # devShells.${system}.default =
      default =
        pkgs.mkShell {
          buildInputs = [
            pkgs.tmux
          ];

          shellHook = ''
            echo "Hello from tmux derivation"
          '';
        };
    };
}
