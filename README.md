# Crypto Portfolio Tracker

Um aplicativo web completo para acompanhamento de carteira de criptomoedas, com painel dinâmico, gráficos interativos e sistema de alertas.

## Funcionalidades

- **Painel Dinâmico**: Visualize todos os seus ativos de criptomoedas em um só lugar
- **Preços em Tempo Real**: Integração com a API do CoinMarketCap para obter preços atualizados
- **Gráficos Interativos**: Visualize a evolução do seu portfólio e a distribuição de ativos
- **Sistema de Alertas**: Configure alertas para grandes variações de preço
- **Autenticação de Usuários**: Sistema completo de registro e login para proteger seus dados

## Tecnologias Utilizadas

### Frontend
- React
- Chart.js para gráficos interativos
- Tailwind CSS para estilização

### Backend
- Node.js com Express
- MongoDB para armazenamento de dados
- JWT para autenticação

### Integração
- API do CoinMarketCap para dados de criptomoedas

## Requisitos

- Node.js 18+
- MongoDB
- Chave de API do CoinMarketCap

## Instalação e Execução Local

### Configuração do Backend

1. Clone o repositório:
   ```
   git clone https://github.com/seu-usuario/crypto-portfolio.git
   cd crypto-portfolio
   ```

2. Instale as dependências do backend:
   ```
   cd backend
   npm install
   ```

3. Configure as variáveis de ambiente:
   - Crie um arquivo `.env` baseado no `.env.example`
   - Adicione sua chave de API do CoinMarketCap
   - Configure a conexão com o MongoDB

4. Inicie o servidor:
   ```
   npm run dev
   ```

### Configuração do Frontend

1. Instale as dependências do frontend:
   ```
   cd ../frontend
   npm install
   ```

2. Configure as variáveis de ambiente:
   - Crie um arquivo `.env` baseado no `.env.example`
   - Configure a URL da API do backend

3. Inicie o servidor de desenvolvimento:
   ```
   npm run dev
   ```

4. Acesse o aplicativo em `http://localhost:5173`

## Implantação em Produção

### Usando Docker

O projeto inclui arquivos Docker e docker-compose para facilitar a implantação:

1. Certifique-se de ter Docker e Docker Compose instalados
2. Execute o script de implantação:
   ```
   ./deploy.sh
   ```
3. Acesse o frontend em `http://localhost` e o backend em `http://localhost:5000`

### Implantação Manual

#### Backend

1. Configure as variáveis de ambiente para produção:
   - Use o arquivo `.env.production`
   - Certifique-se de definir `NODE_ENV=production`

2. Construa e inicie o servidor:
   ```
   cd backend
   npm install --production
   npm start
   ```

#### Frontend

1. Construa o frontend para produção:
   ```
   cd frontend
   npm run build
   ```

2. Implante os arquivos da pasta `dist` em um servidor web como Nginx ou Apache

## Opções de Hospedagem

### Frontend
- **Vercel**: Implantação simples com o arquivo `vercel.json` incluído
- **Netlify**: Configuração pronta com o arquivo `netlify.toml`
- **GitHub Pages**: Exporte o build e implante no GitHub Pages

### Backend
- **Heroku**: Use o `Procfile` incluído para implantação
- **DigitalOcean**: Implante usando Docker com o `docker-compose.yml`
- **AWS**: Implante no EC2 ou use o Elastic Beanstalk

## Estrutura do Projeto

```
crypto-portfolio/
├── backend/               # Código do servidor Node.js
│   ├── config/            # Configurações do servidor
│   ├── controllers/       # Controladores da API
│   ├── models/            # Modelos do MongoDB
│   ├── routes/            # Rotas da API
│   ├── middleware/        # Middleware personalizado
│   ├── services/          # Serviços de negócios
│   └── utils/             # Utilitários
├── frontend/              # Código do cliente React
│   ├── public/            # Arquivos estáticos
│   └── src/               # Código-fonte
│       ├── components/    # Componentes React
│       ├── pages/         # Páginas da aplicação
│       ├── context/       # Contextos React
│       ├── hooks/         # Hooks personalizados
│       └── utils/         # Utilitários
└── docker-compose.yml     # Configuração do Docker Compose
```

## Manutenção e Atualizações

- **Atualizações da API**: Verifique regularmente a documentação da API do CoinMarketCap para mudanças
- **Dependências**: Mantenha as dependências atualizadas com `npm audit` e `npm update`
- **Backups**: Configure backups regulares do banco de dados MongoDB

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.

## Contato

Para suporte ou dúvidas, entre em contato através de [seu-email@exemplo.com](mailto:seu-email@exemplo.com).

