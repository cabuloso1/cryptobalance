# Estrutura do Frontend

Este documento descreve a estrutura e organização do frontend do projeto Crypto Portfolio.

## Tecnologias Principais

- **React**: Biblioteca JavaScript para construção de interfaces de usuário
- **React Router**: Gerenciamento de rotas no lado do cliente
- **Chart.js**: Biblioteca para criação de gráficos interativos
- **Tailwind CSS**: Framework CSS para estilização
- **Axios**: Cliente HTTP para comunicação com a API

## Estrutura de Diretórios

```
frontend/
├── public/                # Arquivos estáticos
│   ├── favicon.ico        # Ícone do site
│   ├── index.html         # Template HTML principal
│   └── assets/            # Outros recursos estáticos
│
├── src/                   # Código-fonte
│   ├── components/        # Componentes React reutilizáveis
│   │   ├── alerts/        # Componentes relacionados a alertas
│   │   ├── auth/          # Componentes de autenticação
│   │   ├── charts/        # Componentes de gráficos
│   │   ├── layout/        # Componentes de layout (Header, Footer, etc.)
│   │   └── ui/            # Componentes de interface genéricos
│   │
│   ├── context/           # Contextos React
│   │   ├── AuthContext.jsx       # Contexto de autenticação
│   │   └── PortfolioContext.jsx  # Contexto de portfólio
│   │
│   ├── hooks/             # Hooks personalizados
│   │   ├── useAuth.js     # Hook para autenticação
│   │   ├── usePortfolio.js # Hook para gerenciamento de portfólio
│   │   └── useAlerts.js   # Hook para gerenciamento de alertas
│   │
│   ├── pages/             # Componentes de página
│   │   ├── Home.jsx       # Página inicial
│   │   ├── Login.jsx      # Página de login
│   │   ├── Register.jsx   # Página de registro
│   │   ├── Dashboard.jsx  # Painel principal
│   │   ├── Portfolio.jsx  # Página de portfólio
│   │   ├── Market.jsx     # Página de mercado
│   │   ├── Alerts.jsx     # Página de alertas
│   │   ├── Profile.jsx    # Página de perfil
│   │   └── CryptoDetail.jsx # Página de detalhes de criptomoeda
│   │
│   ├── services/          # Serviços para comunicação com a API
│   │   ├── api.js         # Configuração do cliente Axios
│   │   ├── authService.js # Serviço de autenticação
│   │   ├── portfolioService.js # Serviço de portfólio
│   │   ├── cryptoService.js # Serviço de criptomoedas
│   │   └── alertService.js # Serviço de alertas
│   │
│   ├── utils/             # Utilitários
│   │   ├── formatters.js  # Funções para formatação de dados
│   │   ├── validators.js  # Funções para validação de dados
│   │   └── constants.js   # Constantes utilizadas no aplicativo
│   │
│   ├── App.jsx            # Componente principal
│   ├── App.css            # Estilos globais
│   ├── index.jsx          # Ponto de entrada
│   └── routes.jsx         # Configuração de rotas
│
├── .env                   # Variáveis de ambiente para desenvolvimento
├── .env.production        # Variáveis de ambiente para produção
├── package.json           # Dependências e scripts
└── vite.config.js         # Configuração do Vite
```

## Componentes Principais

### Layout

- **Header**: Barra de navegação superior com menu e informações do usuário
- **Footer**: Rodapé com informações do site e links úteis
- **Layout**: Componente que envolve todas as páginas com o Header e Footer

### Autenticação

- **ProtectedRoute**: Componente para proteger rotas que requerem autenticação
- **LoginForm**: Formulário de login
- **RegisterForm**: Formulário de registro

### Portfólio

- **AssetList**: Lista de ativos do portfólio
- **AssetForm**: Formulário para adicionar/editar ativos
- **AssetDetails**: Detalhes de um ativo específico

### Gráficos

