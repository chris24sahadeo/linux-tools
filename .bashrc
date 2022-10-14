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

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi

alias chrome='google-chrome'

# Aliases.
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

gcho () {
  local branch="$1"
  gchb "${branch}" origin/"${branch}"
}

gbdo () {
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
alias rm='rm -rfv'
alias ping='ping -c 5'
alias unity='~/UnityHub.AppImage'
alias psunity='ps -jef | grep -i unity'
alias killunity='kill -9  $(psunity | awk '"'"'{print $2}'"'"')'
alias brc='. ~/.bashrc && echo ".bashrc reloaded!"'
alias linux='code $THIS_SCRIPT_DIR'

# alias q3='cd ~/Q3 && ./start'

alias speedtest-tt='speedtest -s 13934'  # Flow Chaguanas.
alias speedtest-sf='speedtest -s 1783'   # Comcast, San Francisco.
alias speedtest-ber='speedtest -s 20507' # DNS:NET Internet Service GmbH, Berlin.

alias reboot='sudo reboot now'
alias off='poweroff'

enter () {
  docker exec -it $1 /bin/bash
}

alias dp='docker system prune -a'