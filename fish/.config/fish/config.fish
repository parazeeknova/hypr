set -g fish_greeting

source ~/.config/fish/hyde_config.fish

if type -q starship
    starship init fish | source
    set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
    set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
end

# fzf
if type -q fzf
    fzf --fish | source
end

echo -e "\n\x1b[38;2;110;106;134m\x1b[48;2;35;33;54m\x1b[1;2:1:120m 󰥔 \x1b[0m\x1b[38;2;110;106;134m "(date +%_I:%M%P)" \x1b[38;2;130;126;154m\x1b[1;2:1:120m 󱎫 \x1b[0m\x1b[38;2;130;126;154m "(uptime -p | cut -c 4-)" \x1b[38;2;150;146;174m\x1b[1;2:1:120m  \x1b[0m\x1b[38;2;150;146;174m "(uname -r)" \x1b[38;2;170;166;194m\x1b[1;2:1:120m  \x1b[0m\x1b[38;2;170;166;194m "$(supergfxctl -S | tail -n1 | awk '{$1=$1; print}')" \x1b[38;2;190;186;214m\x1b[1;2:1:120m 󰈐 \x1b[0m\x1b[38;2;190;186;214m "$(asusctl profile -p 2>/dev/null | awk '/Active profile/ {print $4}')" \x1b[38;2;210;206;234m\x1b[1;2:1:120m 󰁹 \x1b[0m\x1b[38;2;210;206;234m "$(upower -i $(upower -e | grep BAT) | awk '/percentage/ {p=$2} /time to empty/ {t=$4 $5} END {if(t) print p, t; else print p}')"\x1b[0m"

echo

# Pokemon goes brrr
rustmon print --hide-name -s 12

# example integration with bat : <cltr+f>
# bind -M insert \ce '$EDITOR $(fzf --preview="bat --color=always --plain {}")'

set fish_pager_color_prefix cyan
set fish_color_autosuggestion brblack

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias vc='code'

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

# Parazeeknova config

# System
alias pewin='sudo pacman -S'
alias pewrm='sudo pacman -R'
alias pewup='yay -Syu'
alias pewctl='sudo systemctl'
abbr -a do sudo
abbr -a y yay
abbr -a neofetch fastfetch

# Yay
abbr -a yclean 'yay -Rns $(pacman -Qtdq)' # Remove orphans with yay
abbr -a ycc 'yay -Sc' # Clean cache
abbr -a yccc 'yay -Scc' # Aggressive clean
abbr -a ypurge 'yay -Rns $(yay -Qdtq)' # Remove yay-detected orphans

# Rank the fastest Arch mirrors, refresh the keyrings, update the package database
abbr -a prepac 'sudo reflector --country India --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Sy archlinux-keyring && sudo pacman -Syy'

alias fiscf='nvim ~/.config/fish/config.fish'
alias repo='cd ~/github/repository/'

# Tmux related Abbreviations
abbr -a ta 'tmux attach'
alias pewux='tmux new -s'

# Git Abbreviations
abbr -a gs 'git status'
abbr -a gaa 'git add --all'
abbr -a gc 'git commit -m'
abbr -a gca 'git commit --amend'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gpl 'git pull'
abbr -a glg 'git log --oneline --graph --all'
abbr -a gb 'git branch'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gst 'git stash'
abbr -a gstp 'git stash pop'
abbr -a gcl 'git clone'
abbr -a gss 'git status -s'
abbr -a gfix 'git add . && git commit --amend --no-edit'

# Python UV Abbreviations
abbr -a py python
abbr -a v uv
abbr -a vi 'uv pip install'
abbr -a vr 'uv pip remove'
abbr -a vu 'uv pip update'
abbr -a vinit 'uv venv && source .venv/bin/activate'
abbr -a va 'source .venv/bin/activate'
abbr -a vd deactivate
abbr -a vip 'uv pip install -r requirements.txt'
abbr -a vup 'uv pip install --upgrade pip'

# Ollama - Open webUI
abbr -a olamo 'source ollama/bin/activate.fish'

# Docker Abbreviations
abbr -a dps 'docker ps'
abbr -a dcu 'docker-compose up'
abbr -a dcub 'docker-compose up --build'
abbr -a dcd 'docker-compose down'

# ----- Command Not Found Suggestion -----
function fish_command_not_found
    ~/.config/fish/functions/__handle_command_not_found.fish $argv[1]
end

# ----- TheFuck Integration (for typos) -----
# Alias `fuck` to fix the last command
eval (thefuck --alias | tr '\n' ';')

# Tmux related config
COMPLETE=fish tms | source

fish_add_path /home/parazeeknova/.spicetify
