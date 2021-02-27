#!/bin/sh
######################################################################
#
# Arquivos de Configurações automática do meu sistema.
#
######################################################################
set -e # Error? Bye.

#### Test
if test "$UID" -eq '0'; then
    printf '%s\n' "Root not supported here."
    exit 1
fi
# i3 installed on system ?
if ! type -P "i3" 1>/dev/null 2>1; then
    checki3='no'
else
    mkdir -p .config/{i3,i3status} # Create configure dirs i3's
fi


cd $HOME # Force entry home user.

# Preset
presetMaster="https://raw.githubusercontent.com/slackjeff/preset/master"
echo "Download preset from Github slackjeff... Wait =)"
for preset in '.bashrc' '.muttrc' '.Xresources' '.nanorc' 'i3/config' 'i3status/config' ; do
    [ $preset = '.Xresources' ] && xrdb $preset # Load configure for xterm.
    if test "$preset" = "i3status/config"; then
        [ $checki3 = no ] && continue
        wget -O ${HOME}/.config/i3status/ "${presetMaster}/.config/$preset"
    elif test "$preset" = 'i3/config'; then
        [ $checki3 = no ] && continue
         wget -O ${HOME}/.config/i3/config "${presetMaster}/.config/$preset"
    fi
    # Download archive.
    wget "${presetMaster}/$preset"
done

printf '%s\n' "Admin plataform:"
git clone https://github.com/slackjeff/adm-plataforma
