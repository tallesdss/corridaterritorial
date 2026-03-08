# 🏗️ 02 — Arquitetura Frontend

## 🎯 Função deste Documento

Este documento detalha **COMO** o sistema é construído tecnicamente no **frontend Flutter**. Aqui ficam documentadas a **arquitetura de camadas**, os **modelos de dados**, os **mock services** e o **fluxo de estado** da aplicação.

**Use este documento para:**
- Entender a estrutura técnica do projeto antes de implementar novas features
- Consultar os modelos de dados e suas propriedades
- Saber quais mock services existem e como substituí-los por backend real no futuro
- Orientar decisões de arquitetura para novas funcionalidades

> ⚠️ **100% Frontend:** Nesta fase, não há backend real. Todos os dados vêm de **mock services** locais que poderão ser substituídos por integrações reais (Supabase, Firebase, etc.) no futuro.

---

## 📐 Arquitetura Geral

```
┌─────────────────────────────────────┐
│           Flutter App (Dart)        │
│  ┌──────────┐  ┌─────────────────┐  │
│  │ Screens  │  │    Providers    │  │
│  │ (UI)     │◄─┤  (Riverpod)    │  │
│  └──────────┘  └────────┬────────┘  │
│                         │           │
│              ┌──────────▼────────┐  │
│              │    Services       │  │
│              │  (Mock Services)  │  │
│              └──────────┬────────┘  │
│                         │           │
│              ┌──────────▼────────┐  │
│              │   Mock Data       │  │
│              │  (Dados Locais)   │  │
│              └───────────────────┘  │
└─────────────────────────────────────┘
```

> 💡 No futuro, a camada **Mock Services** será substituída por **serviços reais** que se comunicam com um backend, sem alterar UI ou Providers.

---

## 📱 Arquitetura do Frontend (Flutter)

| Camada       | Pasta           | Responsabilidade                                        |
|-------------|-----------------|--------------------------------------------------------|
| **UI**       | `screens/`      | Telas completas do aplicativo                           |
| **Widgets**  | `widgets/`      | Componentes reutilizáveis (cards, botões, métricas)     |
| **Estado**   | `providers/`    | Gerenciamento de estado global com Riverpod             |
| **Serviços** | `services/`     | Mock services (substituíveis por backend no futuro)     |
| **Modelos**  | `models/`       | Classes de dados (User, Run, Territory)                 |
| **Mocks**    | `mocks/`        | Dados mockados estáticos para simular backend           |
| **Rotas**    | `routes/`       | Configuração de navegação com GoRouter                  |
| **Tema**     | `theme/`        | Cores, tipografia e estilos do Design System            |

### Tecnologias do Frontend

- **Flutter/Dart** — Framework mobile cross-platform
- **Riverpod** — Gerenciamento de estado reativo
- **GoRouter** — Navegação declarativa com deep linking
- **Google Maps Flutter** — Renderização de mapas e territórios
- **Geolocator** — Acesso ao GPS para rastreamento de corridas
- **Google Fonts** — Tipografia customizada (Inter)

---

## 📦 Modelos de Dados

### `UserModel`
| Campo        | Tipo     | Descrição                        |
|-------------|----------|----------------------------------|
| `id`         | String   | Identificador único do usuário    |
| `username`   | String   | Nome de exibição do corredor      |
| `email`      | String   | E-mail do usuário                 |
| `avatarUrl`  | String   | URL ou caminho do avatar          |
| `createdAt`  | DateTime | Data de criação                   |

### `RunModel` (Corridas)
| Campo          | Tipo          | Descrição                        |
|---------------|---------------|----------------------------------|
| `id`           | String        | Identificador único da corrida    |
| `userId`       | String        | Referência ao corredor            |
| `distanceKm`   | double        | Distância percorrida em km        |
| `durationSec`  | int           | Duração em segundos               |
| `calories`     | int           | Calorias estimadas                |
| `avgPace`      | double        | Pace médio (min/km)               |
| `routePoints`  | List<LatLng>  | Pontos do trajeto (lat/lng)       |
| `createdAt`    | DateTime      | Data/hora da corrida              |

