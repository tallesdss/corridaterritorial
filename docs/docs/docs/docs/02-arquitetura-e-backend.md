# 🏗️ 02 — Arquitetura Frontend

## 🎯 Função deste Documento

Este documento detalha **COMO** o sistema é construído tecnicamente no **frontend Flutter**. Aqui ficam documentadas a **arquitetura de camadas**, os **modelos de dados**, os **mock services** e o **fluxo de estado** da aplicação.

**Use este documento para:**
- Entender a estrutura técnica do projeto antes de implementar novas features
- Consultar os modelos de dados e suas propriedades
- Saber quais mock services existem e como substituí-los por backend real no futuro
- Orientar decisões de arquitetura para novas funcionalidades

> 🟢 **Backend Híbrido:** Nesta fase, a **Autenticação** já está integrada ao **Supabase Auth**. Outras funcionalidades (corridas, territórios, ranking) ainda utilizam **mock services** locais, sendo substituídas gradualmente conforme o plano de migração.

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

> 💡 A camada de **Autenticação** já foi migrada para o **Supabase**. As demais camadas de **Services** (Runs, Territories, Ranking) serão migradas nas próximas fases.

---

## 📱 Arquitetura do Frontend (Flutter)

| Camada       | Pasta           | Responsabilidade                                        |
|-------------|-----------------|--------------------------------------------------------|
| **UI**       | `screens/`      | Telas completas do aplicativo                           |
| **Widgets**  | `widgets/`      | Componentes reutilizáveis (cards, botões, métricas)     |
| **Estado**   | `providers/`    | Gerenciamento de estado global com Riverpod             |
| **Serviços** | `services/`     | Implementações reais (Supabase) e Mock services         |
| **Modelos**  | `models/`       | Classes de dados (User, Run, Territory)                 |
| **Mocks**    | `mocks/`        | Dados mockados estáticos (em transição para DB)         |
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

### `SupabaseAuthService` (Real)
| Método                  | Comportamento Real                                | Observação                  |
|------------------------|---------------------------------------------------|------------------------------|
| `signUp(email, pass)`  | Cria usuário no Supabase Auth                     | Metadata 'display_name'      |
| `signIn(email, pass)`  | Autentica no Supabase e retorna JWT               | Persistência automática      |
| `signOut()`            | Encerra sessão no Supabase                        | Limpa AuthProvider           |
| `resetPassword(email)` | Dispara e-mail de recuperação real                | Via Supabase SMTP            |
| `onAuthStateChanged`   | Stream de mudanças na sessão                      | Escutado pelo Provider       |

### `MockRunService` (Ainda mockado)
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

## 🔑 Autenticação (Real)

O fluxo de autenticação foi migrado para o **Supabase Auth**:

1. **Cadastro** — Cria registro no Supabase Auth e dispara trigger para criar perfil em `public.profiles`.
2. **Login** — Autenticação nativa com persistência de sessão (JWT).
3. **Recuperação de Senha** — Envio de link real via serviço de e-mail do Supabase.
4. **Sessão** — Gerenciada pelo `AuthProvider` que escuta o `onAuthStateChange`.
5. **Logout** — Desloga do Firebase/Supabase e retorna à tela de Login.

> 💡 A UI e os Providers não precisaram de grandes alterações devido à abstração da interface `AuthService`.

---

## 📌 Notas (01)


- A separação em **Services** e **Providers** garante que a troca para backend real seja simples
- Todos os mock services ficam na pasta `services/` com prefixo `mock_`
- Os dados mockados ficam na pasta `mocks/` como listas/objetos estáticos
- Consulte `designsystem.md` para o Design System visual