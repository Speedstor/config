# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# only allow `rm -c` and force the use of `gio trash`
unalias rm 2>/dev/null
rm() {
  local has_confirm=0
  local args_without_c=() # Array to hold arguments *without* -c

  # Loop through all arguments
  for arg in "$@"; do
    if [[ "$arg" == "-c" ]]; then
      # Found a standalone -c flag
      has_confirm=1
      # We don't add it to args_without_c

    elif [[ "$arg" == -*c* ]]; then
      # Found -c inside another flag (e.g., -rc, -cf)
      has_confirm=1
      
      # Rebuild the flag argument without the 'c'
      local clean_arg="-"
      for (( j=1; j<${#arg}; j++ )); do
        local char="${arg:$j:1}"
        if [[ "$char" != "c" ]]; then
          clean_arg+="$char"
        fi
      done
      
      # Only add the cleaned flag if it's not just "-"
      if [[ "$clean_arg" != "-" ]]; then
        args_without_c+=("$clean_arg")
      fi

    else
      # This is not a -c flag, so add it to the list
      args_without_c+=("$arg")
    fi
  done

  # Now, decide what to do based on whether -c was found
  if [ $has_confirm -eq 1 ]; then
    # The -c flag was present. We will provide a SINGLE prompt.
    echo "You requested a confirmed delete for: rm $@"
    read -p "Are you sure you want to proceed? (y/N) " confirm
    
    # Check the confirmation
    if [[ "$confirm" == "y" || "$confirm" == "Y" || "$confirm" == "yes" ]]; then
      # User confirmed. Run the real rm, using the arguments *without* -c
      command rm "${args_without_c[@]}"
    else
      echo "Deletion cancelled."
    fi
  else
    # The -c flag was NOT present. Print your warning.
    echo "use gio trash instead; use rm -c to use rm normally"
  fi
}

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize
shopt -s extglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# colored prompt, if the terminal has the capability
export VIRTUAL_ENV_DISABLE_PROMPT=1
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # PS1='\[\e[38;5;245m\]---------------------\[\e[0m\]\n> ${debian_chroot:+($debian_chroot)}\[\e[32;1m\]\u\[\e[0m\]:\[\e[34;1m\]\w\[\e[0m\]\$ '

    VENV_LINE='\n${VIRTUAL_ENV:+\[\e[38;5;245m\]($(basename "$VIRTUAL_ENV")) \[\e[0m\]}'
    SEPARATOR='\[\e[38;5;245m\]---------------------\[\e[0m\]\n'
    MAIN_PROMPT='> ${debian_chroot:+($debian_chroot)}\[\e[32;1m\]\u\[\e[0m\]:\[\e[34;1m\]\w\[\e[0m\]\$ '
else
    # PS1='---------------------\n> ${debian_chroot:+($debian_chroot)}:\w\$ '

    VENV_LINE='\n${VIRTUAL_ENV:+($(basename "$VIRTUAL_ENV")) }'
    SEPARATOR='---------------------'
    MAIN_PROMPT='> ${debian_chroot:+($debian_chroot)}:\w\$ '
fi
PS1="${VENV_LINE}${SEPARATOR}${MAIN_PROMPT}"

# Custom Software OS_ENV
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/var/oss-cad-suite/bin
export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-12.6/lib64
alias zotero="~/programs/Zotero_linux-x86_64/zotero"

alias clip='xclip -selection clipboard'
alias serial="python3 -m serial.tools.miniterm -"
alias tyflash="tycmd upload build/zephyr/zephyr.hex --nocheck"
alias rbash="source ~/.bashrc"
alias sl="ls --color=auto"
alias ls="ls --color=auto"
alias cats="highlight -O ansi"
alias blank="gnome-screensaver-command -a"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

