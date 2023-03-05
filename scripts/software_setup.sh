#!/bin/bash

# Установка ПО

# Удаление ядра 5.10
sudo apt-get purge linux-image-5.10* -y

# Удаление ядра 5.4
sudo apt-get purge linux-image-5.4* -y

# Установка времени
sudo timedatectl set-local-rtc 1 --adjust-system-clock

# Настройка не настроенных пакетов
sudo dpkg --configure -a

# Обновление списка доступных пакетов
sudo apt update

# Обновление пакетов
sudo apt upgrade -y

# Обновление пакетов
sudo apt dist-upgrade -y

# Установка политики обновления
sudo apt policy apt apt-transport-https ca-certificates

# Запись репозиториев в файл /etc/apt/sources.list
sudo echo '#astra
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-main/ 1.7_x86-64  main contrib non-free
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-update/ 1.7_x86-64  main contrib non-free
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-base/ 1.7_x86-64  main contrib non-free
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-extended/ 1.7_x86-64  main contrib non-free' > /etc/apt/sources.list

set -e

# Настройка не настроенных пакетов
sudo dpkg --configure -a

# Обновление списка доступных пакетов
sudo apt update

# Обновление пакетов
sudo apt upgrade -y

# Обновление пакетов
sudo apt dist-upgrade -y

while true; do
    read -p "Is it an IT class? " yn
    case $yn in
        [Yy]* )

            #======| python |=====#
            software_name="python3"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo apt install "$software_name" -y
            fi
            echo "Python is installed"

            #======| Idle |=====#
            software_name="idle3"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo apt install "$software_name" -y
            fi
            echo "Idle is installed"

            #======| Wing 101 |=====#
            software_name="wing-101-9"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo dpkg -i "./wing-101.deb"
            fi
            echo "Wing 101 is installed"

            #======| PyCharm |=====#
            software_name="pycharm-community"
            file_name="pycharm-community-2022.2.3.tar.gz"
            if ! [ -f /opt/pycharm-community-2022.2.3/bin/pycharm.sh ]
            then
                echo "$software_name is not installed"
                sudo tar -xvzf ./"$file_name" -C /opt/
                sudo chmod +x /opt/pycharm-community-2022.2.3/bin/pycharm.sh
                sudo touch /usr/share/applications/pycharm-community.desktop
                sudo chmod +x /usr/share/applications/pycharm-community.desktop
                sudo echo "[Desktop Entry]
Name=PyCharm Community Edition
Comment=Start PyCharm Community Edition
Exec=/opt/pycharm-community-2022.2.3/bin/pycharm.sh
Icon=/opt/pycharm-community-2022.2.3/bin/pycharm.png
Terminal=false
Type=Application
Categories=Development" >> /usr/share/applications/pycharm-community.desktop
            fi

            #======| kumir |=====#
            file_name="Kumir2X-1462.tar.gz"
            if ! [ -f /opt/Kumir2X-59a8c9f1/bin/kumir2-classic ];
            then
                echo "Kumir2-Classic is not installed"
                sudo apt install libqt4-svg -y
                sudo tar -xvzf ./kumir/"$file_name" -C /opt/
                sudo cp ./kumir/kumir2-classic.png /opt/Kumir2X-59a8c9f1
                sudo touch /usr/share/applications/Kumir2-Classic.desktop
                sudo chmod +x /usr/share/applications/Kumir2-Classic.desktop
                sudo echo "[Desktop Entry]
Name=Kumir2-Classic
Comment=Start Kumir2-Classic
Exec=/opt/Kumir2X-59a8c9f1/bin/kumir2-classic
Icon=/opt/Kumir2X-59a8c9f1/kumir2-classic.png
Terminal=false
Type=Application
Categories=Development" >> /usr/share/applications/Kumir2-Classic.desktop
            fi
            echo "Kumir2-Classic is installed"

            break;;

    [Nn]* ) break;;

    * ) echo "Please answer yes or no.";;

    esac
done

#======| R7 office |======#
software_name="r7-office"
if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
then
  echo "$software_name is not installed"
  sudo apt-get install fonts-crosextra-carlito fonts-dejavu fonts-liberation fonts-opensymbol curl gstreamer1.0-libav gstreamer1.0-plugins-ugly libasound2 libc6 libcairo2 libgcc1 libgconf-2-4 libgtk-3-0 libstdc++6 libx11-6 libxss1 x11-common xdg-utils -y
  dpkg -i ./r7/r7-office.deb
  sudo apt-get -f install -y
  sudo chmod a=rwx ./r7/7813127944.lickey
  sudo cp ./r7/7813127944.lickey /etc/r7-office/license
fi
echo "R7 Office is installed"


while true; do
    read -p "Do you need to prepare this PC for exams? " yn
    case $yn in
        [Yy]* )
            #======| ia32-libs |=====#
            software_name="ia32-libs"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name are not installed"
                sudo apt install "$software_name" -y
            fi
            echo "ia32-libs are installed"

            #======| cabextract |=====#
            software_name="cabextract"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo apt install "$software_name" -y
            fi
            echo "cabextract is installed"

            #======| wine |=====#
            software_name="wine"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo apt install "$software_name" -y
            fi
            echo "wine is installed"

            #======| winetricks |=====#
            software_name="winetricks"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo apt install "$software_name" -y
                sudo winetricks dotnet472
            fi
            echo "winetricks is installed"
            break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you need to remove password from grub? " yn
    case $yn in
        [Yy]* )
            sudo sed -i 's/--class windows --class os $menu/--class windows --class os  --unrestricted  --class os $menu/g' /boot/grub/grub.cfg
            break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

sudo reboot
