set __olivia_color_orange FD971F
set __olivia_color_blue 8380C4
set __olivia_color_green A6E22E
set __olivia_color_yellow E6DB7E
set __olivia_color_pink DEAF9D
set __olivia_color_grey 554F48
set __olivia_color_white F1F1F1
set __olivia_color_purple EBB0C8
set __olivia_color_lilac AE81FF
set __olivia_color_oliviapink 8C6976

function __olivia_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function __olivia_current_folder
  if test $PWD = '/'
    echo -n '/'
  else
    echo -n $PWD | grep -o -E '[^\/]+$'
  end
end

function __olivia_git_status_codes
  echo (git status --porcelain 2> /dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __olivia_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD 2> /dev/null)
end

function __olivia_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __olivia_color_echo $argv[2] " ✡⛧ ✡⛧ "
  end
end

function __olivia_git_status_icons
  set -l git_status (__olivia_git_status_codes)

  __olivia_rainbow $git_status $__olivia_color_oliviapink 'D'
  __olivia_rainbow $git_status $__olivia_color_orange 'R'
  __olivia_rainbow $git_status $__olivia_color_white 'C'
  __olivia_rainbow $git_status $__olivia_color_green 'A'
  __olivia_rainbow $git_status $__olivia_color_blue 'U'
  __olivia_rainbow $git_status $__olivia_color_lilac 'M'
  __olivia_rainbow $git_status $__olivia_color_grey '?'
end

function __olivia_git_status
  # In git
  if test -n (__olivia_git_branch_name)

    __olivia_color_echo $__olivia_color_blue " git"
    __olivia_color_echo $__olivia_color_white ":"(__olivia_git_branch_name)

    if test -n (__olivia_git_status_codes)
      __olivia_color_echo $__olivia_color_oliviapink ' ●'
      __olivia_color_echo $__olivia_color_white ' [^._.^]⛧ '
      __olivia_git_status_icons
    else
      __olivia_color_echo $__olivia_color_green ' ○'
    end
  end
end

function fish_prompt
  __olivia_color_echo $__olivia_color_oliviapink "⊱ "
  __olivia_color_echo $__olivia_color_purple (__olivia_current_folder)
  __olivia_git_status
  echo
  __olivia_color_echo $__olivia_color_oliviapink "☪ "
end
