#!/bin/bash

# Script para exportar extensões instaladas do Cursor
# Uso: ./export-extensions.sh

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXTENSIONS_FILE="$DOTFILES_DIR/cursor/extensions.txt"

if ! command -v cursor &> /dev/null; then
    echo "❌ Cursor CLI não encontrado. Instale o Cursor primeiro."
    exit 1
fi

echo "📦 Exportando extensões do Cursor..."

# Listar extensões instaladas
cursor --list-extensions > "$EXTENSIONS_FILE"

if [ $? -eq 0 ]; then
    EXTENSION_COUNT=$(wc -l < "$EXTENSIONS_FILE" | tr -d ' ')
    echo "✅ $EXTENSION_COUNT extensões exportadas para: $EXTENSIONS_FILE"
    echo ""
    echo "📝 Extensões exportadas:"
    cat "$EXTENSIONS_FILE"
else
    echo "❌ Erro ao exportar extensões"
    exit 1
fi

