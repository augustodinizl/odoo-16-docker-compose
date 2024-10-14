#!/bin/bash

# Caminho do arquivo YAML
YAML_FILE="/etc/repos.yml"

echo "Iniciando atualização de repositórios..."

# Verificar se o git-aggregator está instalado
if ! command -v git-aggregator &> /dev/null; then
    echo "git-aggregator não encontrado, instalando..."
    pip3 install git-aggregator
fi

# Verificar se o arquivo YAML existe
if [ -f "$YAML_FILE" ]; then
    echo "Atualizando repositórios listados em $YAML_FILE..."
    git-aggregator $YAML_FILE || { echo "Erro ao atualizar repositórios"; exit 1; }
else
    echo "Arquivo repos.yml não encontrado em $YAML_FILE"
fi

echo "Atualização de repositórios concluída."

# Iniciar o Odoo normalmente após a atualização dos repositórios
exec odoo "$@"
