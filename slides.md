## Nix, NixOS & NixOps
#### Declare and Reproduce


=====

# [Nix](https://nixos.org/nix/)

The Purely Functional Package Manager

-----

### Conventional Package Management

* Typical package managers (_yum, apt, brew etc._) mutate global system state
  -> __Dependency Hell__
* Different versions of same package is difficult and often impossible
* Hell for package maintainers
* Easy to break system and difficult to keep consistent
* Rolling releases are painful

-----

### Nix - Yet another package manager?
* Reproducibility
* Easy rollbacks
* Multi-user support
* Simultaneous installs of different versions of the same package
* Simultaneous installs of packages with different dependencies
* Painfree rolling releases

-----

### Nix Details

* Packages (derivations) are defined in Nix language
* All packages have unique hash id, created from content
* Packages are installed into read-only `/nix/store`
* Upgrades and rollbacks are atomic
* Immutable packages, upgrades -> different hash

```sh
/nix/store/30dqx7216q66chzidagjxvjik89ngv11-docker-17.09.0-ce/
├── bin
│   ├── docker
│   └── dockerd
└── ...
```

-----

### Nix Details

* Each package references exact versions of dependent packages

```sh
> ldd `which sh`
        linux-vdso.so.1 (0x00007ffda5bde000)
        libreadline.so.7 => /nix/store/lwqixmv3n17xi0rfwxpff2k5s7g7c65x-readline-7.0p3/lib/libreadline.so.7 (0x00007f2589963000)
        libhistory.so.7 => /nix/store/lwqixmv3n17xi0rfwxpff2k5s7g7c65x-readline-7.0p3/lib/libhistory.so.7 (0x00007f2589759000)
        libncursesw.so.6 => /nix/store/1q57mlk9s77cy0nlzs2z9srhxrwxni8d-ncurses-6.0/lib/libncursesw.so.6 (0x00007f25894ee000)
...
```

-----

###  Nix Details

* All versions stored side-by-side in `/nix/store`
```sh
> tree -L 1 /nix/store | grep docker-17
├── 1b8kmi2grdarh4g93cj7r461l6jnnwrn-docker-17.03.2-ce-man
├── 2pmcjqvjdhcibjpbydygzjcsdfmrhnim-docker-17.06.2-ce
├── 30dqx7216q66chzidagjxvjik89ngv11-docker-17.09.0-ce
├── a75dmp47dgqqvf6a816z80yyl4ngrsy0-docker-17.03.2-ce
├── afxl55bd8p7jx6f75z7n0ld5qni258bp-docker-17.03.2-ce
├── j9y5ibqcvm4lw1qd8xigydyn8fawr3zg-docker-17.09.0-ce.drv
├── kg854daav26ysmcliy89wcfk6ngj4nrj-docker-17.09.0-ce.drv
├── klrrwkzfb5j8a70fbk5aldg61iizfyb9-docker-17.03.2-ce.drv
├── md5nsqwi75qw4vrjd7ffrrs3hllsvzs3-docker-17.03.2-ce.drv
├── mlfgafwzs2yr14385wclhcdbd79ckigl-docker-17.09.0-ce-man
├── ri0bh2gjq62mkmi37wzs34lf1nlryy2m-docker-17.03.2-ce-man
├── s9qal5mmdc2bsbigkpixz6gg2dqdj0y6-docker-17.09.0-ce
├── v5wc9yl973bgd8hsv51s907888yrvgcg-docker-17.09.0-ce-man
├── v937hh67jbjrjl5mzvqk4w8vygfnx8cn-docker-17.06.2-ce.drv
├── yp4v7l7b7xgmk9vjc8b3qmvc1yq8x8md-docker-17.06.2-ce-man
```

-----

### Profiles
* `nix-env -i docker-ce`
* `nix-env -q`
* `nix-env -qa '.*vim.*'`
* `nix-env -e emacs`
* `nix-env --list-generations`
* `nix-env --rollback`
* `nix-env -G 4`

-----

### Use for trying packages

* Use tool `nix-shell`
* Opens shell with environment specificied in file or argument

```sh
nix-shell -p redis-desktop-manager
```


-----

### Collect Garbage


* Old unused packages can be garbage collected

```sh
> nix-collect-garbage -d
```

-----

### Nix Language
* Functional
* Weak type system
* Lazy
* Used for everything Nix
* Expressions are deterministic = reproducibility

-----

### Use for builds

* Use tool `nix-build`
* Reproducible builds
* Output is sent as derivation to `/nix/store`
* Demo of `mdslider`

-----

### Overlays

* Allows for modification and override of packages
* Example, [Firefox nightly](https://github.com/mozilla/nixpkgs-mozilla/blob/master/firefox-overlay.nix):

```sh
mkdir -p ~/.config/nixpkgs/overlays/
curl -L https://raw.githubusercontent.com/mozilla/nixpkgs-mozilla/master/firefox-overlay.nix > ~/.config/nixpkgs/overlays/firefox-overlay.nix
nix-env -iA nixos.latest.firefox-nightly-bin
```

=====

# [NixOS](https://nixos.org/)

The Purely Functional Linux Distribution

-----

### Built on Nix

* Declarative system configuration through Nix files
* All system packages and services configuration managed with Nix
* Reproducible systems
* Easy rollbacks through grub

-----

### Declarative Development Environment
* Global system config in `/etc/nixos/configuration.nix`
* All configuration version controlled
* Easy to share configurations and problems
* Great for keeping multiple machines in sync
* Perfect if you like to tinker and screw up your system

-----

### Package updates

* Upgrades and rollbacks are atomic
* New version of package
*  -> New hash id
*  -> New entry in `/nix/store`

```sh
> ls -l `which docker`
lrwxrwxrwx 1 root root 72 Jan  1  1970 /run/current-system/sw/bin/docker -> /nix/store/afxl55bd8p7jx6f75z7n0ld5qni258bp-docker-17.03.2-ce/bin/docker

```

```sh
> ls -l `which docker`
lrwxrwxrwx 1 root root 72 Jan  1  1970 /run/current-system/sw/bin/docker -> /nix/store/30dqx7216q66chzidagjxvjik89ngv11-docker-17.09.0-ce/bin/docker
```

-----

### Building System

* `nixos-rebuild switch`
* `nixos-rebuild boot`
* `nixos-rebuild test`
* `nixos-rebuild build-vm`

-----


### Phoenix
* Used for running local Docker vbox
* Coupled with Docker Compose results in maximum declarativeness and
  reproducibility


-----

### NixOS Demo

=====

# [NixOps](https://nixos.org/nixops/)

The NixOS Cloud Deployment Tool

-----

### NixOps Details
* Uses SSH to deploy nix configs to series of servers
* Use Nix to declare cloud instances or vbox

```sh
nixops create ./setup.nix ./ec2.nix -d webserver-ec2
nixops deploy -d webserver-ec2
nixops info -d webserver-ec2
nixops destroy -d webserver-ec2
```
-----

### NixOps Demo
