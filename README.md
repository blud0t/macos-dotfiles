# macOS Dotfiles

macOS setup featuring **Zsh + Powerlevel10k**, **WezTerm**, **VS Code**, **Zed**, and **Homebrew**.
All configs are maintained as direct file copies, NOT symlinks.

---

## 1. Prerequisites

Run these commands before applying configs:

Install Xcode Command Line Tools:

```bash
xcode-select --install
```

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
```

Add Homebrew to current session PATH:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

## 2. Clone, Install Packages, and Configure

### Clone Repository

Create Developer workspace directory:

```bash
mkdir -p ~/Developer
```

Clone from GitHub:

```bash
git clone https://github.com/blud0t/macos-dotfiles.git ~/Developer/macos-dotfiles
cd ~/Developer/macos-dotfiles
```

_OR_ Clone from GitLab:

```bash
git clone https://gitlab.com/blud0t/macos-dotfiles.git ~/Developer/macos-dotfiles
cd ~/Developer/macos-dotfiles
```

---

### Package & Font Installation

Install basic formulae and shell utilities (REQUIRED):

```bash
brew install bat eza fastfetch fnm fzf powerlevel10k pyenv tree tlrc yt-dlp zsh-autosuggestions zsh-syntax-highlighting
```

Install core GUI applications and font (REQUIRED):

```bash
brew install --cask --adopt visual-studio-code wezterm@nightly zed zen font-caskaydia-mono-nerd-font
```

Install ALL formulae, casks, and VS Code extensions from Brewfile (OPTIONAL):

```bash
brew bundle
```

Set up Node LTS via fnm:

```bash
fnm install --lts
fnm default lts-latest
```

---

### Apply Configurations

Copy shell and terminal configs:

```bash
cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh
cp .wezterm.lua ~/.wezterm.lua
```

Apply VS Code config and local Purple Fizz theme:

```bash
mkdir -p "$HOME/Library/Application Support/Code/User"
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
mkdir -p ~/.vscode/extensions
cp -r vscode/purpletheme ~/.vscode/extensions/
```

Apply Zed config and themes:

```bash
mkdir -p ~/.config/zed/themes
cp zed/settings.json ~/.config/zed/settings.json
cp zed/themes/*.json ~/.config/zed/themes/
```

Launch WezTerm:

```bash
open -a WezTerm && (killall Terminal 2>/dev/null || true)
```

---
