# This change was made using github.dev.
readonly THIS_SCRIPT_DIR="$(SHELL_SESSION_FILE= && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Make the linux .bashrc call our custom .bashrc.
cat <<EOF >> ~/.bashrc


# My bashrc extensions.
. $THIS_SCRIPT_DIR/.bashrc
EOF

# Vim looks for .vimrc in the $HOME directory.
# A simlink is a nice way for .vim to find the file, while we still track in it git.
ln -s $THIS_SCRIPT_DIR/.vimrc ~/.vimrc

# Simlink for .tmux.conf.
ls -s $THIS_SCRIPT_DIR/.tmux.conf ~/.tmux.conf