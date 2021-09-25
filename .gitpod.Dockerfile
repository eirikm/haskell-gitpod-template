FROM gitpod/workspace-base

# install haskell
RUN sudo apt-get update && sudo apt-get install -y haskell-platform

# install stack
RUN sudo curl -sSL https://get.haskellstack.org/ | sh

# install nix
ENV USER=gitpod
RUN curl -L https://nixos.org/nix/install | sh \
    && cp ~/.nix-profile/etc/profile.d/nix.sh ~/.bashrc.d/ \
    && . $HOME/.nix-profile/etc/profile.d/nix.sh \
    && nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs 

# install ghcid and fourmolu
RUN . $HOME/.nix-profile/etc/profile.d/nix.sh \
    && nix-channel --update \
    && nix-env -iA nixpkgs.ghcid \
    && nix-env -iA nixpkgs.haskellPackages.fourmolu
