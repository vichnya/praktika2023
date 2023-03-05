#!/bin/bash

# Первоначальная настройка ОС

# Поиск других операцилннных систем на доступных дисках
sudo os-prober

# Обновление файла конфигураций grub
sudo update-grub

# Запись репозиториев в файл /etc/apt/sources.list
sudo echo '#astra
deb http://download.astralinux.ru/astra/stable/1.7_x86-64/repository-main/ 1.7_x86-64  main contrib non-free
deb http://download.astralinux.ru/astra/stable/1.7_x86-64/repository-update/ 1.7_x86-64  main contrib non-free
deb http://download.astralinux.ru/astra/stable/1.7_x86-64/repository-base/ 1.7_x86-64  main contrib non-free
deb http://download.astralinux.ru/astra/stable/1.7_x86-64/repository-extended/ 1.7_x86-64  main contrib non-free' > /etc/apt/sources.list

# Обновление списка доступных пакетов
sudo apt update

# Установка ядра 5.15
sudo apt install linux-5.15-generic -y

# reboot
#sudo reboot


