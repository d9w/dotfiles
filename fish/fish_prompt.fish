## Show if ssh session
function show_ssh_status -d "Show if the session is an ssh client"
  if [ -n "$SSH_CLIENT" ]
      prompt_segment normal blue "SSH:"
  end
end

## Show user if not default
function show_user -d "Show user"
  if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
    set -l host (hostname -s)
    set -l who (whoami)
    prompt_segment normal 86fd68 " $who"

    prompt_segment normal white "@"
    prompt_segment normal white "$host "
  end
end

# Show directory
function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  prompt_segment normal 86fd68 "$pad$pwd "
end

# Show prompt w/ privilege cue
function show_prompt -d "Shows prompt with cue for current priv"
  set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
    prompt_segment red white "! "
    set_color normal
    echo -n -s " "
  else
    prompt_segment normal white "\$ "
    end

  set_color normal
end

# Display [venvname] if in a virtualenv
function show_virtualenv -d "Show the virtualenv"
  if set -q VIRTUAL_ENV
    set -l vname (basename "$VIRTUAL_ENV")
    prompt_segment normal white "[$vname]"
  end
end

## SHOW PROMPT
function fish_prompt
  show_ssh_status
#  show_virtualenv
  show_user
  show_pwd
  show_prompt
end
