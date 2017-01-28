# set path
set PATH /home/johnny/tools/anaconda3/bin $PATH

# prompt bobthefish
set -g theme_display_user no
set -g theme_display_vi yes
set -g theme_display_virutalenv yes

# alias
function vim
    nvim $argv
end
function nv
    nvim $argv
end

function tl
    tmux ls
end

function td
    tmux detach
end

abbr ta=tmux attach-session -t

function tk
    tmux kill-server
end

function tm --wraps tmuxinator
    tmuxinator $argv
end

function foreground
    fg
end

abbr f=z

# keybindings
function fish_vi_key_bindings_local
    fish_vi_key_bindings
    bind -M insert \cn accept-autosuggestion
    bind -M insert \ca beginning-of-line
    bind -M insert --key dc delete-char
    #bind -M insert \cz foreground
end
set -g fish_key_bindings fish_vi_key_bindings_local

# colors
set fish_color_command ffffff --bold
set fish_color_quote ff8700
set fish_color_normal ffffff
set fish_color_end d78787
set fish_color_autosuggestion a8a8a8
set fish_color_redirection afd787 #brblue
set fish_color_param 87afd7

# conda support
source ~/github/dotfiles/fish/conda.fish
