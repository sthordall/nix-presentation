---
title: Nix, NixOS and NixOps
author: Stephan Thordal Larsen (STE)
date: November 15, 2017
---


# [Nix](https://nixos.org/nix/)
<center>The Purely Functional Package Manager</center>

<section>

***

## Problem With Package Management
* Typical package managers (_yum, apt, brew etc._) mutate global state of system
* Updating package might break users
* Different versions of same package difficult
* Dependency hell

***

## Nix To The Rescue

* Installed packages are immutable and stored in `/nix/store`
  ```sh
  ls -l `which docker`
  lrwxrwxrwx 1 root root 72 Jan  1  1970 /run/current-system/sw/bin/docker -> /nix/store/30dqx7216q66chzidagjxvjik89ngv11-docker-17.09.0-ce/bin/docker
  ```
* Packages (aka. derivations) are defined in nix language

***

## Packages not from nixpkgs
- Use overlays!
- Example, [Firefox nightly](https://github.com/mozilla/nixpkgs-mozilla/blob/master/firefox-overlay.nix):
```sh
mkdir -p ~/.config/nixpkgs/overlays/
curl -L https://raw.githubusercontent.com/mozilla/nixpkgs-mozilla/master/firefox-overlay.nix > ~/.config/nixpkgs/overlays/firefox-overlay.nix
nix-env -iA nixos.latest.firefox-nightly-bin
```

***

## Modify packages
- Lorem ipsum
- Lorem ipsum

</section>

---

# [NixOS](https://nixos.org/)
<center>The Purely Functional Linux Distribution</center>

<section>

## Built on Nix
- Lorem ipsum

</section>

---

# [NixOps](https://nixos.org/nixops/)
The NixOS Cloud Deployment Tool

<section>
## Cloud mania!
- Lorem ipsum

</section>
