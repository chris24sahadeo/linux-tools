readonly THIS_SCRIPT_DIR="$(SHELL_SESSION_FILE= && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cat <<EOF >> ~/.bashrc


# My bashrc extensions.
. $THIS_SCRIPT_DIR/.bashrc
EOF

# Vim looks for .vimrc in the $HOME directory.
# A simlink is a nice way for .vim to find the file, while we still track in it git.
ln -s $THIS_SCRIPT_DIR/.vimrc ~/.vimrc