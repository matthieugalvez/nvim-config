UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

NVIM_ARCH := $(shell \
	printf '%s\n' "${UNAME_M}" \
	| sed 's/^aarch64$$/arm64/' \
	)

SUPPORTED_NVIM_SYSTEMS	:= Linux Darwin
SUPPORTED_NVIM_ARCHS	:= x86_64 arm64

$(if $(filter ${UNAME_S},${SUPPORTED_NVIM_SYSTEMS}),,\
	$(error Unsupported system: ${UNAME_S}))

$(if $(filter ${NVIM_ARCH},${SUPPORTED_NVIM_ARCHS}),,\
	$(error Unsupported architecture: ${UNAME_M}))

RESET	:= \033[0m
LCLEAR	:= \033[0K
GREEN	:= \033[32m
YELLOW	:= \033[33m
BLUE	:= \033[34m
RED		:= \033[31m

BLINE	:= ${RESET}${LCLEAR}\r
NLINE	:= ${RESET}${LCLEAR}\n

all: check-nvim  check-dependencies

.PHONY: all
.NOTPARALLEL:

################################################################################
#                                                                              #
#                                     NVIM                                     #
#                                                                              #
################################################################################

ifeq (${UNAME_S},Linux)
NVIM_DIR	?= ${HOME}/Applications/
NVIM		:= ${NVIM_DIR}/nvim.appimage
NVIM_ASSET	:= nvim-linux-${NVIM_ARCH}.appimage
endif

ifeq (${UNAME_S},Darwin)
NVIM_DIR	?= ${HOME}/.local/nvim
NVIM		:= ${NVIM_DIR}/bin/nvim
NVIM_ASSET	:= nvim-macos-${NVIM_ARCH}.tar.gz
endif

NVIM_LATEST_API		:= https://api.github.com/repos/neovim/neovim/releases/latest
NVIM_DOWNLOAD_URL	:= https://github.com/neovim/neovim/releases/latest/download/${NVIM_ASSET}

check-nvim:
	@if [ ! -x "${NVIM}" ]; then \
		printf "${YELLOW}Neovim is not installed${NLINE}"; \
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
		printf "${RED}Unable to determine the Neovim version${NLINE}" >&2; \
		exit 1; \
	fi; \
	printf "${BLUE}Installed version: %s${NLINE}" "$$installed_version"; \
	printf "${BLUE}Latest stable version: %s${NLINE}" "$$latest_version"; \
	if [ "$$installed_version" = "$$latest_version" ]; then \
		printf "${GREEN}Neovim is up to date${NLINE}"; \
	else \
		printf "${BLUE}A Neovim update is available${NLINE}"; \
		${MAKE} --no-print-directory get-nvim; \
	fi

get-nvim:
	@printf "${BLUE}Installing Neovim...${BLINE}"
ifeq (${UNAME_S},Linux)
	@mkdir -p "${NVIM_DIR}"
	@curl -fLsS -o "${NVIM}.tmp" "${NVIM_DOWNLOAD_URL}"
	@chmod u+x "${NVIM}.tmp"
	@mv "${NVIM}.tmp" "${NVIM}"
	@mkdir -p "${HOME}/.local/bin"
	@ln -sfT "${NVIM}" "${HOME}/.local/bin/nvim"
else ifeq (${UNAME_S},Darwin)
	@case "${NVIM_DIR}" in \
		""|"${HOME}"|*/) \
			printf "${RED}Unsafe NVIM_DIR: %s${NLINE}" "${NVIM_DIR}" >&2; \
			exit 1; \
			;; \
	esac
	@rm -rf "${NVIM_DIR}.tmp"
	@mkdir -p "${NVIM_DIR}.tmp"
	@curl -fLsS \
		-o "${NVIM_DIR}.tar.gz.tmp" \
		"${NVIM_DOWNLOAD_URL}"
	@xattr -c "${NVIM_DIR}.tar.gz.tmp"
	@tar -xzf "${NVIM_DIR}.tar.gz.tmp" \
		--strip-components=1 \
		-C "${NVIM_DIR}.tmp"
	@test -x "${NVIM_DIR}.tmp/bin/nvim"
	@rm -f "${NVIM_DIR}.tar.gz.tmp"
	@rm -rf "${NVIM_DIR}"
	@mv "${NVIM_DIR}.tmp" "${NVIM_DIR}"
endif
	@printf "${GREEN}Neovim OK${NLINE}"

.PHONY: check-nvim check-version get-nvim

################################################################################
#                                                                              #
#                                DEPENDENCIES                                  #
#                                                                              #
################################################################################

NVM_DIR			?= ${HOME}/.nvm
NVM_INSTALL_URL	:= https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh

check-dependencies: check-rust check-node
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	if ! fd --version >/dev/null 2>&1; then \
		printf "${BLUE}Installing fd-find...${BLINE}"; \
		cargo -q install --locked fd-find; \
	fi
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	if ! rg --version >/dev/null 2>&1; then \
		printf "${BLUE}Installing ripgrep...${BLINE}"; \
		cargo -q install --locked ripgrep; \
	fi
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	if ! tree-sitter --version >/dev/null 2>&1; then \
		printf "${BLUE}Installing tree-sitter-cli...${BLINE}"; \
		cargo -q install --locked tree-sitter-cli; \
	fi
	@printf "${GREEN}Dependencies OK${NLINE}"

check-rust:
	@rustup --version >/dev/null 2>&1 && \
	rustc --version >/dev/null 2>&1 && \
	cargo --version >/dev/null 2>&1 && \
	rust-analyzer --version >/dev/null 2>&1 && \
	cargo clippy --version >/dev/null 2>&1 && \
	rustfmt --version >/dev/null 2>&1 || \
	${MAKE} --no-print-directory get-rust

get-rust:
	@printf "${BLUE}Installing Rust components...${BLINE}"
	@rustup --version >/dev/null 2>&1 || \
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
	sh -s -- -y --profile minimal
	@export PATH="${HOME}/.cargo/bin:$$PATH"; \
	rustup -q component add rust-analyzer clippy rustfmt
	@printf "${GREEN}Rust installed${NLINE}"

check-node:
	@node --version >/dev/null 2>&1 && \
	npm --version >/dev/null 2>&1 || \
	${MAKE} --no-print-directory get-node

get-node:
	@printf "${BLUE}Installing Node...${BLINE}"
	@if [ ! -s "${NVM_DIR}/nvm.sh" ]; then \
		export NVM_DIR="${NVM_DIR}"; \
		curl -fsSL "${NVM_INSTALL_URL}" | bash; \
	fi
	@export NVM_DIR="${NVM_DIR}"; \
	. "${NVM_DIR}/nvm.sh"; \
	nvm install --lts --default --no-progress >/dev/null
	@printf "${GREEN}Node installed${NLINE}"

.PHONY: check-dependencies check-rust check-node get-rust get-node
