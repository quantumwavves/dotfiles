#!/usr/bin/env bash
#Version 0.1
blue="\e[0;94m"
red="\e[0;91m"
green="\e[0;92m"
white="\e[0;97m"
reset="\e[0m"
yellow="\e[0;33m"
cyan="\033[0;36m"

packages="bspwm sxhkd kitty polybar rofi feh git tmux\
  betterlockscreen xclip imagemagick maim pcmanfm-gtk3\
  ranger python-pywal lsd stalonetray xdo neofetch\
  checkupdates+aur pulseaudio xorg-xrandr curl\
  ttf-jetbrains-mono-nerd dunst awesome-terminal-fonts\ 
  ttf-font-awesome unzip nodejs npm"
optional_packages="python-pywalfox pywal-discord-git"

install() {
	echo
	echo -e "${blue}                     _                   _     _      ${reset}"
	echo -e "${blue}  __ _ _  _ __ _ _ _| |_ _  _ _ __    __| |___| |_ ___${reset}"
	echo -e "${blue} / _  | || / _  | ' \  _| || | '  \  / _  / _ \  _(_-<${reset}"
	echo -e "${blue} \__, |\_,_\__,_|_||_\__|\_,_|_|_|_| \__,_\___/\__/__/${reset}"
	echo -e "${blue}    |_|                                               ${reset}"
	echo -e "${blue}            My personal dotfiles (=^.^=). ${reset}"
	echo
	#Status aur helper
	echo -e "${yellow}[*] Updating system${reset}"
	sudo pacman -Syu --noconfirm
	echo -e "${cyan}[+] Install dependencies...${reset}"
	sleep 1s
	if [ -a /usr/bin/yay ] >/dev/null 2>&1; then
		yay -S --needed $packages
		echo -e "${green}[-] Done. Packages are installed${reset}"
		#Installing picom-jonaburg-git
		echo -e "${yellow}[+] Installing Picom Jonaburg Fork${reset}"
		echo -e "${yellow}[+] Installing dependencies${reset}"
    yay -S meson ninja uthash libconfig
    echo -e "${cyan}[+] Clone repository${reset}"
    cd $HOME/.cache
		git clone https://github.com/jonaburg/picom.git
		cd picom
		echo -e "${red}[+] Compile source code${reset}"
    meson --buildtype=release . build
		ninja -C build
    # To install the binaries in /usr/local/bin
		sudo ninja -C build install
		cd $HOME
		optional_features
		zsh_setup
	else
		echo -e "${red}[-] Yay aur helper are not installed${reset}"
		aur_yay
		yay -S --needed $packages
		echo -e "${green}[-] Done. Packages are installed${reset}"
		optional_features
		zsh_setup
	fi
	copy_dots
	finish
}
#Make ~/.config backups
dots_backup() {
	echo -e "${yellow}[*] Making backup in ~/.dots_backup${reset}"
	sleep 1s
	if [ -d $HOME/.dots_backup ]; then
		echo -e "${yellow}[*] Directory already exists, saving backup${reset}"
		sleep 1s
	else
		mkdir $HOME/.dots_backup
	fi
	tar czf $HOME/.dots_backup/backup-$(date +%Y-%m-%d-%H-%M-%S).tar.gz $HOME/.config >/dev/null 2>&1
	echo -e "${green}[-] Finished backup${reset}"
}
aur_yay() {
	echo -e "${yellow}[?] Do you want install yay aur helper package manager?(y/n)${reset}"
	echo "[*] For manual installation see: https://github.com/Jguer/yay#installation"
	read -p "[?] Option: " yay_opt
	if [ $yay_opt = "y" ]; then
		echo -e "${yellow}[*] Installing yay AUR helper...${reset}"
		sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
		echo -e "${green}[-] Finished yay aur helper are installed${reset}"
	else
		echo -e "${red}[-] Yay aur helper are not installed ${reset}"
		echo -e "${red}[-] Aborted.${reset}"
		exit 0
	fi
}
#Copy files
copy_dots() {
	echo -e "${cyan}[+] Obtain dotfiles${reset}"
	cd $HOME/.cache
	git clone https://github.com/quantumwavves/quantum-dotfiles.git
	cd quantum-dotfiles
	cp -r .config/* $HOME/.config
	echo -e "${cyan}[+] Copy fonts...${reset}"
	mkdir $HOME/.fonts
	cp -r fonts/* $HOME/.fonts
	echo -e "${cyan}[+] Rebuild fonts${reset}"
	fc-cache -v -f >/dev/null 2>&1
	sudo fc-cache -v -f >/dev/null 2>&1
	echo -e "${yellow}[*] Copy scripts in ~/.local/bin${reset}"
	if [ -d $HOME/.local/bin ] >/dev/null 2>&1; then
		cp -r bin/* $HOME/.local/bin
		chmod +x $HOME/.local/bin/wmcolor
		chmod +x $HOME/.local/bin/wmcolor+
		echo 'export PATH=$PATH:"$HOME/.local/bin"' >>$HOME/.bashrc
	else
		mkdir $HOME/.local/bin
		cp -r bin/* $HOME/.local/bin
		chmod +x $HOME/.local/bin/wmcolor
		chmod +x $HOME/.local/bin/wmcolor+
		echo 'export PATH=$PATH:"$HOME/.local/bin"' >>$HOME/.bashrc
	fi
	echo -e "${cyan}[+] Copy default wallpaper${reset}"
	curl -o $HOME/.wallpaper https://media.githubusercontent.com/media/quantumwavves/quantum-dotfiles/master/wallpaper/default.jpg
	echo -e "${cyan}[+] Installing Tmux Package Manager${reset}"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	echo -e "${cyan}[+] Install tmux plugins${reset}"
	sh $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
	echo -e "${yellow}[*] Setup enviroment...${reset}"
	sh ~/.local/bin/wmcolor $HOME/.wallpaper >/dev/null 2>&1
}
optional_features() {
	echo -e "${yellow}[?] Do you want download optional dependencies?(y/n)${reset}"
	echo -e "[+] About that optional features: https://quantumwavves.github.io/#additional-features-optional"
	read -p "[*] Option: " opt_deps
	if [ $opt_deps = "y" ]; then
		echo -e "${cyan}[+] Install optional dependencies...${reset}"
		yay -S $optional_packages
		echo -e "${green}[-] Finish, optional dependencies are installed${reset}"
	else
		echo -e "${yellow}[*] Optional dependencies are not installed${reset}"
	fi
}
zsh_setup() {
	echo -e "${cyan}[+] Do you want install/use zsh(y/n)${reset}"
	read -p "[?] Option: " opt_zsh
	if [ $opt_zsh = "y" ]; then
		echo -e "${cyan}[*] Installing zsh and curl for ohmyzsh${reset}"
		yay -S --needed zsh curl
		echo -e "${cyan}[+] Copy .zshrc config in ~/.zshrc${reset}"
		rm -f $HOME/.zshrc
		cp $HOME/.cache/quantum-dotfiles/.zshrc $HOME/.zshrc
		echo -e "${cyan}[+] Installing ohmyzsh${reset}"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
		echo -e "${cyan}[+] Installing plugins for zsh${reset}"
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >/dev/null 2>&1
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >/dev/null 2>&1
		echo -e "${cyan}[*] Install powerlevel10k theme${reset}"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
		chsh -s /bin/zsh
		echo -e "${yellow}[*] For configure powerlevel10k use: p10k configure${reset}"
		echo -e "${green}[-] Finish${reset}"
	else
		echo "${yellow}[-] Preserving bash${reset}"
	fi
}

finish() {
	echo -e "${green}[-] Finish installation, please reboot system${reset}"
	echo -e "[+] For manual installation, check: https://quantumwavves.github.io/projects/dotfiles/#manual-installation-"
	echo -e "${yellow}[+] More features in: ${reset}"
	echo -e "${green}[-] Exiting!${reset}"
}
help() {
	echo "
Usage: install [options]

Options:
  backup    -   Create backup (not install)
  nobackup  -   Install without backup
  install   -   Normal installation (backup)
"
}
options() {
	help
	echo -e "${cyan}[*] Select one option${reset}"
	echo
	read -p "[?] Option: " choise
	case "$choise" in
	backup)
		dots_backup
		;;
	nobackup)
		install
		;;
	install)
		dots_backup
		install
		;;
	esac
}
options
