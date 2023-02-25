# @chris24sahadeo: This file is sourced by .zshrc BEFORE the call to source $ZSH/oh-my-zsh.sh which can overwrite things with the same name setup in this file.

readonly THIS_SCRIPT_DIR="$(SHELL_SESSION_FILE= && cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# source /etc/profile.d/bash_completion.sh

# Add git branch if its present to PS1
# Uncomment lines in .bashrc as specified here: https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# parse_git_branch() {
#   git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# }
# if [ "$color_prompt" = yes ]; then
#   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
# else
#   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
# fi

# Aliases.
alias chrome='google-chrome'
alias gcan='git commit --amend --no-edit'
alias gb='git branch'
alias gbd='git branch -D'
alias gk='gitk --all'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gs='git status'
alias gph='git push'
alias gpl='git pull'
alias gd='git diff'
alias gr='git rebase -i'
alias grhh='git reset --hard HEAD'

gcho() {
  local branch="$1"
  gchb "${branch}" origin/"${branch}"
}

gbdo() {
  local branch="$1"
  git push -d origin "${branch}"
}

# List aliases.
alias llh='ls -alF'
alias llp='ll -d $PWD/*'

# cd and list directories
function cl {
  cd $1 && ll
}

alias grep='grep -i'
alias rm='sudo rm -rfv'
alias ping='ping -c 5'
alias unity='~/UnityHub.AppImage'
alias psunity='ps -jef | grep -i unity'
alias killunity='kill -9  $(psunity | awk '"'"'{print $2}'"'"')'
alias brc='. ~/.bashrc && echo ".bashrc reloaded!"'
alias tools='code $THIS_SCRIPT_DIR'

# alias q3='cd ~/Q3 && ./start'

st() {
  if [[ $# -eq 0 ]]; then
    echo here
    location="tt"
  else
    location="$1"
  fi

  declare -A location_map=(
    ["tt"]="13934"  # Flow Chaguanas.
    ["sf"]="1783"   # Comcast, San Francisco.
    ["ber"]="20507" # DNS:NET Internet Service GmbH, Berlin.
  )

  speedtest -s "${location_map[$location]}"
}

alias reboot='sudo reboot now'
alias off='poweroff'

alias rsync='rsync --info=progress2 -a'

# Docker
enter() {
  docker exec -it $1 /bin/bash
}

alias dp='docker system prune -a'

# dcp () {
#   vol_name=$1
#   src_path_in_vol=$2
#   fname=$(basename -- $src_path_in_vol)
#   # dest_path_on_host=$3
#   dest_path_on_host=$(pwd)
#   readonly vol_mnt_dir=/cp_temp
#   docker run \
#     --name dcp \
#     --rm \
#     --privileged \
#     --net=host \
#     -v $vol_name:$vol_mnt_dir \
#     -v $dest_path_on_host:$dest_path_on_host \
#     eeacms/rsync \
#       rsync --info=progress2 -a $vol_mnt_dir/$src_path_in_vol $dest_path_on_host
#   sudo chown $USER $dest_path_on_host/$fname
# }

size() {
  du -ah $1 | grep -v "/$" | sort -rh
}

alias ch="sudo chown -R $USER $PWD"

compress() {
  # Use all cores.
  tar -cvf $1.tar.gz $1 --use-compress-prog=pigz
}
