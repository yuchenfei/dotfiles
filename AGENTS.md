# Dotfiles Guidelines

Personal Nix flakes repository (`nix-darwin` + Home Manager) managing three hosts:

- `MAC-YCF` (`aarch64-darwin`, `hosts/mac-ycf/`): nix-darwin + embedded Home Manager, Homebrew, agenix, desktop tools (Kitty, yabai, skhd, SketchyBar).
- `yuchenfei@ubuntu-ycf` (`x86_64-linux`, `hosts/ubuntu-ycf/`): standalone Home Manager with full CLI setup.
- `yuchenfei@Voron` (`aarch64-linux`, `hosts/voron/`): standalone Home Manager minimal setup (`NVIM_PROFILE=lite`).

## Layout

- `darwinModules/`: shared macOS system modules.
- `homeManagerModules/`: reusable CLI/GUI modules (`cliPrograms/`, `guiPrograms/`) and `lib/link-config.nix`.
- `config/`: raw application configs. Most are live-symlinked into `~/.config/` via `mkOutOfStoreSymlink` (`link-config.nix`), so edits take effect immediately for running apps without a rebuild.
- `scripts/macOS/`: macOS helper scripts.
- `secrets/`: agenix-encrypted secrets and `secrets.nix`.

## Build & Verify

Build without activating unless explicitly asked to switch (run on matching platform):

- macOS build: `darwin-rebuild build --flake .#MAC-YCF` (activate: `sudo darwin-rebuild switch --flake .#MAC-YCF`)
- Linux build: `nix build '.#homeConfigurations."yuchenfei@ubuntu-ycf".activationPackage'` (or `yuchenfei@Voron`; activate: `home-manager switch --flake '.#yuchenfei@ubuntu-ycf'`)
- Nix lint/format: `nixfmt`, `statix check`
- Lua/TOML format: `stylua` (respect per-dir `.stylua.toml`), `taplo` (`config/yazi/.taplo.toml`)
- Shell scripts: `bash -n scripts/macOS/<script>.sh`
- Neovim (`config/nvim/`): uses built-in `vim.pack` (`nvim-pack-lock.json`); test shared changes in both `nvim` and `NVIM_PROFILE=lite nvim`.

## Conventions & Guardrails

- Place reusable tool configs in `homeManagerModules/` named after the app; keep host overrides in `hosts/<host>/`.
- Yazi plugins are managed outside Nix by `ya` (`config/yazi/package.toml`)—do not move them into Home Manager.
- Never commit plaintext keys, tokens, or decrypted secrets; use the `secrets/` agenix workflow.
- Avoid updating `flake.lock` or touching unrelated hosts/packages unless requested.
- Commits follow Conventional Commits (e.g., `feat(nvim): ...`, `fix(home): ...`).
