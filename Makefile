NVIM ?= ${HOME}/appimage/nvim.appimage
NVIM_LATEST_API := https://api.github.com/repos/neovim/neovim/releases/latest
NVIM_APPIMAGE_URL := https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

NVM_DIR ?= ${HOME}/.nvm
NVM_INSTALL_URL := https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh

all: check-nvim  check-dependencies

check-nvim:
	@if [ ! -x "${NVIM}" ]; then \
		echo "Neovim n'est pas installé"; \
		${MAKE} --no-print-directory get-nvim; \
	else \
		${MAKE} --no-print-directory check-version; \
	fi

check-version:
	@installed_version=$$("${NVIM}" --version | sed -n '1s/^NVIM[[:space:]]*//p'); \
	latest_version=$$( \
		curl -fsSL "${NVIM_LATEST_API}" \
		| sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
	); \
	if [ -z "$$installed_version" ] || [ -z "$$latest_version" ]; then \
		echo "Impossible de déterminer la version de Neovim" >&2; \
		exit 1; \
	fi; \
	printf "Version installée : %s\n" "$$installed_version"; \
	printf "Dernière stable   : %s\n" "$$latest_version"; \
	if [ "$$installed_version" = "$$latest_version" ]; then \
		echo "Neovim est à jour"; \
	else \
		echo "Une mise à jour de Neovim est disponible"; \
		${MAKE} --no-print-directory get-nvim; \
	fi

get-nvim:
	@mkdir -p "$$(dirname "${NVIM}")"
	@curl -fL -o "${NVIM}.tmp" "${NVIM_APPIMAGE_URL}"
	@chmod u+x "${NVIM}.tmp"
	@mv "${NVIM}.tmp" "${NVIM}"
	@echo "Neovim mis à jour avec succès"

check-dependencies: check-rust check-node
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	fd --version >/dev/null 2>&1 || \
	cargo install --locked fd-find
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	rg --version >/dev/null 2>&1 || \
	cargo install --locked ripgrep
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	tree-sitter --version >/dev/null 2>&1 || \
	cargo install --locked tree-sitter-cli
	@echo "Dépendances OK"

check-rust:
	@rustup --version >/dev/null 2>&1 && \
	rustc --version >/dev/null 2>&1 && \
	cargo --version >/dev/null 2>&1 && \
	rust-analyzer --version >/dev/null 2>&1 && \
	cargo clippy --version >/dev/null 2>&1 && \
	rustfmt --version >/dev/null 2>&1 || \
	${MAKE} --no-print-directory get-rust

get-rust:
	@rustup --version >/dev/null 2>&1 || \
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
	sh -s -- -y
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	rustup component add rust-analyzer clippy rustfmt
	@echo "Rust installé"

check-node:
	@node --version >/dev/null 2>&1 && \
	npm --version >/dev/null 2>&1 || \
	${MAKE} --no-print-directory get-node

get-node:
	@if [ ! -s "${NVM_DIR}/nvm.sh" ]; then \
		export NVM_DIR="${NVM_DIR}"; \
		curl -fsSL "${NVM_INSTALL_URL}" | bash; \
	fi
	@export NVM_DIR="${NVM_DIR}"; \
	. "${NVM_DIR}/nvm.sh"; \
	nvm install --lts; \
	nvm alias default 'lts/*'; \
	nvm use default
	@echo "Node et npm installés"

.PHONY: check-nvim check-version get-nvim check-dependencies check-rust check-node get-rust get-node
