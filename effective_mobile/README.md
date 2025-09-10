# запуск процесса (для тестов)
exec -a test sleep 3600 &

# копируем скрипт и даём права на выполнение
sudo cp test-process-monitor.sh /usr/local/bin/

sudo chmod +x /usr/local/bin/monitor-test-process.sh

# копируем юнит-файлы
sudo cp test-process-monitor.service /etc/systemd/system/

sudo cp test-process-monitor.timer /etc/systemd/system/

# перечитываем конфиги systemd
sudo systemctl daemon-reload

# включаем и запускаем таймер
sudo systemctl enable test-process-monitor.timer

sudo systemctl start test-process-monitor.timer

# проверяем статус (опционально)
sudo systemctl status test-process-monitor.timer

# проверяем логи (если нужно)
tail -f /var/log/monitoring.log

# реальный пример отображения логов (на всякий)
magnetar@ubuntu:~/test-tasks$ cat /var/log/monitoring.log 

[2025-09-10 09:11:40] Процесс 'test' запущен впервые (PID: )

[2025-09-10 09:11:41] Успешный запрос к https://test.com/monitoring/test/api (PID: )

[2025-09-10 09:14:09] Процесс 'test' был перезапущен (старый PID: , новый PID: 38430)

[2025-09-10 09:14:09] Успешный запрос к https://test.com/monitoring/test/api (PID: 38430)

[2025-09-10 09:16:32] Процесс 'test' был перезапущен (старый PID: 38430, новый PID: 38529)

[2025-09-10 09:16:32] Успешный запрос к https://test.com/monitoring/test/api (PID: 38529)

[2025-09-10 09:19:05] Процесс 'test' был перезапущен (старый PID: 38529, новый PID: 38622)

[2025-09-10 09:19:06] Успешный запрос к https://test.com/monitoring/test/api (PID: 38622)

[2025-09-10 09:19:19] Процесс 'test' был перезапущен (старый PID: 38622, новый PID: 38645)

[2025-09-10 09:19:20] Успешный запрос к https://test.com/monitoring/test/api (PID: 38645)

[2025-09-10 09:19:27] Процесс 'test' был перезапущен (старый PID: 38645, новый PID: 38663)

[2025-09-10 09:19:28] Успешный запрос к https://test.com/monitoring/test/api (PID: 38663)

[2025-09-10 09:20:19] Процесс 'test' был перезапущен (старый PID: 38663, новый PID: 38728)

[2025-09-10 09:20:19] ОШИБКА: Сервер мониторинга https://test.com/monitoring/test/api недоступен или вернул ошибку

[2025-09-10 09:36:58] Процесс 'test' был перезапущен (старый PID: 38728, новый PID: 40264)

[2025-09-10 09:36:59] Успешный запрос к https://test.com/monitoring/test/api (PID: 40264)

[2025-09-10 09:38:15] Процесс 'test' был перезапущен (старый PID: 40264, новый PID: 40396)

[2025-09-10 09:38:16] Успешный запрос к https://test.com/monitoring/test/api (PID: 40396)
