export STARSHIP_CONFIG=~/.config/starship.toml
export SHOW_STARSHIP_DISTRO=true

eval "$(starship init bash)"

PROMPT_COMMAND='history -a'

# clear alias
alias cls="clear"