# 1// Powerlevel10k prompts ALWAYS at the start
# 1// p10k's instant prompt for faster startup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# 2// Zsh history
HISTSIZE=2000
SAVEHIST=2000
setopt INC_APPEND_HISTORY # Save history immediately
setopt SHARE_HISTORY # Share history between all open shells
setopt HIST_IGNORE_DUPS # Ignore duplicate commands
setopt HIST_IGNORE_SPACE # Ignore mistyped space commands


# 3// Environment Variables & PATH
export PATH="$HOME/.local/bin:$PATH"
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1


# 4// Version managers
# / Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# / fnm (Fast Node Manager)
if command -v fnm 1>/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi


# 5// Aliases
# / Eza with icons (Defined before syntax highlighting to ensure correct parsing)
alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -la --icons=auto --group-directories-first'
alias tree='eza --tree --icons=auto'

# / brew aliases
alias brew-clean="brew cleanup --prune=all"
alias brew-refresh="brew autoremove"
alias brew-uc="brew uninstall --cask --force --zap"
alias brew-uf="brew uninstall --force"

# / zsh aliases
alias zsh-reload="source ~/.zshrc"
alias zsh-edit="code ~/.zshrc"

alias python="python3"

alias cat="bat --style=plain"

alias mirror="scrcpy --max-fps=60 --video-bit-rate=16M --stay-awake"

alias cheat="tldr"
alias cheat-update="tldr --update"

# / yt-dlp aliases
alias dlpm4a='yt-dlp -P "$HOME/Desktop" -f "bestaudio[ext=m4a]"'
alias dlpmp3='yt-dlp -P "$HOME/Desktop" -x --audio-format mp3 --audio-quality 0'
alias dlpaac='yt-dlp -P "$HOME/Desktop" -x --audio-format aac --audio-quality 0'
alias dlpflac='yt-dlp -P "$HOME/Desktop" -x --audio-format flac --audio-quality 0'
alias dlpwav='yt-dlp -P "$HOME/Desktop" -x --audio-format wav --audio-quality 0'
alias dlp1080mp4='yt-dlp -P "$HOME/Desktop" -f "bestvideo[height<=1080]+bestaudio/best" --merge-output-format mp4'
alias dlp1440mp4='yt-dlp -P "$HOME/Desktop" -f "bestvideo[height<=1440]+bestaudio/best" --merge-output-format mp4'
alias dlp4kmp4='yt-dlp -P "$HOME/Desktop" -f "bestvideo[height<=2160]+bestaudio/best" --merge-output-format mp4'
alias dlp1080mkv='yt-dlp -P "$HOME/Desktop" -f "bestvideo[height<=1080]+bestaudio/best" --merge-output-format mkv'
alias dlp1440mkv='yt-dlp -P "$HOME/Desktop" -f "bestvideo[height<=1440]+bestaudio/best" --merge-output-format mkv'
alias dlp4kmkv='yt-dlp -P "$HOME/Desktop" -f "bestvideo[height<=2160]+bestaudio/best" --merge-output-format mkv'


# 6// Misc
# / bat (best matched with my wezterm colors)
export BAT_THEME="Dracula"

# / pay-respects.
if command -v pay-respects 1>/dev/null 2>&1; then
  eval "$(pay-respects zsh)"
fi

# / Fuzzy finder (fzf) config
if command -v fzf 1>/dev/null 2>&1; then
  eval "$(fzf --zsh)"
  # Switch from find to fd for speed
  export FZF_DEFAULT_OPTS="--color=fg:#CBE0F0,bg:#011628,hl:#B388FF,fg+:#CBE0F0,bg+:#143652,hl+:#B388FF,info:#06BCE4,prompt:#2CF9ED,pointer:#2CF9ED,marker:#2CF9ED,spinner:#2CF9ED,header:#2CF9ED"
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  
  _fzf_compgen_path() { fd --hidden --exclude .git . "$1" }
  _fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1" }
  
  # fzf configured to use eza
  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
  _fzf_comprun() {
    local command=$1
    shift
    case "$command" in
      cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
      export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
      ssh)          fzf --preview 'dig {}'                   "$@" ;;
      *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
  }
fi


# 7// Completions
# The following lines have been added by Docker Desktop to enable Docker CLI completions
if [ -d "$HOME/.docker/completions" ]; then
  fpath=($HOME/.docker/completions $fpath)
fi

# / Initialize Zsh completions
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) || ! -f ${ZDOTDIR:-$HOME}/.zcompdump ]]; then
  compinit
else
  compinit -C
fi


# 8// Plugin configurations
# / zsh-autosuggestions suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'


# 9// Source plugins in strict order
# / zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# / zsh-syntax-highlighting ALWAYS at the end
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh