NVIM ?= ${HOME}/appimage/nvim.appimage
NVIM_LATEST_API := https://api.github.com/repos/neovim/neovim/releases/latest
NVIM_APPIMAGE_URL := https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

NVM_DIR ?= ${HOME}/.nvm
NVM_INSTALL_URL := https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh

RESET	=	\033[0m
NLINE	=	${RESET}\033[0K\n
BLINE	=	${RESET}\033[0K\r
GREEN	=	\033[32m
YELLOW	=	\033[33m
BLUE	=	\033[34m
RED		=	\033[31m

all: check-nvim  check-dependencies

check-nvim:
	@if [ ! -x "${NVIM}" ]; then \
		printf "${YELLOW}Neovim n'est pas installé${NLINE}"; \
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
		printf "${RED}Impossible de déterminer la version de Neovim${NLINE}" >&2; \
		exit 1; \
	fi; \
	printf "${BLUE}Version installée : %s${NLINE}" "$$installed_version"; \
	printf "${BLUE}Dernière stable   : %s${NLINE}" "$$latest_version"; \
	if [ "$$installed_version" = "$$latest_version" ]; then \
		printf "${GREEN}Neovim est à jour${NLINE}"; \
	else \
		printf "${BLUE}Une mise à jour de Neovim est disponible${NLINE}"; \
		${MAKE} --no-print-directory get-nvim; \
	fi

get-nvim:
	@printf "${BLUE}installation de Neovim...${BLINE}"
	@mkdir -p "$$(dirname "${NVIM}")"
	@curl -fLsS -o "${NVIM}.tmp" "${NVIM_APPIMAGE_URL}"
	@chmod u+x "${NVIM}.tmp"
	@mv "${NVIM}.tmp" "${NVIM}"
	@printf "${GREEN}Neovim OK${NLINE}"

check-dependencies: check-rust check-node
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	if ! fd --version >/dev/null 2>&1; then \
		printf "${BLUE}Installation de fd-find...${BLINE}"; \
		cargo -q install --locked fd-find; \
	fi
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	if ! rg --version >/dev/null 2>&1; then \
		printf "${BLUE}Installation de ripgrep...${BLINE}"; \
		cargo -q install --locked ripgrep; \
	fi
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	if ! tree-sitter --version >/dev/null 2>&1; then \
		printf "${BLUE}Installation de tree-sitter-cli...${BLINE}"; \
		cargo -q install --locked tree-sitter-cli; \
	fi
	@printf "${GREEN}Dépendances OK${NLINE}"

check-rust:
	@rustup --version >/dev/null 2>&1 && \
	rustc --version >/dev/null 2>&1 && \
	cargo --version >/dev/null 2>&1 && \
	rust-analyzer --version >/dev/null 2>&1 && \
	cargo clippy --version >/dev/null 2>&1 && \
	rustfmt --version >/dev/null 2>&1 || \
	${MAKE} --no-print-directory get-rust

get-rust:
	@printf "${BLUE}installation des composants Rust...${BLINE}"
	@rustup --version >/dev/null 2>&1 || \
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
	sh -s -- -y --profile minimal
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	rustup -q component add rust-analyzer clippy rustfmt
	@printf "${GREEN}Rust installé${NLINE}"

check-node:
	@node --version >/dev/null 2>&1 && \
	npm --version >/dev/null 2>&1 || \
	${MAKE} --no-print-directory get-node

get-node:
	@printf "${BLUE}installation de node...${BLINE}"
	@if [ ! -s "${NVM_DIR}/nvm.sh" ]; then \
		export NVM_DIR="${NVM_DIR}"; \
		curl -fsSL "${NVM_INSTALL_URL}" | bash; \
	fi
	@export NVM_DIR="${NVM_DIR}"; \
	. "${NVM_DIR}/nvm.sh"; \
	nvm install --lts --default --no-progress >/dev/null
	@printf "${GREEN}Node installé${NLINE}"

.PHONY: all check-nvim check-version get-nvim check-dependencies check-rust check-node get-rust get-node
