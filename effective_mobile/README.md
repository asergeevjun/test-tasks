# копируем скрипт и даём права на выполнение
sudo cp monitor-test-process.sh /usr/local/bin/

sudo chmod +x /usr/local/bin/monitor-test-process.sh

# копируем юнит-файлы
sudo cp monitor-test-process.service /etc/systemd/system/

sudo cp monitor-test-process.timer /etc/systemd/system/

# перечитываем конфиги systemd
sudo systemctl daemon-reload

# включаем и запускаем таймер
sudo systemctl enable monitor-test-process.timer

sudo systemctl start monitor-test-process.timer

# проверяем статус (опционально)
sudo systemctl status monitor-test-process.timer

# проверяем логи (если нужно)
tail -f /var/log/monitoring.log
