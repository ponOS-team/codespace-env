FROM alpine:latest

# Устанавливаем Bash (стандарт для Codespaces), sudo, git и инструменты для сборки
RUN apk add --no-cache \
    bash \
    sudo \
    git \
    build-base \
    util-linux \
    coreutils \
    tar \
    curl \
    shadow

# Создаем пользователя vscode (как того требует GitHub) и даем ему sudo без пароля
RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode

# Переключаемся на пользователя vscode
USER vscode
WORKDIR /workspaces/
