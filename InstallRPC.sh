#Ставим пакет "sshpass", для автоматического входа из командной строки по паролю
sudo apt install sshpass -y
#Устанавливаем Samba:
sudo apt install samba samba-common-bin -y
#Готово

Заведем специальную учетную запись пользователя на самом Raspberry, чтобы можно было удаленно управлять его питанием

BASH
КОПИРОВАТЬ
#Создаем нового пользователя
sudo useradd PowerControl
#Задаем пользователю пароль, скажем "12345678"
echo 'PowerControl:12345678' | sudo chpasswd
#Создаем домашний каталог:
sudo mkdir /home/PowerControl
#Перемещаем папку пользователя в скрытый каталог
sudo mv /home/PowerControl /var/PowerControl
#Присваиваем папку пользователя к учетной записи
sudo usermod PowerControl -d /var/PowerControl
# Делаем владельцем каталога пользователя "PowerControl"
sudo chown PowerControl /var/PowerControl
# Меняем права доступа каталога:
sudo chmod 500 /var/PowerControl
#Создаем каталог для следующей настройки
sudo mkdir /var/lib/AccountsService
sudo mkdir /var/lib/AccountsService/users
#Скрываем пользователя
sudo rm -rf /var/lib/AccountsService/users/PowerControl
echo "[User] SystemAccount=true" | sudo tee /var/lib/AccountsService/users/PowerControl
#Ограничим учетную запись "PowerControl" выполнением только командой shutdown
echo "PowerControl ALL=(ALL) NOPASSWD: /sbin/shutdown" | sudo tee /etc/sudoers.d/PowerControl
#Готово
Теперь можно указанной ниже командой перезагрузить Raspberry

BASH
КОПИРОВАТЬ
sudo sshpass -p 'password' ssh -oStrictHostKeyChecking=no user@XXX.XXX.XXX.XXX sudo shutdown -r now
