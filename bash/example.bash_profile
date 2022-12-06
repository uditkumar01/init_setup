export STARSHIP_CONFIG=~/.config/starship.toml
export SHOW_STARSHIP_DISTRO=true

PROMPT_COMMAND='history -a'

# clear alias
alias cls="clear"

eval "$(starship init bash)"
