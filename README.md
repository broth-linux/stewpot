# Broth Linux

A minimal, terminal-driven, source-based Linux distribution built for simplicity, speed, and POSIX purity.

---

## Features

* **Minimal Footprint:** No system bloat, unnecessary daemons, or heavy desktop environments.
* **Source-Based Package Management:** Fast, transparent shell-based tooling for compiling and maintaining software.
* **Simple Toolchain:** Intuitive culinary-themed utilities designed to do one thing well.
* **Custom Distro Identity:** Native OS release tracking and custom ASCII fetch integration out of the box.

---

## The Broth Toolkit

Broth Linux uses a modular set of standalone POSIX shell utilities to manage packages and system maintenance:

* **`pantry`**: Source repository and package registry management.
* **`prepare`**: Dependency checking and build environment configuration.
* **`stewpot`**: Core package builder and build orchestration engine.
* **`spill`**: Clean package removal and file scraper.
* **`dishwash`**: Cache, temporary directory, and build artifact cleaner.
* **`recipes/`**: Declarative directory containing all source build manifests.

---

## Architectural Philosophy & Heritage

Broth Linux synthesizes three distinct lineages of source-based computing to build a lean, pragmatic, and self-hosting OS:

* **Source Mage Heritage (`chef`):** Reviving the interactive, declarative recipe workflow of Source Mage. Package selection and build orchestration happen through `chef`—an interactive terminal interface paired with automated dependency tracking (`autodepends`)—without relying on bitrotted grimoires or complex scripting baggage.
* **KISS Radical Minimalism:** Anchored entirely to a `musl libc` and `BusyBox` base. The distribution eliminates `glibc`, `systemd`, and monolithic GNU coreutils abstractions. Every package builds through plain, transparent POSIX shell recipes (`.rsc`) logging manifests directly to `/var/db/stew/installed/`.
* **Slackware Pragmatism:** Following the classic principle of stripping away fragile tooling layers in favor of predictable, debuggable shell utilities. Software compiles as close to upstream as possible, prioritizing raw system stability, clean `DESTDIR` staging, and user sovereignty over opaque packaging automation.

---

## Getting Started

### Installation
For full instructions on partitioning, extracting the rootfs tarball, and configuring your bootloader, read the installation guide:

**[View INSTALL.md](INSTALL.md)**

### Quick Usage

**Build and install a package:**
```sh
stewpot build <recipe-name>
```

**Remove a package:**
```sh
spill <package-name>
```

**Clean build caches and temp files:**
```sh
dishwash
```

---

## Contributing

Contributions, bug reports, and new recipes are welcome. Submit pull requests to the `recipes/` directory adhering to the minimal POSIX shell guidelines.

---

## License

This project is licensed under the [MIT License](LICENSE).
