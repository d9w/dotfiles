## Function to show current status
function show_error_status -d "Show error status"
  if [ $RETVAL -ne 0 ]
    prompt_segment black red "✘ "
  end
end

## Show the git status
function show_git_status -d "Show git status"
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
    set -l ref (command git symbolic-ref HEAD | sed  "s-refs/heads/--" | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

    if [ "$dirty" != "0" ]
      prompt_segment red white "$ref $dirty"
    else
      prompt_segment cyan black "$ref"
    end
  end
end

function fish_right_prompt -d "Prints right prompt"
  set -g RETVAL $status
  show_error_status
  show_git_status
end
