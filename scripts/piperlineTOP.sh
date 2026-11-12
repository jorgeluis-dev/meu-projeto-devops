#!/bin/bash

# Definição de cores ANSI
CIANO='\033[1;36m'
VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
AMARELO='\033[1;33m'
CINZA='\033[0;90m'
NC='\033[0m'

# Função da barra de progresso animada
barra_progresso() {
    local total=35
    for ((i=1; i<=total; i++)); do
        # Monta a parte preenchida (amarela) e a vazia (cinza)
        local cheia=$(printf "%${i}s" | tr ' ' '━')
        local vazia=$(printf "%$((total-i))s" | tr ' ' '━')
        
        # \r volta o cursor para o início da linha para animar
        echo -ne "\r${CINZA}│${NC}  ${AMARELO}${cheia}${CINZA}${vazia}${NC}"
        sleep 0.03
    done
    echo "" # Pula linha ao terminar
}

# Cabeçalho
echo -e "${CIANO}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${CIANO}║  🏭  ESTEIRA DEVOPS - BOOTCAMP 2026                    ║${NC}"
echo -e "${CIANO}║      build  →  test  →  deploy                         ║${NC}"
echo -e "${CIANO}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CINZA}iniciada por $(whoami)@$(hostname) as $(date +%H:%M:%S)${NC}"
echo ""

falha_pipeline() {
    echo -e "${CINZA}⊘ DEPLOY nao executou${NC}"
    echo ""
    echo -e "${VERMELHO}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${VERMELHO}║  ✘  PIPELINE VERMELHA - esteira parada                 ║${NC}"
    echo -e "${VERMELHO}║  ♥  producao protegida: nada foi publicado             ║${NC}"
    echo -e "${VERMELHO}╚════════════════════════════════════════════════════════╝${NC}"
    exit 1
}

# ---------------- STAGE 1: BUILD ----------------
echo -e "${CINZA}┌─${NC} 🔨 ${CIANO}STAGE 1/3 · BUILD${NC}"
INICIO=$SECONDS
if ./build.sh; then
    barra_progresso
    TEMPO=$((SECONDS - INICIO))
    echo -e "${CINZA}└─${NC} ${VERDE}✔ BUILD passou (${TEMPO}s)${NC}"
    echo ""
else
    echo -e "${CINZA}└─${NC} ${VERMELHO}✘ BUILD FALHOU${NC}"
    falha_pipeline
fi

# ---------------- STAGE 2: TEST ----------------
echo -e "${CINZA}┌─${NC} 🔍 ${CIANO}STAGE 2/3 · TEST${NC}"
INICIO=$SECONDS
if ./test.sh; then
    barra_progresso
    TEMPO=$((SECONDS - INICIO))
    echo -e "${CINZA}└─${NC} ${VERDE}✔ TEST passou (${TEMPO}s)${NC}"
    echo ""
else
    echo -e "${CINZA}└─${NC} ${VERMELHO}✘ TEST FALHOU${NC}"
    falha_pipeline
fi

# ---------------- STAGE 3: DEPLOY ----------------
echo -e "${CINZA}┌─${NC} 🚀 ${CIANO}STAGE 3/3 · DEPLOY${NC}"
INICIO=$SECONDS
if ./deploy.sh; then
    barra_progresso
    TEMPO=$((SECONDS - INICIO))
    echo -e "${CINZA}└─${NC} ${VERDE}✔ DEPLOY passou (${TEMPO}s)${NC}"
    echo ""
else
    echo -e "${CINZA}└─${NC} ${VERMELHO}✘ DEPLOY FALHOU${NC}"
    falha_pipeline
fi

# ---------------- SUCESSO TOTAL ----------------
echo -e "${VERDE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${VERDE}║  ✔  PIPELINE VERDE - aplicacao em producao!            ║${NC}"
echo -e "${VERDE}╚════════════════════════════════════════════════════════╝${NC}"