- **PortfolioDistributionChart**: Gráfico de distribuição de ativos (gráfico de rosca)
- **PortfolioPerformanceChart**: Gráfico de evolução do portfólio ao longo do tempo
- **CryptoPriceChart**: Gráfico de preço de uma criptomoeda específica
- **TimeframeSelector**: Seletor de período de tempo para os gráficos

### Alertas

- **AlertForm**: Formulário para configurar alertas
- **AlertHistory**: Histórico de alertas
- **AlertFilter**: Filtro para o histórico de alertas

## Contextos

### AuthContext

Gerencia o estado de autenticação do usuário.

```javascript
{
  user: Object | null, // Informações do usuário logado
  isAuthenticated: Boolean, // Se o usuário está autenticado
  loading: Boolean, // Se está carregando informações de autenticação
  login: Function, // Função para fazer login
  register: Function, // Função para registrar um novo usuário
  logout: Function, // Função para fazer logout
  updateProfile: Function // Função para atualizar o perfil do usuário
}
```

### PortfolioContext

Gerencia o estado do portfólio do usuário.

```javascript
{
  portfolio: Object | null, // Informações do portfólio
  assets: Array, // Lista de ativos
  loading: Boolean, // Se está carregando informações do portfólio
  error: String | null, // Mensagem de erro, se houver
  addAsset: Function, // Função para adicionar um ativo
  updateAsset: Function, // Função para atualizar um ativo
  removeAsset: Function, // Função para remover um ativo
  refreshPrices: Function // Função para atualizar os preços
}
```

## Rotas

- `/`: Página inicial
- `/login`: Página de login
- `/register`: Página de registro
- `/dashboard`: Painel principal (protegida)
- `/portfolio`: Página de portfólio (protegida)
- `/market`: Página de mercado (protegida)
- `/crypto/:id`: Página de detalhes de criptomoeda (protegida)
- `/alerts`: Página de alertas (protegida)
- `/profile`: Página de perfil (protegida)

## Serviços

### api.js

Configuração do cliente Axios para comunicação com a API.

```javascript
import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Interceptor para adicionar o token de autenticação
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Interceptor para tratamento de erros
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

export default api;
```

### authService.js

Serviço para autenticação de usuários.

```javascript
import api from './api';

export const login = async (email, password) => {
  const response = await api.post('/auth/login', { email, password });
  return response.data;
};

export const register = async (name, email, password) => {
  const response = await api.post('/auth/register', { name, email, password });
  return response.data;
};

export const getProfile = async () => {
  const response = await api.get('/auth/profile');
  return response.data;
};

export const updateProfile = async (userData) => {
  const response = await api.put('/auth/profile', userData);
  return response.data;
};
```

## Hooks Personalizados

### useAuth.js

Hook para gerenciar a autenticação.

```javascript
import { useContext } from 'react';
import { AuthContext } from '../context/AuthContext';

export const useAuth = () => {
  const context = useContext(AuthContext);
  
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  
  return context;
};
```

### usePortfolio.js

Hook para gerenciar o portfólio.

```javascript
import { useContext } from 'react';
import { PortfolioContext } from '../context/PortfolioContext';

export const usePortfolio = () => {
  const context = useContext(PortfolioContext);
  
  if (!context) {
    throw new Error('usePortfolio must be used within a PortfolioProvider');
  }
  
  return context;
};
```

## Utilitários

### formatters.js

Funções para formatação de dados.

```javascript
// Formatar valor monetário
export const formatCurrency = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'USD',
  }).format(value);
};

// Formatar percentual
export const formatPercentage = (value) => {
  return new Intl.NumberFormat('pt-BR', {
    style: 'percent',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(value / 100);
};

// Formatar data
export const formatDate = (date) => {
  return new Intl.DateTimeFormat('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  }).format(new Date(date));
};
```

## Considerações de Desempenho

- Componentes são divididos em pequenas unidades reutilizáveis
- Contextos são utilizados para gerenciar o estado global
- Memoização é utilizada para evitar renderizações desnecessárias
- Lazy loading é utilizado para carregar componentes sob demanda
- Dados são armazenados em cache quando apropriado

