# Деплой Redmine с помощью Ansible и Docker

### Hexlet tests and linter status:
[![Actions Status](https://github.com/vic10898/devops-for-developers-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/vic10898/devops-for-developers-project-76/actions)

Этот проект автоматизирует установку Docker, настройку окружения и деплой Redmine на серверы приложений в Yandex Cloud с помощью Ansible.

## Ссылка на задеплоенное приложение

Вы можете получить доступ к задеплоенному приложению по следующим адресам:
- **HTTP**: [http://magical-lovelace.ru](http://magical-lovelace.ru)
- **HTTPS**: [https://magical-lovelace.ru](https://magical-lovelace.ru) *(после настройки TLS на балансировщике)*

## Требования

Для запуска проекта на локальной машине должны быть установлены:
- Python 3.x
- Ansible (версии 2.15+)

## Подготовка к деплою

1. **Установка зависимостей (ролей Ansible Galaxy)**:
   Скачайте необходимые внешние роли (`geerlingguy.pip` и `geerlingguy.docker`) с помощью команды:
   ```bash
   make install-deps
   ```

2. **Настройка инвентаря**:
   Отредактируйте файл `inventory.ini` в корне проекта, указав IP-адреса ваших серверов, имя пользователя для деплоя и путь к приватному SSH-ключу:
   ```ini
   [webservers]
   app-1 ansible_host=51.250.6.245 ansible_user=yc-user ansible_ssh_private_key_file=~/.ssh/id_ed25519
   app-2 ansible_host=158.160.3.92 ansible_user=yc-user ansible_ssh_private_key_file=~/.ssh/id_ed25519
   ```

3. **Настройка переменных**:
   Проверьте и при необходимости отредактируйте переменные в файлах `group_vars/all/vars.yml` (публичные конфигурации) и `group_vars/webservers/vault.yml` (зашифрованные секреты, такие как пароли и API-ключи).

## Использование

### Полная настройка серверов и деплой

Для первоначальной настройки серверов (установка pip, Docker) и деплоя выполните:
```bash
make setup
```

### Только деплой приложения

Для обновления приложения без изменения конфигурации и настроек серверов выполните:
```bash
make deploy
```
*Эта команда использует Ansible Tags (`--tags deploy`) для запуска только задач деплоя.*

## Тестирование и проверка

### Проверка синтаксиса Ansible
Перед запуском плейбука вы можете проверить корректность синтаксиса конфигурации:
```bash
ansible-playbook playbook.yml --syntax-check
```

### Проверка состояния мониторинга (Datadog Agent)
После успешного деплоя вы можете проверить состояние агента Datadog и работоспособность интеграции `http_check` непосредственно на сервере:
1. Подключитесь к одному из серверов приложений по SSH.
2. Выполните команду проверки статуса агента:
   ```bash
   sudo datadog-agent status
   ```
   В разделе `Running Checks` вы должны увидеть статус `[OK]` для проверки `http_check`.
