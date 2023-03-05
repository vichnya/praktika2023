#!/bin/bash

# Скрипт настройки отключения экрана

set -e

while true; do
    read -p "Was user's profile loaded? " yn
    case $yn in
        [Yy]* )


            if [ ! -f /home/astra-user/.fly/theme/current.themerc ]; then

                # Отключение таймера блокировки экрана
                sudo sed -i "/ScreenSaverDelay=/c\ScreenSaverDelay=0" /home/astra-user/.fly/theme/current.themerc

                # Отключение выхода из сессии при переходе в сон
                sudo sed -i "/LockerOnSleep=/c\LockerOnSleep=false" /home/astra-user/.fly/theme/current.themerc

                # Отключение выхода из сессии при смене пользователя
                sudo sed -i "/LockerOnSwitch=/c\LockerOnSwitch=false" /home/astra-user/.fly/theme/current.themerc

                # Отключение выхода из сессии по настройкам питания
                sudo sed -i "/LockerOnDPMS=/c\LockerOnDPMS=false" /home/astra-user/.fly/theme/current.themerc

                # Отключение блокировки
                sudo sed -i "/LockerOnLid=/c\LockerOnLid=false" /home/astra-user/.fly/theme/current.themerc

            fi

            break;;

    [Nn]* )
            break;;
        * ) echo "Please answer yes or no.";;
    esac
done


