# nvim-config

My personal Neovim configuration, written directly in Lua.

It is not a Neovim distribution and does not aim to provide a universal setup.
It is primarily my own configuration, published as a reference, a source of inspiration, or a starting point for another configuration.

## Requirements

This configuration targets **Neovim 0.12 or later**.

Supported platforms:

### Systems

- Linux
- macOS

### Architectures

- `x86_64`
- `arm64` (`aarch64`)

### System packages

The Makefile installs portable development tools, but it does not install system packages or use a system package manager.

The following system-level prerequisites should already be available:

- Git 2.19 or later
- Bash
- curl
- FUSE on Linux to run the installed AppImage[^fuse]
- make
- sed
- tar
- a C/C++ compiler and build toolchain
- the system utilities required to compile Cargo crates and native plugins

A [Nerd Font](https://www.nerdfonts.com/) is strongly recommended because the configuration uses icons throughout the interface.

[^fuse]: If FUSE is unavailable, see the [official AppImage fallback instructions](https://docs.appimage.org/user-guide/troubleshooting/fuse.html#fallback-if-fuse-can-t-be-made-working) to extract and run the AppImage.

## Installation

### 1. Back up an existing configuration

```sh
config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"

if [ -e "${config_home}/nvim" ]; then
    mv "${config_home}/nvim" "${config_home}/nvim.backup.$(date +%Y%m%d-%H%M%S)"
fi
```

Existing Neovim data can also be moved or removed for a clean plugin and data installation:

```sh
data_home="${XDG_DATA_HOME:-${HOME}/.local/share}"

if [ -e "${data_home}/nvim" ]; then
    mv "${data_home}/nvim" "${data_home}/nvim.backup.$(date +%Y%m%d-%H%M%S)"
fi
```

This second step is optional.

### 2. Clone the repository

```sh
git clone https://github.com/matthieugalvez/nvim-config.git "${XDG_CONFIG_HOME:-${HOME}/.config}/nvim"
cd "${XDG_CONFIG_HOME:-${HOME}/.config}/nvim"
```

### 3. Install Neovim and the portable dependencies

```sh
make
```

The Makefile checks the current environment and installs missing components.

Running it again later also checks whether a newer stable Neovim release is available.

### 4. Make Neovim available in the shell

The Makefile does not modify the shell's `PATH`.

#### Linux

The default executable is installed at:

```text
$HOME/Applications/nvim.appimage
```

The Makefile also creates a symlink at:

```text
$HOME/.local/bin/nvim
```

Add the corresponding directory to the shell profile if it is not already there:

```sh
export PATH="${HOME}/.local/bin:${PATH}"
```

#### macOS

The default executable is installed at:

```text
$HOME/.local/nvim/bin/nvim
```

Add the corresponding directory to the shell profile:

```sh
export PATH="${HOME}/.local/nvim/bin:${PATH}"
```

#### Restart the shell

After the first installation, opening a new shell may be necessary for the environment changes to take effect.

### 5. Start Neovim

```sh
nvim
```

On the first launch:

1. lazy.nvim installs the configured plugins;
2. Mason installs the language tools it manages;
3. tree-sitter-manager installs parsers when required.

Useful diagnostic commands:

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
:TSManager
```

## Custom Neovim installation directory

The Neovim installation directory can be overridden through `NVIM_DIR`:

```sh
make NVIM_DIR="${HOME}/tools/neovim"
```

The resulting executable is:

| System | Executable |
| --- | --- |
| Linux | `${NVIM_DIR}/nvim.appimage` |
| macOS | `${NVIM_DIR}/bin/nvim` |

`NVIM_DIR` is the public installation parameter. The final executable path is derived from it by the Makefile.

## Components installed by the Makefile

The Makefile checks or installs:

| Component | Installation method |
| --- | --- |
| Neovim | Latest stable official release |
| Rust | rustup |
| Rust Analyzer | rustup component |
| Clippy | rustup component |
| rustfmt | rustup component |
| Node | Latest LTS release through NVM |
| npm | Installed with Node |
| fd | Cargo crate `fd-find` |
| ripgrep | Cargo crate `ripgrep` |
| tree-sitter | Cargo crate `tree-sitter-cli` |

Rust Analyzer, Clippy and rustfmt are intentionally managed by rustup rather than Mason.

## Language tooling

Mason installs most of the configured language servers, linters, and formatters. Rust tooling is managed by rustup, while OCaml tooling is expected to be provided by an active opam switch.

| Language or format | LSP and analysis | Linting and formatting |
| --- | --- | --- |
| Bash and shell | Bash Language Server | ShellCheck, shfmt |
| C and C++ | clangd with clang-tidy | clang-format |
| CSS | Biome | Biome |
| Dockerfile | Docker Language Server | dockerfmt |
| HTML | Biome | Biome |
| JavaScript and JSX | Biome | Biome |
| JSON and JSONC | Biome | Biome |
| Lua | Lua Language Server, lazydev.nvim | StyLua |
| Markdown | Biome[^biome] | Biome[^biome] |
| OCaml source and interface files | OCaml-LSP[^ocaml] | ocamlformat[^ocaml] |
| Python | ty, Ruff | Ruff |
| Rust | rust-analyzer, Clippy | rustfmt |
| SCSS | Biome[^biome] | Biome[^biome] |
| TOML | Taplo | Taplo |
| TypeScript and TSX | Biome | Biome |
| YAML | Biome[^biome] | Biome[^biome] |
| Zig | ZLS | ZLS (LSP formatting) |

[^biome]: Biome support for SCSS, YAML, and Markdown is still in progress. These file types are preconfigured in Conform, so formatting will become available once Biome supports them. LSP support will also require the corresponding Neovim LSP configuration to recognize them.

[^ocaml]: OCaml tooling is managed outside this repository. `ocamllsp` is enabled only when the executable is available in Neovim's `PATH`, and Conform uses `ocamlformat` when available, typically from the active opam switch.

LSP completion capabilities are provided by Blink CMP.

File-operation capabilities from nvim-file-operations are also exposed to LSP servers so that supported servers can follow file creation, deletion and renaming operations.

## Formatting

Conform formats supported buffers automatically before saving.

When no dedicated formatter is available, LSP formatting is used as a fallback.

Manual formatting is available in normal and visual mode:

| Mapping | Action |
| --- | --- |
| `<leader>f` | Format the current buffer or visual selection |

## Main key mappings

The leader key is `Space`.

### General

| Mapping | Action |
| --- | --- |
| `<leader>l` | Open lazy.nvim |
| `<leader>m` | Open Mason |
| `<leader>s` | Open Tree-sitter Manager |
| `<leader>d` | Clear search highlighting |
| `<C-Left>` | Move to the window on the left |
| `<C-Right>` | Move to the window on the right |
| `<C-Down>` | Move to the window below |
| `<C-Up>` | Move to the window above |

### Navigation

| Mapping | Action |
| --- | --- |
| `<C-h>` | Toggle Neo-tree |
| `<leader>tf` | Find files |
| `<leader>tg` | Search text with live grep |
| `<leader>tb` | Find open buffers |
| `<leader>tx` | Search for the word under the cursor |

Inside Telescope, `<C-j>` and `<C-k>` move through the result list.

Files opened from Neo-tree use nvim-window-picker to select the destination window when necessary.

## Main plugins

### Completion and editing

- blink.cmp
- nvim-autopairs

### Display

- blink.indent
- gitsigns.nvim
- render-markdown.nvim

### Interface

- dashboard-nvim
- lualine.nvim
- which-key.nvim

### Navigation

- telescope.nvim
- neo-tree.nvim
- nvim-window-picker

### Notifications

- fidget.nvim
- nvim-notify

### Theme

- kanagawa.nvim

### Development tools

- nvim-lspconfig
- mason.nvim
- mason-lspconfig.nvim
- mason-tool-installer.nvim
- conform.nvim
- tree-sitter-manager.nvim

Exact plugin revisions are recorded in `lazy-lock.json`.

## Updating

Update the configuration and re-run the environment checks with:

```sh
cd "${XDG_CONFIG_HOME:-${HOME}/.config}/nvim"
git pull
make
```

Then choose how plugin revisions should be handled.

To restore the plugin revisions recorded in `lazy-lock.json`:

```vim
:Lazy restore
```

To update plugins to the latest revisions allowed by their specifications:

```vim
:Lazy sync
```

Updating plugins modifies `lazy-lock.json` locally.

## Repository structure

```text
.
├── lua
│   ├── config
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── settings.lua
│   └── plugins
│       ├── autocomplete
│       ├── display
│       ├── interface
│       ├── navigation
│       ├── notifications
│       ├── theme
│       └── tools
├── init.lua
├── lazy-lock.json
├── LICENSE
├── Makefile
└── README.md
```

The root `init.lua` loads `lua/config/init.lua`, which then loads the editor settings, global key mappings and lazy.nvim bootstrap.

Plugin specifications are grouped by purpose under `lua/plugins`.

## Scope

This repository reflects my own workflow and preferences.

It may change without preserving compatibility with existing forks. It is published as a personal configuration that can be studied, adapted or used as a starting point, rather than as a maintained Neovim distribution.

## License

This project is licensed under the [MIT License](LICENSE).
