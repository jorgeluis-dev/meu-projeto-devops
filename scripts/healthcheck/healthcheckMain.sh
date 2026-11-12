#!/bin/bash
set -e

# Diretório onde o script principal está localizado
DIR_BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1) Exibe o cabeçalho primeiro
echo "=== Health Check - $(hostname) - $(date '+%d/%m/%Y %H:%M') ==="

# 2) Importa e executa cada módulo na ordem exata que você quer
source "$DIR_BASE/modules/internet.sh"
source "$DIR_BASE/modules/disco.sh"

# 3) Finaliza
echo "=== Fim do health check ==="
