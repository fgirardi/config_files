#!/bin/bash

function install() {
	# packages to be installed on a fresh Fedora install
	if [ "x$(uname)" != "xDarwin" ] && ! [[ "$(uname -v)" =~ "Ubuntu" ]]; then
		sudo dnf install \
			ctags \
			gcc \
			clang \
			make \
			meson \
			acpitool acpica-tools \
			wget \
			vim \
			mutt \
			git \
			subversion \
			tmux \
			mtdev-devel \
			libwacom-devel \
			sparse \
			libunwind-devel \
			libinput-devel \
			libevdev-devel \
			openssl-devel \
			strace \
			libxml2

		# install pt spellcheck for vim
		if [ ! -f /usr/share/vim/vim80/spell/pt.utf-8.spl ]; then
			wget https://github.com/vim/vim/files/657554/pt.utf-8.spl.zip -O /tmp/pt.zip
			sudo unzip /tmp/pt.zip -d /usr/share/vim/vim80/spell/
			rm /tmp/pt.zip
		fi
	fi

	sudo cp bash_config.sh /etc/profile.d

	for i in vimrc gitconfig muttrc tmux.conf
	do
		cp $i ~/.$i
	done

	#create signature file
	echo $'Thanks,\n\tMarcos' >~/.signature

	if [ ! -f ~/.vim/autoload/plug.vim ]; then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
}

install