### `TerritoryModel` (Territórios)
| Campo          | Tipo          | Descrição                        |
|---------------|---------------|----------------------------------|
| `id`           | String        | Identificador do território       |
| `ownerId`      | String        | Corredor que domina o território  |
| `polygon`      | List<LatLng>  | Polígono geográfico do território |
| `areaSqm`      | double        | Área em metros quadrados          |
| `conqueredAt`  | DateTime      | Data da conquista                 |

### `RankerModel` (Ranking)
| Campo          | Tipo     | Descrição                        |
|---------------|----------|----------------------------------|
| `userId`       | String   | Referência ao corredor            |
| `username`     | String   | Nome do corredor                  |
| `avatarUrl`    | String   | Avatar do corredor                |
| `totalArea`    | double   | Área total conquistada            |
| `totalDistance` | double  | Distância total percorrida        |
| `totalConquests`| int    | Total de conquistas               |
| `rank`         | int      | Posição no ranking                |

---

## 🧪 Mock Services

Cada service possui uma interface que pode ser substituída por uma implementação real:

### `MockAuthService`
| Método                  | Comportamento Mockado                              | Substituição Futura          |
|------------------------|---------------------------------------------------|------------------------------|
| `signUp(email, pass)`  | Cria usuário local e retorna sucesso               | `supabase.auth.signUp()`     |
| `signIn(email, pass)`  | Valida contra dados mockados e retorna usuário     | `supabase.auth.signIn()`     |
| `signOut()`            | Limpa estado local                                 | `supabase.auth.signOut()`    |
| `resetPassword(email)` | Simula envio com delay e retorna sucesso          | `supabase.auth.resetPassword()` |
| `currentUser`          | Retorna usuário mockado se "logado"                | `supabase.auth.currentUser`  |

### `MockRunService`
| Método                  | Comportamento Mockado                              | Substituição Futura          |
|------------------------|---------------------------------------------------|------------------------------|
| `getRuns(userId)`      | Retorna lista de corridas fictícias                | Query tabela `runs`          |
| `saveRun(run)`         | Adiciona corrida à lista local                     | Insert tabela `runs`         |
| `getRunById(id)`       | Retorna corrida específica da lista local          | Query tabela `runs`          |

### `MockTerritoryService`
| Método                    | Comportamento Mockado                            | Substituição Futura            |
|--------------------------|--------------------------------------------------|--------------------------------|
| `getTerritories()`       | Retorna polígonos pré-definidos                   | Query tabela `territories`     |
| `conquestTerritory(run)` | Calcula área localmente e adiciona à lista        | RPC `conquer_territory`        |

### `MockRankingService`
| Método                   | Comportamento Mockado                             | Substituição Futura            |
|-------------------------|--------------------------------------------------|--------------------------------|
| `getRanking(filter)`    | Retorna lista ordenada de corredores fictícios    | RPC `calculate_ranking`        |

---

## 🔑 Autenticação (Mockada)

O fluxo de autenticação funciona **100% local** com dados mockados:

1. **Cadastro** — Salva dados localmente e simula validação
2. **Login** — Valida e-mail/senha contra dados mockados, gera sessão local
3. **Recuperação de Senha** — Exibe UI completa, simula envio com delay
4. **Sessão** — Gerenciada via Riverpod StateProvider (persistência em memória)
5. **Logout** — Limpa estado e redireciona para Login

> 💡 No futuro, basta trocar `MockAuthService` por `SupabaseAuthService` sem alterar nenhuma tela.

---

## 📌 Notas

- A separação em **Services** e **Providers** garante que a troca para backend real seja simples
- Todos os mock services ficam na pasta `services/` com prefixo `mock_`
- Os dados mockados ficam na pasta `mocks/` como listas/objetos estáticos
- Consulte `designsystem.md` para o Design System visual