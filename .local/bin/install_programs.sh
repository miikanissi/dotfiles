#!/bin/sh

installpkg(){ sudo apt -y install "$1" >/dev/null 2>&1 ;}

error() { printf "%s\n" "$1" >&2; exit 1; }

welcomemsg() { \
	dialog --title "Welcome!" --msgbox "Welcome to a Custom Debian Installation Script!\\n\\nThis script will automatically install a fully-featured Linux desktop, which I use as my main machine.\\n\\n-Miika" 10 60
	dialog --colors --title "Important Note!" --yes-label "All ready!" --no-label "Return" --yesno "Be sure the computer you are using has current debian updates and main contrib non-free repositories.\\n\\nIf it does not, the installation of some programs might fail." 8 70
	}
preinstallmsg() { \
	dialog --title "Let's start installing!" --yes-label "Let's go!" --no-label "No, nevermind!" --yesno "The rest of the installation will now be totally automated, so you can sit back and relax.\\n\\nIt will take some time, but when done, you can relax even more with your complete system.\\n\\nNow just press <Let's go!> and the system will begin installation!" 13 60 || { clear; exit 1; }
	}
noinstall() { \
	dialog --title "Custom Debian Installation" --infobox "Skipping the installation of package \`$1\` ($n of $total). $1 $2" 5 70
}
npminstall() { \
	dialog --title "Custom Debian Installation" --infobox "Installing the NPM package \`$1\` ($n of $total). $1 $2" 5 70
	[ -x "$(command -v "npm")" ] || installpkg npm >/dev/null 2>&1
	yes | npm install --save-dev "$1"
}
pipinstall() { \
	dialog --title "Custom Debian Installation" --infobox "Installing the Python package \`$1\` ($n of $total). $1 $2" 5 70
	[ -x "$(command -v "pip3")" ] || installpkg python3-pip >/dev/null 2>&1
	yes | pip3 install "$1"
}
maininstall() { # Installs all needed programs from debian repo.
	dialog --title "Custom Debian Installation" --infobox "Installing \`$1\` ($n of $total). $1 $2" 5 70
	installpkg "$1"
}
installation() { \
  total=$(wc -l < "$HOME/programs.csv")
  while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo "$comment" | grep -q "^\".*\"$" && comment="$(echo "$comment" | sed -E "s/(^\"|\"$)//g")"
		case "$tag" in
			"N") npminstall "$program" "$comment" ;;
			"P") pipinstall "$program" "$comment" ;;
			"X") noinstall "$program" "$comment" ;;
			*) maininstall "$program" "$comment" ;;
		esac
	done < "$HOME/programs.csv";
}

welcomemsg || error "User exited."

preinstallmsg || error "User exited."

installation || error "An unkown error occured during installation."
