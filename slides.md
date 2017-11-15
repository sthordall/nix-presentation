# [Nix](https://nixos.org/nix/)

The Purely Functional Package Manager

-----

### Conventional Package Management

* Typical package managers (_yum, apt, brew etc._) mutate global state of system
* Updating package might break users
* Different versions of same package difficult
* Dependency hell

-----

## Nix To The Rescue

* Installed packages are immutable and stored in `/nix/store`

```bash
/nix/store/30dqx7216q66chzidagjxvjik89ngv11-docker-17.09.0-ce/
├── bin
│   ├── docker
│   └── dockerd
└── ...
```

* Packages (a.k.a. derivations) are defined in Nix language

-----

## Packages not from nixpkgs

- Use overlays!
- Example, [Firefox nightly](https://github.com/mozilla/nixpkgs-mozilla/blob/master/firefox-overlay.nix):

```sh
mkdir -p ~/.config/nixpkgs/overlays/
curl -L https://raw.githubusercontent.com/mozilla/nixpkgs-mozilla/master/firefox-overlay.nix > ~/.config/nixpkgs/overlays/firefox-overlay.nix
nix-env -iA nixos.latest.firefox-nightly-bin
```

-----

## Modify packages

- Lorem ipsum
- Lorem ipsum

=====

# [NixOS](https://nixos.org/)

The Purely Functional Linux Distribution

## Built on Nix

- Lorem ipsum

=====

# [NixOps](https://nixos.org/nixops/)

The NixOS Cloud Deployment Tool

## Cloud mania!

- Lorem ipsum
