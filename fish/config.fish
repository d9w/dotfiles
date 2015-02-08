# start off with a fortune
function fish_greeting
    fortune
end

# colored man pages
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

# Disable virtual env prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT True

# prompts
. ~/.config/fish/helpers.fish
. ~/.config/fish/fish_prompt.fish
. ~/.config/fish/fish_right_prompt.fish
