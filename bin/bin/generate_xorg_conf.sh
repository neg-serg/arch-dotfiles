#!/bin/sh
#generate unprivileged user xorg.conf for nixOS
#before running:
#    install any desired packages by placing them in `/etc/nixos/configuration.nix`
#    update by running `nix-channel --update` and `nixos-rebuild switch`

config_dir=${XDG_CONFIG_HOME:-~/.config}/xorg.conf.d

mkdir -p "$config_dir"
cd "$config_dir"

#failed glob expansions become empty, not literal 'foo/*'
shopt -s nullglob

get_pkg_path() {
	attr=$1
	nix show-derivation -f '<nixpkgs>' "$attr" | jq -r '.[].env.out' 
}

#add to this set according to your driver needs
pkgs="
	xorg.xf86inputevdev
	xorg.xf86videointel
	xorg.xf86inputsynaptics
	xorg.xorgserver
"

#make the intel backlight helper setuid if it isn't already
xf86videointel_path=$(get_pkg_path xorg.xf86videointel)
backlight_helper_path="${xf86_video_intel_path}/libexec/xf86-video-intel-backlight-helper"
if [ -e "$backlight_helper_path" -a ! -u "$backlight_helper_path" ]; then
	sudo chmod +s ${xf86_video_intel_path}/libexec/xf86-video-intel-backlight-helper
fi

echo 'Section "Files"' > 00-nix-module-paths.conf
for pkg in $pkgs; do
	pkg_path=$(get_pkg_path $pkg)
	for conf in "$pkg_path"/share/X11/xorg.conf.d/*; do 
		ln -sf "$conf" ./
	done
	echo '	ModulePath "'"$pkg_path"'/lib/xorg/modules/"' >> 00-nix-module-paths.conf
done

#add to this set according to your font preferences
fontpkgs="
	xorg.fontmiscmisc
	ucs-fonts
"

for pkg in $fontpkgs; do
	pkg_path=$(get_pkg_path $pkg)
	path="$pkg_path"'/share/fonts/'
	[ -d "$path" ] && echo '	FontPath "'"$path"'"' >> 00-nix-module-paths.conf
	path="$pkg_path"'/lib/X11/fonts/misc/'
	[ -d "$path" ] && echo '	FontPath "'"$path"'"' >> 00-nix-module-paths.conf
done

echo 'EndSection' >> 00-nix-module-paths.conf
