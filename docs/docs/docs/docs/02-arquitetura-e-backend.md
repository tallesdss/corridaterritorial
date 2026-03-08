# 🏗️ 02 — Arquitetura e Backend

## 🎯 Função deste Documento

Este documento detalha **COMO** o sistema é construído tecnicamente. Aqui ficam documentadas a **arquitetura do frontend Flutter**, a **estrutura do banco de dados no Supabase**, as **políticas de segurança (RLS)**, o **fluxo de autenticação** e as **APIs/RPCs** que o frontend utiliza.

**Use este documento para:**
- Entender a estrutura técnica do projeto antes de implementar novas features
- Consultar o schema do banco de dados e suas relações
- Verificar as políticas de segurança antes de criar novas tabelas
- Saber quais endpoints e RPCs estão disponíveis para o frontend
- Orientar decisões de arquitetura para novas funcionalidades

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
│              │ (Supabase Client) │  │
│              └──────────┬────────┘  │
└─────────────────────────┼───────────┘
                          │ HTTPS
              ┌───────────▼───────────┐
              │      Supabase         │
              │  ┌─────────────────┐  │
              │  │  Auth Service   │  │
              │  │  PostgreSQL DB  │  │
              │  │  RLS Policies   │  │
              │  │  Edge Functions │  │
              │  └─────────────────┘  │
              └───────────────────────┘
```

---

## 📱 Arquitetura do Frontend (Flutter)

| Camada       | Pasta         | Responsabilidade                                        |
|-------------|---------------|--------------------------------------------------------|
| **UI**       | `screens/`    | Telas completas do aplicativo                           |
| **Widgets**  | `widgets/`    | Componentes reutilizáveis (cards, botões, métricas)     |
| **Estado**   | `providers/`  | Gerenciamento de estado global com Riverpod             |
| **Serviços** | `services/`   | Comunicação com Supabase, Geolocator e APIs externas    |
| **Modelos**  | `models/`     | Classes de dados (User, Run, Territory)                 |
| **Rotas**    | `routes/`     | Configuração de navegação com GoRouter                  |
| **Tema**     | `theme/`      | Cores, tipografia e estilos do Design System            |

### Tecnologias do Frontend

- **Flutter/Dart** — Framework mobile cross-platform
- **Riverpod** — Gerenciamento de estado reativo
- **GoRouter** — Navegação declarativa com deep linking
- **Google Maps Flutter** — Renderização de mapas e territórios
- **Geolocator** — Acesso ao GPS para rastreamento de corridas
- **Google Fonts** — Tipografia customizada (Inter)

---

## 🗄️ Estrutura do Banco de Dados (Supabase/PostgreSQL)

### Tabelas Principais

#### `profiles`
| Coluna       | Tipo      | Descrição                        |
|-------------|-----------|----------------------------------|
| `id`         | UUID (PK) | Referência ao `auth.users.id`     |
| `username`   | TEXT      | Nome de exibição do corredor      |
| `avatar_url` | TEXT      | URL do avatar                     |
| `created_at` | TIMESTAMP | Data de criação                   |

#### `runs` (Corridas)
| Coluna          | Tipo      | Descrição                        |
|----------------|-----------|----------------------------------|
| `id`            | UUID (PK) | Identificador único da corrida    |
| `user_id`       | UUID (FK) | Referência ao corredor            |
| `distance_km`   | FLOAT     | Distância percorrida em km        |
| `duration_sec`   | INT       | Duração em segundos               |
| `calories`      | INT       | Calorias estimadas                |
| `avg_pace`      | FLOAT     | Pace médio (min/km)               |
| `route_points`  | JSONB     | Pontos do trajeto (lat/lng)       |
| `created_at`    | TIMESTAMP | Data/hora da corrida              |

#### `territories` (Territórios)
| Coluna          | Tipo      | Descrição                        |
|----------------|-----------|----------------------------------|
| `id`            | UUID (PK) | Identificador do território       |
| `owner_id`      | UUID (FK) | Corredor que domina o território  |
| `polygon`       | JSONB     | Polígono geográfico do território |
| `area_sqm`      | FLOAT     | Área em metros quadrados          |
| `conquered_at`  | TIMESTAMP | Data da conquista                 |

---

## 🔐 Políticas de Segurança (RLS)

O Supabase utiliza **Row Level Security** para proteger os dados:

- **Profiles:** Qualquer usuário pode **ler** todos os perfis (ranking público). Apenas o próprio usuário pode **editar** seu perfil.
- **Runs:** Cada usuário pode **ler** e **inserir** apenas suas próprias corridas.
- **Territories:** Todos podem **ler** territórios (exibição no mapa). Apenas o sistema pode **atualizar** o dono de um território.

---

## 🔑 Autenticação

O fluxo de autenticação utiliza o **Supabase Auth**:

1. **Cadastro** — E-mail + Senha com confirmação via e-mail
2. **Login** — E-mail + Senha com token JWT
3. **Recuperação de Senha** — Link enviado por e-mail
4. **Sessão** — Gerenciada automaticamente pelo Supabase Client
5. **Logout** — Encerra a sessão e limpa o token local

---

## 📡 APIs e RPCs

| Endpoint/RPC               | Método | Descrição                                          |
|----------------------------|--------|----------------------------------------------------|
| `supabase.auth.signUp()`   | POST   | Cadastro de novo usuário                           |
| `supabase.auth.signIn()`   | POST   | Login com e-mail e senha                           |
| `supabase.auth.resetPassword()` | POST | Envia link de recuperação de senha              |
| `profiles` (table)          | CRUD   | Gerenciamento de perfis de corredores              |
| `runs` (table)              | CRUD   | Registro e consulta de corridas                    |
| `territories` (table)       | CRUD   | Consulta e atualização de territórios              |
| `rpc('calculate_ranking')`  | POST   | Calcula e retorna o ranking atualizado             |
| `rpc('conquer_territory')` | POST   | Processa a conquista de um território após corrida |