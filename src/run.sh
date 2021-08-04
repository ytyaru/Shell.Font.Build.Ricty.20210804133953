#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# Rictyフォントをビルド＆インストールする。
# CreatedAt: 2021-08-04
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	Download() {
		RictryBuildScript() {
			wget https://rictyfonts.github.io/files/ricty_generator.sh
			wget https://rictyfonts.github.io/files/os2version_reviser.sh
			chmod +x ricty_generator.sh
			chmod +x os2version_reviser.sh
		}
		FontForge() { sudo apt-get install -y fontforge; }
		DependsFont() {
			wget https://fonts.google.com/download?family=Inconsolata
			wget https://osdn.net/projects/mix-mplus-ipa/downloads/72511/migu-1m-20200307.zip
			unzip Inconsolata.zip
			unzip migu-1m-20200307.zip
		}
		RictryBuildScript
		FontForge
		DependsFont
	}
	Build() {
		./ricty_generator.sh auto
#		./os2version_reviser.sh
	}
	Install() { cp ./*.ttf ~/.fonts; }
	Check() { fc-list | grep Ricty; }
	time Download
	time Build
	Install
	Check
}
Run "$@"
