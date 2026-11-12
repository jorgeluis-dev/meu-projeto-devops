#!/bin/bash

# 2) Disco: acima de 80% de uso, alerta
USO_DISCO=$(df / --output=pcent | tail -1 | tr -d ' %')
if [ "$USO_DISCO" -lt 80 ]; then
    echo "[OK] Disco: ${USO_DISCO}% usado"
else
    echo "[FALHA] Disco: ${USO_DISCO}% usado (acima de 80%!)"
fi
