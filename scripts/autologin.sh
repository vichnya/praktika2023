#!/bin/bash

# Скрипт настройки пользователей

set -e

while true; do
    read -p "Is it a student's pc? " yn
    case $yn in
        [Yy]* )

            # Создание пользователя astra-user
            if id astra-user &> /dev/null; then
                echo "astra-user already exists"
            else
                sudo adduser astra-user --ingroup users --disabled-password --quiet --gecos astra-user
            fi

            # Настройка автоматического входа

            # DefaultUser (содержимое Default)
            sudo sed -i "/DefaultUser=/c\DefaultUser=astra-user" /etc/X11/fly-dm/fly-dmrc

            # Автоматический выбор пользователя
            sudo sed -i "/PreselectUser=/c\PreselectUser=Default" /etc/X11/fly-dm/fly-dmrc

            # Отображение списка пользователей
            sudo sed -i "/UserList=/c\UserList=false" /etc/X11/fly-dm/fly-dmrc

            # Разрешить вход без пароля
            sudo sed -i "/AllowNullPasswd=/c\AllowNullPasswd=true" /etc/X11/fly-dm/fly-dmrc

            # Разрешить вход без пароля
            sudo sed -i "/NoPassEnable=/c\NoPassEnable=true" /etc/X11/fly-dm/fly-dmrc

            # Пользователь, которому разрешено входить без пароля
            sudo sed -i "/NoPassUsers=/c\NoPassUsers=astra-user" /etc/X11/fly-dm/fly-dmrc

            # Автоматический вход в сессию при выходе
            sudo sed -i "/AutoLoginAgain=/c\AutoLoginAgain=false" /etc/X11/fly-dm/fly-dmrc # true or false?

            # Включить автоматический вход
            sudo sed -i "/AutoLoginEnable=/c\AutoLoginEnable=true" /etc/X11/fly-dm/fly-dmrc

            # Пользователь для автоматического входа
            sudo sed -i "/AutoLoginUser=/c\AutoLoginUser=astra-user" /etc/X11/fly-dm/fly-dmrc

            # Ярлык на idle
            if [ ! -f /usr/share/applications/flydesktop/idle.desktop ]; then
                sudo echo "[Desktop Entry]
Name=IDLE
Type=Application
TryExec=/usr/bin/idle
Comment=Integrated DeveLopment Environment for Python3
Exec=/usr/bin/idle %F
Icon=/usr/share/pixmaps/idle.xpm
Terminal=false
StartupNotify=true
MimeType=text/x-python
Categories=Application;Development
" > "/usr/share/applications/flydesktop/idle.desktop"
            fi

            # Ярлык на Kumir
            if [ ! -f /usr/share/applications/flydesktop/Kumir2-Classic.desktop ]; then
                sudo echo "[Desktop Entry]
Name=Kumir2-Classic
Type=Application
Comment=Start Kumir2-Classic
Exec=/opt/Kumir2X-59a8c9f1/bin/kumir2-classic
Icon=/opt/Kumir2X-59a8c9f1/kumir2-classic.png
Terminal=false
Categories=Development
" > "/usr/share/applications/flydesktop/Kumir2-Classic.desktop"
            fi

            # Ярлык на PyCharm
            if [ ! -f /usr/share/applications/flydesktop/pycharm-community.desktop ]; then
                sudo echo "[Desktop Entry]
Name=PyCharm Community Edition
Type=Application
Comment=Start PyCharm Community Edition
Exec=/opt/pycharm-community-2022.2.3/bin/pycharm.sh
Icon=/opt/pycharm-community-2022.2.3/bin/pycharm.png
Terminal=false
Categories=Development
" > "/usr/share/applications/flydesktop/pycharm-community.desktop"
            fi

            # Ярлык на Wing 101
            if [ ! -f /usr/share/applications/flydesktop/wing-101-9.desktop ]; then
                sudo echo "[Desktop Entry]
Name=Wing 101 9
GenericName=Python IDE
Type=Application
Comment=Wing 101 9:  A powerful Python IDE
Exec=wing-101-9 %F
Icon=wing-101-9
Terminal=false
StartupNotify=true
StartupWMClass=Wing101
MimeType=application/x-wing-ide-project
Categories=Python;Development
Encoding=UTF-8
" > "/usr/share/applications/flydesktop/wing-101-9.desktop"
            fi

            break;;

    [Nn]* )

            # Настройка автоматического входа

            # DefaultUser (содержимое Default)
            sudo sed -i "/DefaultUser=/c\DefaultUser=" /etc/X11/fly-dm/fly-dmrc

            # Автоматический выбор пользователя
            sudo sed -i "/PreselectUser=/c\PreselectUser=Previous" /etc/X11/fly-dm/fly-dmrc

            # Отображение списка пользователей
            sudo sed -i "/UserList=/c\UserList=false" /etc/X11/fly-dm/fly-dmrc

            # Настройка монтирования общей папки
            #======| cifs-utils |=====#
            software_name="cifs-utils"
            if [ $(dpkg-query -W -f='${Status}' "$software_name" 2>/dev/null | grep -c "install ok installed") -eq 0 ]
            then
                echo "$software_name is not installed"
                sudo apt install "$software_name" -y
            fi
            echo "cifs-utils are installed"

            # Запись логина и пароля, под которыми пользователь будет подключаться к общей папке
            if [ ! -f /root/.smbclient ]; then
                sudo echo "username=teacher
password=8080" > /root/.smbclient
            fi

            # Добавление строки монтирования общей папки в конфиг
            sudo echo "//sc80m18-dc/Teachers /mnt/Teachers cifs credentials=/root/.smbclient,rw,nosharesock,vers=1.0,soft,noperm 0 0" >> /etc/fstab

            # Создать ярлык на общую папку на общем рабочем столе
            if [ ! -f /usr/share/applications/flydesktop/teachers.desktop ]; then
                sudo echo "[Desktop Entry]
Name=Общая папка
Type=Link
NoDisplay=false
Icon=folder
Hidden=false
URL=/mnt/Teachers
" > "/usr/share/applications/flydesktop/teachers.desktop"
            fi

            # Создать ярлык на электронный журнал на общем рабочем столе
            if [ ! -f /usr/share/applications/flydesktop/journal.desktop ]; then
                sudo echo "[Desktop Entry]
Name=Электронный журнал
Type=Link
NoDisplay=false
Icon=network
Hidden=false
URL=http://paragraph.scool80.local
" > "/usr/share/applications/flydesktop/journal.desktop"
            fi

            break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Ярлык на Р7-оффис
if [ -f /usr/share/applications/flydesktop/r7-office.desktop ]; then
    sudo rm /usr/share/applications/flydesktop/r7-office.desktop
fi

if [ ! -f /usr/share/applications/flydesktop/r7-office-desktopeditors.desktop ]; then
    sudo cp /usr/share/applications/r7-office-desktopeditors.desktop /usr/share/applications/flydesktop
fi

# Ярлык на libreoffice
if [ -f /usr/share/applications/flydesktop/libreoffice.desktop ]; then
    sudo rm /usr/share/applications/flydesktop/libreoffice.desktop
fi

if [ ! -f /usr/share/applications/flydesktop/libreoffice-startcenter.desktop ]; then
    sudo cp /usr/share/applications/libreoffice-startcenter.desktop /usr/share/applications/flydesktop
fi
