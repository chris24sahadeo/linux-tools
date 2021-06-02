readonly THIS_SCRIPT_DIR="$(SHELL_SESSION_FILE= && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source /etc/profile.d/bash_completion.sh

# Add git branch if its present to PS1
# Uncomment lines in .bashrc as specified here: https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi

alias chrome='google-chrome'

function vchrome {
  chrome --new-window https://mail.google.com/mail/u/0/?tab=rm1#inbox
  chrome --new-window https://chat.google.com/room/AAAAS8gU-BI
  chrome --new-window https://minutedock.com/entries
  chrome --new-window \
    https://calendar.google.com/calendar/u/0/r/week \
    https://sneek.io/app/virtana
  chrome --new-window  https://www.notion.so/15dbb08ff443440d9ef812fbb08d2414?v=a8f93552c10e4c95941316b85e212614 
}

# Aliases.
alias gcan='git commit --amend --no-edit'
alias gb='git branch'
alias gbd='git branch -D'
alias gk='gitk --all'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gs='git status'
alias gph='git push'
alias gpl='git pull'
alias gd='git diff'
alias gr='git rebase -i'

# cd and list directories
function cl {
  cd $1 && ll
}

alias grep='grep -i'
alias rm='rm -rf'
alias ping='ping -c 5'
alias unity='~/UnityHub.AppImage'
alias psunity='ps -je | grep unity'
alias bashrc='. ~/.bashrc && echo ".bashrc reloaded!"'
alias linux='code $THIS_SCRIPT_DIR'

alias q3='cd ~/Q3 && ./start'

alias speedtest='speedtest --server 13934'  # Always test with Flow chaguanas.

alias reboot='sudo reboot now'
alias off='sudo shutdown now'

# Reach.
export MY_REACH_ROOT=~/project-reach
export GO_PROJ_DIR=$MY_REACH_ROOT/go/src/project-reach
export CDPATH=$MY_REACH_ROOT:~:.

function rcd {
    # echo "$MY_REACH_ROOT/$1"
    cd ${MY_REACH_ROOT}/$1
}

function rm-meta {
  saved_dir=`pwd`
  rcd
  gch -- ReachSimUnity/Assets/Materials/Blue.mat.meta ReachSimUnity/Assets/Materials/Red.mat.meta

  rm \
    ReachSimUnity/Assets/Scenes/Experiments/robot-creds.json.meta \
    ReachSimUnity/calibration_v20200302.json \
    SharedUnityAssets/Scripts/RC/Geometries.cs.meta SharedUnityAssets/Scripts/RC/Tests.meta \
    SharedUnityAssets/Scripts/RC/Tests/GeometriesTest.cs.meta \
    SharedUnityAssets/Scripts/RC/Tests/Tests.asmdef.meta \
    SharedUnityAssets/Scripts/RC/TypesGen.cs.meta \
    ReachSimUnity/Assets/Scenes/CalibrationTestingSettings.lighting.meta \
    ReachSimUnity/Assets/Scenes/Experiments/robot-creds.json \
    ReachSimUnity/Assets/Scenes/CalibrationTestingSettings.lighting \
    SharedUnityAssets/Models.meta


  cd $saved_dir
}

re_num='^[0-9]+$'
function jira {
  if [ $# -eq 0 ]  # If no args then open the VIS board.
  then
    chrome https://project-reach.atlassian.net/jira/software/projects/VIS/boards/32
    return 0
  elif ! [[ $1 =~ $re_num ]] ; then # Check if key specified (first param is NAN).
    jira_key=$1
    shift  # Remove key from arg list.
  else  # Else, assume key is VIS.
    jira_key='VIS'
   fi

  # Open each ticket # in a different tab.
  ticket_numbers=($@)
  for ticket_number in ${ticket_numbers[@]}
  do
    chrome https://project-reach.atlassian.net/browse/${jira_key}-${ticket_number}
  done
 }

MY_SIM=calibration-sim-02
alias rc='code $MY_REACH_ROOT'
alias cdgo='cd $GO_PROJ_DIR'
alias rcgo='code $GO_PROJ_DIR'
alias rph='git push origin HEAD:refs/for/master'
alias rls='reach ls'
alias r-status='while true; do rls | grep ${MY_SIM}; done'
alias gcloud-start='gcloud compute instances start ${MY_SIM}'
alias gcloud-stop='gcloud compute instances stop ${MY_SIM}'
alias gcloud-status='gcloud compute instances describe ${MY_SIM} | grep status'

. ${MY_REACH_ROOT}/setenv.sh
