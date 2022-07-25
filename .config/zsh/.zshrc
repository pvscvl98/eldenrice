#!/bin/sh

export ZDOTDIR=$HOME/.config/zsh

# history
HISTFILE=~/.zsh_history
HISTSIZE=80000
SAVEHIST=80000
setopt hist_ignore_dups		#ignore duplicated commands history list

# options
setopt autocd
setopt numericglobsort
setopt notify
unsetopt BEEP

#bindkey -e								# emacs key bindings

# --- vim bindings ---
export EDITOR="vim"
export VISUAL="vim"
bindkey -v								# vim key bindings
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# key bindings
bindkey '^[[P'		delete-char
bindkey '^[[1;5C'	forward-word 		# ctrl + ->
bindkey '^[[1;5D'	backward-word		# ctrl + <-
bindkey '^[[1;3C'	forward-word		# alt + ->
bindkey '^[[1;3D'	backward-word		# alt + <- 


# LS_COLORS
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:"

# completions
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zmodload zsh/complist
_comp_options+=(globdots)

# useful functions
source "$ZDOTDIR/zsh-functions"

# add files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# add plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
#zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


# start dwm 
if pacman -Qs libxft-bgra >/dev/null 2>&1; then
#Start graphical server on user's current tty if not already running.
#make sure "/home/user/x11/xinitrc" is present
	[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
else
	echo "\033[31mIMPORTANT\033[0m: Note that \033[32m\`libxft-bgra\`\033[0m must be installed for this build of dwm.
	Please run:
		\033[32mparu -S libxft-bgra-git\033[0m
		and replace \`libxft\`. Afterwards, you may start the graphical server by running \`startx\`."
fi
