readonly THIS_SCRIPT_DIR="$(SHELL_SESSION_FILE= && cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cat <<EOF >> ~/.bashrc


# My bashrc extensions.
. $THIS_SCRIPT_DIR/.bashrc
EOF

ln -s $THIS_SCRIPT_DIR/.vimrc ~/.vimrc