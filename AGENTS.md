# Agentic Coding Guidelines

This repository contains the system configuration for macOS using `nix-darwin` and `home-manager` with Nix Flakes.
It is currently configured for a single host (`mac-ycf`), but is designed to be extensible for future machines.

## 1. Environment & Build Commands

### System Information
- **Platform**: `aarch64-darwin` (Apple Silicon)
- **Host**: `MAC-YCF`
- **User**: `yuchenfei`
- **Package Manager**: Nix (Flakes enabled)

### Core Commands

**Build & Switch System Configuration:**
To apply changes to the system or user configuration:
```bash
# Build and activate the configuration for the current host
darwin-rebuild switch --flake .#MAC-YCF
```

**Build Only (Dry Run):**
To verify the configuration compiles without applying it:
```bash
darwin-rebuild build --flake .#MAC-YCF
```

**Format Code:**
This project uses `nixfmt-rfc-style` for formatting.
```bash
# Format a specific file
nixfmt path/to/file.nix

# Format all files (if standard globbing works, otherwise individual files)
# Typical usage:
find . -name "*.nix" -exec nixfmt {} +
```

**Update Dependencies:**
To update flake inputs (e.g., nixpkgs, home-manager):
```bash
nix flake update
```

**Garbage Collection:**
GC is automated in `configuration.nix`, but can be triggered manually:
```bash
nix-collect-garbage -d
```

### Verification
Since this is a configuration repo, "testing" primarily involves:
1.  **Syntax Check**: Ensure `nixfmt` passes.
2.  **Build Check**: Run `darwin-rebuild build` to ensure the derivation evaluates successfully.
3.  **Flake Check**: Run `nix flake check` to verify flake outputs.

---

## 2. Code Style & Conventions

### Formatting
- **Indentation**: 2 spaces. No tabs.
- **Line Length**: Soft limit around 80-100 characters, but readable indentation is prioritized.
- **Formatter**: Strictly adhere to `nixfmt` style (RFC 166 style).

### File Structure & Organization
- **Flake Entry**: `flake.nix` is the source of truth. It defines inputs and exports `darwinConfigurations`.
- **Hosts**: Machine-specific configs live in `hosts/<hostname>/`.
    - `configuration.nix`: System-level settings (nix-darwin).
    - `home.nix`: User-level settings (home-manager).
- **Modules**: Reusable logic goes into:
    - `darwinModules/`: System modules (e.g., Homebrew, networking).
    - `homeManagerModules/`: User modules (e.g., shell, git, gui programs).
- **Dotfiles Linking**:
    - Use `mkOutOfStoreSymlink` (from `home-manager`) to link config files from `config/` to `~/.config/`.
    - **Crucial**: This allows editing files in `config/` directly without rebuilding, effectively "hot-reloading" app configs.
    - Example:
      ```nix
      # In home.nix or a module
      xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/nvim";
      ```

### Naming Conventions
- **Files**: camelCase (e.g., `cliPrograms`, `guiPrograms`) or kebab-case for specific tools (`sketchybar.nix`).
- **Variables**: camelCase (e.g., `dotfilesDir`, `linkConfig`).
- **Attributes**: Follow upstream Nixpkgs conventions (camelCase).

### Dependency Management (Adding Packages)
1.  **Nix Packages**:
    - Search: [search.nixos.org](https://search.nixos.org/packages)
    - Add to `home.packages` in `home.nix` or the relevant module in `homeManagerModules`.
    - Prefer modules (e.g., `programs.git.enable = true;`) over raw packages when available for better integration.

2.  **Homebrew Packages**:
    - Used for GUI apps (Casks) or tools not well-supported in Nix.
    - Managed via `nix-homebrew` in `configuration.nix` or `darwinModules/homebrew.nix`.
    - **Taps**: Add to `flake.nix` inputs *and* `homebrew.brews` / `homebrew.casks`.

### Imports
- Use relative imports.
- List imports vertically.
```nix
imports = [
  ./module-a.nix
  ./module-b.nix
];
```

### Error Handling & Safety
- **Parameterization**: Pass `inputs`, `outputs`, `user`, etc., via `specialArgs` (Nix-Darwin) or `extraSpecialArgs` (Home Manager) to avoid hardcoding.
- **Safe Linking**: When adding new dotfiles, verify the target location doesn't contain a real directory/file that would block the symlink.
- **Refactoring**: When moving code to a module, ensure all dependencies (pkgs, lib, config) are passed to the new file.

### Comments
- Use `#` for comments.
- Comment *why* a specific setting is enabled if it's not obvious (e.g., specific macOS hacks).
- Comment expected manual steps if automation isn't possible.

---

## 3. Workflow for Agents

When asked to modify this configuration:

1.  **Locate**: Find the relevant module.
    - Shell tools? Check `homeManagerModules/cliPrograms/`.
    - GUI apps? Check `homeManagerModules/guiPrograms/`.
    - System settings (dock, finder)? Check `hosts/mac-ycf/configuration.nix`.
2.  **Edit**: Apply changes adhering to the style above.
3.  **Verify**:
    - Always run `nixfmt` on the file you edited.
    - Suggest the user run `darwin-rebuild build --flake .#MAC-YCF` to check for evaluation errors.
    - **Do not** run `switch` automatically unless explicitly asked, as it changes the user's active system state.

### Common Patterns
**Adding a CLI tool:**
Create `homeManagerModules/cliPrograms/toolname.nix`:
```nix
{ pkgs, ... }:
{
  home.packages = [ pkgs.toolname ];
}
```
Then import it in `homeManagerModules/cliPrograms/common.nix` or `default.nix`.

**Adding a GUI App (Cask):**
Edit `darwinModules/homebrew.nix` (or wherever `homebrew` is configured):
```nix
homebrew.casks = [
  "existing-app"
  "new-app"
];
```

**Linking a Config File:**
1. Place config in `config/toolname/config.toml`.
2. In `home.nix` or module:
```nix
xdg.configFile."toolname/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/toolname/config.toml";
```

---

## 4. Cursor / Copilot Rules
*No specific .cursorrules or Copilot instructions found. Follow standard Agentic AI best practices and the guidelines above.*
