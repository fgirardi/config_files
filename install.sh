#!/bin/bash

function install() {
	SUDO=$(which sudo 2>/dev/null)
	# don't execute where it doesn't have (running from a container)
	if [ -z $SUDO ] ; then
		SUDO=""
	fi

	# packages to be installed on a fresh Fedora install
	if which dnf 2>/dev/null 1>/dev/null
	then
		$SUDO dnf build-dep bubblewrap bwrap-oci \
			flatpak

		$SUDO dnf install \
			ctags \
			clang \
			clang-analyzer \
			llvm-devel \
			llvm-static \
			virtme \
			qemu \
			luajit-devel \
			ncurses-devel \
			iperf \
			elfutils-libelf-devel \
			kernel-headers \
			kernel-devel \
			python2-sphinx \
			texlive-xetex-bin \
			texlive-collection-xetex \
			texlive-tabulary \
			texlive-cmap \
			texlive-pdftex	texlive-pdftex-bin \
			texlive-ec \
			texlive-ams* \
			texlive-adjustbox \
			texlive-anyfontsize \
			texlive-oberdiek \
			texlive-tools \
			texlive-capt-of \
			texlive-eqparbox \
			texlive-euenc \
			texlive-fncychap \
			texlive-mdwtools \
			texlive-framed \
			texlive-luatex85 \
			texlive-multirow \
			texlive-needspace \
			texlive-psnfss \
			texlive-parskip \
			texlive-polyglossia \
			texlive-threeparttable \
			texlive-titlesec \
			texlive-ucs \
			texlive-upquote \
			texlive-wrapfig \
			texlive-langcode \
			texlive-langsci \
			texlive-babel-english \
			texlive-hyphen-english \
			make \
			meson \
			gettext-devel \
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
			libxml2 \
			unzip \
			docker \
			libnetfilter*-devel \
			libnfnetlink* \
			conntrack-tools \
			redhat-rpm-config \
			python-devel \
			flatpak flatpak-devel flatpak-builder \
			xmlto \
			SDL2-devel \
			SDL2_image-devel \
			dbus-devel \
			gstreamer1-devel \
			gstreamer1-plugins-base-devel \
			libv4l-devel \
			doxygen \
			xmltoman \
			libva-devel \
			jack-audio-connection-kit-devel \
			libv4l-devel \
			htop  \
			gtk-doc \
			gobject-introspection-devel \
			libcap-devel \
			libarchive-devel \
			libsoup-devel \
			gpgme-devel \
			polkit-devel \
			ostree-devel \
			fuse-devel \
		--best --verbose

		# install pt spellcheck for vim
		if [ ! -f /usr/share/vim/vim80/spell/pt.utf-8.spl ]; then
			wget https://github.com/vim/vim/files/657554/pt.utf-8.spl.zip -O /tmp/pt.zip
			$SUDO unzip /tmp/pt.zip -d /usr/share/vim/vim80/spell/
			rm /tmp/pt.zip
		fi
	fi

	python -m pip install --user powerline-status netifaces thefuck pelican \
		markdown ghp-import -U

	$SUDO cp bash_config.sh /etc/profile.d

	for i in vimrc gitconfig muttrc tmux.conf
	do
		cp $i ~/.$i
	done

	mkdir -p ~/.config/powerline/themes/{tmux,vim}
	cp tmux_default.json ~/.config/powerline/themes/tmux/default.json
	cp vim_default.json ~/.config/powerline/themes/vim/default.json

	#create signature file
	echo $'Thanks,\n\tMarcos' >~/.signature

	if [ ! -f ~/.vim/autoload/plug.vim ]; then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
}

install
