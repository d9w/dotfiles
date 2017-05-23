# start off with a fortune
function fish_greeting
  fortune
end

set PATH /usr/local/sbin /usr/local/bin /usr/bin /usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl /home/d9w/.gem/ruby/2.3.0/bin

#function venv
#  if stat ~/.venvs/$argv[1]/bin/activate.fish > /dev/null ^&1
#    source ~/.venvs/$argv[1]/bin/activate.fish
#  else
#    return 1
#  end
#end

if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
    exec startx -- -keeptty
  end
end

#function julia -d 'colors default'
#  command julia --color=yes $argv
#end

function git -d 'Some added git functions'
  if test (count $argv) -eq 2
    if test $argv[1] = 'submodule' -a $argv[2] = 'pulleach'
      command git submodule foreach git pull origin master
      return 0
    end
  end
  command git $argv
end

function git-recurse
  if stat .git/config > /dev/null ^&1
    set -l gnum (git status --short | wc -l)
    echo (pwd)
    if test $gnum -gt 0
      set_color purple
    else
      set_color cyan
    end
    echo (git config --get remote.origin.url) (git rev-parse --short @) (git rev-parse --abbrev-ref HEAD) $gnum
    set_color normal
  else
    if test (count */) -gt 0
      for d in *
        if test (stat --format="%F" $d) = "directory"
          cd $d
          git-recurse
          cd ..
        end
      end
    else
      set_color red
      echo (pwd)
      echo
      set_color normal
    end
  end
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

# conda venv
. ~/.config/fish/conda.fish

# MXNet
set -x MXNET_HOME /home/d9w/.julia/v0.5/MXNet.jl

# keyboard settings
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps


envoy -d -t ssh-agent
eval (envoy -pf)

# prompts
. ~/.config/fish/helpers.fish
. ~/.config/fish/fish_prompt.fish
. ~/.config/fish/fish_right_prompt.fish
