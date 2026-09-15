# macOS Dotfiles

macOS setup feat. **Zsh + Powerlevel10k**, **WezTerm**, **VS Code**, **Zed**, and **Homebrew**.
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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to current session PATH:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

## 2. Clone, Install packages and configure

Clone macos-dotfiles repository:

```bash
mkdir -p ~/Developer
```

Clone from GitHub:

```bash
git clone https://github.com/blud0t/macos-dotfiles.git ~/Developer/macos-dotfiles
cd ~/Developer/macos-dotfiles
```

OR
Clone from GitLab:

```bash
git clone https://gitlab.com/blud0t/macos-dotfiles.git ~/Developer/macos-dotfiles
cd ~/Developer/macos-dotfiles
```

Install basic formulae, casks (REQUIRED):

```bash
brew install bat eza fastfetch fnm fzf powerlevel10k pyenv tree tlrc yt-dlp zsh-autosuggestions zsh-syntax-highlighting
```

```bash
brew install --cask --adopt visual-studio-code wezterm zed zen
```

Install ALL formulae, casks, and VS Code extensions (OPTIONAL):

```bash
brew bundle
```

Install font:

```bash
cp fonts/VertexMonoNF-Regular.ttf ~/Library/Fonts/
```

Set up Node LTS via fnm:

```bash
fnm install --lts
fnm default lts-latest
```

Configuration:

Copy config files:

```bash
cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh
cp .wezterm.lua ~/.wezterm.lua
```

VS Code config:

```bash
mkdir -p "$HOME/Library/Application Support/Code/User"
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
mkdir -p ~/.vscode/extensions
cp -r vscode/purpletheme ~/.vscode/extensions/
```

Zed config:

```bash
mkdir -p ~/.config/zed/themes
cp zed/settings.json ~/.config/zed/settings.json
cp zed/themes/*.json ~/.config/zed/themes/
```

Reload shell and open Wezterm:

```bash
open -a WezTerm && (killall Terminal 2>/dev/null || true)
```

---
