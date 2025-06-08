#!/bin/bash

# Script para iniciar o projeto localmente para desenvolvimento

# Cores para saída
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Iniciando o projeto Crypto Portfolio para desenvolvimento...${NC}"

# Verificar se o MongoDB está em execução
echo -e "${YELLOW}Verificando se o MongoDB está em execução...${NC}"
if ! pgrep -x "mongod" > /dev/null; then
    echo -e "${RED}MongoDB não está em execução. Por favor, inicie o MongoDB antes de continuar.${NC}"
    echo -e "${YELLOW}Você pode iniciar o MongoDB com o comando: mongod --dbpath=/data/db${NC}"
    exit 1
fi

# Iniciar o backend
echo -e "${YELLOW}Iniciando o backend...${NC}"
cd backend
npm run dev &
BACKEND_PID=$!
cd ..

# Aguardar o backend iniciar
echo -e "${YELLOW}Aguardando o backend iniciar...${NC}"
sleep 5

# Iniciar o frontend
echo -e "${YELLOW}Iniciando o frontend...${NC}"
cd frontend
npm run dev &
FRONTEND_PID=$!
cd ..

# Exibir informações
echo -e "${GREEN}Projeto iniciado com sucesso!${NC}"
echo -e "${GREEN}Frontend disponível em: http://localhost:5173${NC}"
echo -e "${GREEN}Backend disponível em: http://localhost:5000${NC}"
echo -e "${YELLOW}Pressione Ctrl+C para encerrar ambos os serviços${NC}"

# Função para encerrar os processos ao sair
function cleanup {
    echo -e "${YELLOW}Encerrando os serviços...${NC}"
    kill $BACKEND_PID
    kill $FRONTEND_PID
    echo -e "${GREEN}Serviços encerrados com sucesso!${NC}"
    exit 0
}

# Capturar sinal de interrupção (Ctrl+C)
trap cleanup SIGINT

# Manter o script em execução
while true; do
    sleep 1
done

