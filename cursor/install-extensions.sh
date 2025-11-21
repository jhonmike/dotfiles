#!/bin/bash

# Script para instalar extensões do Cursor a partir do arquivo extensions.txt
# Uso: ./install-extensions.sh

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXTENSIONS_FILE="$DOTFILES_DIR/cursor/extensions.txt"

if ! command -v cursor &> /dev/null; then
    echo "❌ Cursor CLI não encontrado. Instale o Cursor primeiro."
    exit 1
fi

if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "❌ Arquivo de extensões não encontrado: $EXTENSIONS_FILE"
    echo "💡 Execute primeiro: ./cursor/export-extensions.sh"
    exit 1
fi

echo "📦 Instalando extensões do Cursor..."

INSTALLED=0
FAILED=0

while IFS= read -r extension; do
    # Pular linhas vazias
    [ -z "$extension" ] && continue
    
    echo "📥 Instalando: $extension"
    if cursor --install-extension "$extension" --force &>/dev/null; then
        ((INSTALLED++))
        echo "   ✅ $extension"
    else
        ((FAILED++))
        echo "   ❌ $extension (falhou ou já instalada)"
    fi
done < "$EXTENSIONS_FILE"

echo ""
echo "✅ Instalação concluída!"
echo "   📦 $INSTALLED extensões instaladas"
[ $FAILED -gt 0 ] && echo "   ⚠️  $FAILED extensões falharam ou já estavam instaladas"

