#!/bin/bash

# Diretório deste repositório
DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

# Navega até o diretório do dotfiles
cd "$DOTFILES_DIR"

# Verifica se há alterações
if [[ -z $(git status --porcelain) ]]; then
    echo "Nenhuma modificação detectada."
    exit 0
fi

# Exibe o status atual para revisão
git status

# Mensagem de commit
COMMIT_MSG="$1"
if [[ -z "$COMMIT_MSG" ]]; then
    # Se não for fornecida uma mensagem, usa a data atual
    COMMIT_MSG="Sync: $(date '+%Y-%m-%d %H:%M:%S')"
fi

# Adiciona todas as modificações (incluindo novos arquivos e binários no diretório bin/)
echo "Adicionando modificações..."
git add .

# Realiza o commit
echo "Realizando commit: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# Realiza o push para o repositório remoto
echo "Enviando para o repositório remoto..."
git push origin $(git rev-parse --abbrev-ref HEAD)

echo "Sincronização concluída com sucesso!"
