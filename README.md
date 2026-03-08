# 🏃 Corrida Territorial

> Aplicativo mobile Flutter que transforma corridas no mundo real em conquistas de território, combinando gamificação, mapas interativos e competição entre corredores.

---

## 📋 Sobre o Projeto

O **Corrida Territorial** é uma plataforma mobile construída em **Flutter** que transforma a atividade de corrida em uma experiência gamificada. Os usuários correm no mundo real e, ao completar percursos, conquistam territórios virtuais no mapa. A competição entre corredores acontece através de rankings e desafios, criando um loop de motivação contínua.

### Principais Funcionalidades

- 🗺️ **Mapa interativo** com territórios conquistáveis em tempo real
- 🏆 **Sistema de ranking** e leaderboard entre corredores
- 📊 **Métricas de corrida** (distância, calorias, pace, duração)
- 🎯 **Desafios e eventos** para engajamento contínuo
- 👤 **Perfil do corredor** com histórico e progresso

---

## 🛠️ Tecnologias

| Camada        | Tecnologia                     |
|---------------|--------------------------------|
| **Frontend**  | Flutter / Dart                 |
| **Backend**   | Supabase (Auth, Database, RLS) |
| **Mapas**     | Google Maps Flutter            |
| **Geolocalização** | Geolocator               |
| **Gerenciamento de Estado** | Riverpod         |
| **Navegação** | GoRouter                       |
| **Tipografia**| Google Fonts (Inter)           |

---

## 📂 Estrutura do Projeto

```
corrida_territorial/
├── lib/
│   ├── main.dart          # Ponto de entrada do app
│   ├── models/            # Modelos de dados (User, Territory, Run, etc.)
│   ├── providers/         # Providers Riverpod (estado global)
│   ├── routes/            # Configuração de rotas (GoRouter)
│   ├── screens/           # Telas do aplicativo
│   ├── services/          # Serviços (Supabase, Geolocation, etc.)
│   ├── theme/             # Tema e Design System
│   └── widgets/           # Componentes reutilizáveis
├── docs/                  # Documentação completa do projeto
│   ├── 01-requisitos-e-regras.md
│   ├── 02-arquitetura-e-backend.md
│   ├── 03-fluxo-e-telas.md
│   ├── 04-roadmap-e-sprints.md
│   └── 05-testes-e-bugs.md
├── designsystem.md        # Design System completo (cores, tipografia, componentes)
└── pubspec.yaml           # Dependências do projeto
```

---

## 📖 Documentação

A documentação do projeto está organizada em 5 arquivos dentro da pasta `docs/`:

| Arquivo | Função |
|---------|--------|
| [`01-requisitos-e-regras.md`](docs/docs/docs/docs/01-requisitos-e-regras.md) | Regras de negócio, funcionalidades e escopo do projeto |
| [`02-arquitetura-e-backend.md`](docs/docs/docs/docs/02-arquitetura-e-backend.md) | Arquitetura técnica, banco de dados e APIs |
| [`03-fluxo-e-telas.md`](docs/docs/docs/docs/03-fluxo-e-telas.md) | Jornada do usuário e descrição de cada tela |
| [`04-roadmap-e-sprints.md`](docs/docs/docs/docs/04-roadmap-e-sprints.md) | Planejamento de sprints e cronograma |
| [`05-testes-e-bugs.md`](docs/docs/docs/docs/05-testes-e-bugs.md) | Plano de testes, checklists e bugs conhecidos |

---

## 🚀 Como Rodar

```bash
# Clone o repositório
git clone https://github.com/tallesdss/corridaterritorial.git

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

---

## 🎨 Design System

O aplicativo segue um Design System inspirado em apps como **Nike Run Club** e **Strava**, com:

- **Tema escuro** com alto contraste
- **Cor primária:** `#C8FF2F` (verde-limão vibrante)
- **Tipografia:** Inter / SF Pro
- **Gamificação visual** com animações de feedback (território conquistado, novo recorde, level up)

Consulte o arquivo [`designsystem.md`](designsystem.md) para detalhes completos.

---

## 📄 Licença

Este projeto é privado e não está publicado no pub.dev.
