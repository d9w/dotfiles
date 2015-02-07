function prompt_segment -d "Draw a prompt segment"
  set -l bg
  set -l fg
  if [ -n "$argv[1]" ]
    set bg $argv[1]
  else
    set bg normal
  end
  if [ -n "$argv[2]" ]
    set fg $argv[2]
  else
    set fg normal
  end

  set_color -b $bg
  set_color $fg

  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end

  set_color -b normal
  set_color normal
end
