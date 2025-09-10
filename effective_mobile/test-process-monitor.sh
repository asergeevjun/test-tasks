#!/bin/bash

# проверка наличия curl и pgrep
command -v curl >/dev/null || { echo "curl не установлен"; exit 1; }
command -v pgrep >/dev/null || { echo "pgrep не установлен"; exit 1; }

# путь к log файлу
LOG_FILE="/var/log/monitoring.log"
# имя процесса
PROCESS_NAME="test"
# URL для отправки статуса
MONITORING_URL="https://test.com/monitoring/test/api"
# файл для хранения PID предыдущего запуска (для отслеживания перезапуска)
PID_FILE="/var/run/test-process.pid"

# создаем лог-файл, если не существует, и задаем права
touch "$LOG_FILE" 2>/dev/null || { echo "Не удалось создать лог-файл. Проверьте права."; exit 1; }
chmod 644 "$LOG_FILE" 2>/dev/null

# функция логирования
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# проверяем, запущен ли процесс
if pgrep "$PROCESS_NAME" > /dev/null; then

    # получаем текущий PID процесса
    CURRENT_PID=$(pgrep "$PROCESS_NAME" | head -n1)

    # проверяем, менялся ли PID
    if [ -f "$PID_FILE" ]; then
        PREVIOUS_PID=$(cat "$PID_FILE")
        if [ "$CURRENT_PID" != "$PREVIOUS_PID" ]; then
            log_message "Процесс '$PROCESS_NAME' был перезапущен (старый PID: $PREVIOUS_PID, новый PID: $CURRENT_PID)"
        fi
    else
        log_message "Процесс '$PROCESS_NAME' запущен впервые (PID: $CURRENT_PID)"
    fi

    # сохраняем текущий PID
    echo "$CURRENT_PID" > "$PID_FILE"

    # отправляем запрос на сервер мониторинга
    if curl -s -f -k --max-time 10 "$MONITORING_URL" > /dev/null; then
        log_message "Успешный запрос к $MONITORING_URL (PID: $CURRENT_PID)"
    else
        log_message "ОШИБКА: Сервер мониторинга $MONITORING_URL недоступен или вернул ошибку"
    fi

else
    :
fi
