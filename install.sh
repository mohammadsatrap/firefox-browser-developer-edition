#!/bin/bash
clear

now_datetime=$(date +'%Y-%m-%d_%H-%M-%S')

script=$(realpath "$0")
script_dir_path=$(dirname "$script")

install_directory_name=firefoxDeveloper
install_directory_path="/opt/"

tmp_name=$install_directory_name"_"$now_datetime
tmp_name_format=".tar.bz2"
tmp_path="/tmp/"
tmp_target="$tmp_path$tmp_name$tmp_name_format"

download_url="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"

echo '################################################################'
echo '# Downloading Firefox Browser Developer Edition Latest Version #'
echo '################################################################'

# Download Firefox Browser Developer Edition Lates Version
wget -O $tmp_path$tmp_name$tmp_name_format $download_url -q --show-progress --progress=bar:force 2>&1

echo '+------- Creating Directories ---------------------------------+'
sudo rm -rf $tmp_path$tmp_name
sudo mkdir $tmp_path$tmp_name

echo '+------- Unzipping Downloaded File ----------------------------+'
sudo tar -xf $tmp_target -C $tmp_path$tmp_name
sudo mv $tmp_path$tmp_name"/firefox" $tmp_path$tmp_name"/"$install_directory_name

echo '+------- Moving To OPT Directory ------------------------------+'
sudo cp -r $tmp_path$tmp_name"/"$install_directory_name $install_directory_path

echo '+------- Creating a symlink -----------------------------------+'
sudo ln -s $install_directory_path$install_directory_name"/firefox" "/usr/local/bin/"$install_directory_name

echo '+------- Creating Desktop Shortcut ----------------------------+'
sudo chmod +x $install_directory_path$install_directory_name"/browser/chrome/icons/default/default128.png"
sudo cp "$script_dir_path/$install_directory_name.desktop" "/home/$USER/.local/share/applications/$install_directory_name.desktop"
sudo chmod +x "/home/$USER/.local/share/applications/$install_directory_name.desktop"

echo '+------- Remove Temps -----------------------------------------+'
sudo rm -rf $tmp_path$tmp_name
sudo rm -rf $tmp_path$tmp_name$tmp_name_format

echo '######## END ###################################################'
echo '################################################################'


