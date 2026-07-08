NVIM ?= ${HOME}/appimage/nvim.appimage
NVIM_LATEST_API := https://api.github.com/repos/neovim/neovim/releases/latest
NVIM_APPIMAGE_URL := https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

check-nvim:
	@if [ ! -x "${NVIM}" ]; then \
		echo "Neovim n'est pas installé"; \
		${MAKE} --no-print-directory get-appimage; \
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
		${MAKE} --no-print-directory get-appimage; \
	fi

get-appimage:
	@mkdir -p "$$(dirname "${NVIM}")"
	@curl -fL -o "${NVIM}.tmp" "${NVIM_APPIMAGE_URL}"
	@chmod u+x "${NVIM}.tmp"
	@mv "${NVIM}.tmp" "${NVIM}"
	@echo "Neovim mis à jour avec succès"

.PHONY: check-nvim check-version get-appimage
