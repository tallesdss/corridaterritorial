# 🖥️ 03 — Fluxo de Navegação e Telas

## 🎯 Função deste Documento

Este documento descreve a **jornada do usuário** dentro do aplicativo e detalha **cada tela** com seus componentes visuais, ações possíveis e para onde cada interação leva. É o mapa de navegação completo do Corrida Territorial.

**Use este documento para:**
- Entender o fluxo completo de navegação do app
- Saber quais componentes cada tela deve conter antes de implementá-la
- Validar se a experiência do usuário está coerente
- Planejar a implementação de novas telas e transições
- Servir como referência para designers e desenvolvedores

> 🟢 **Dados Reais (Auth):** A autenticação (Login, Cadastro, Recuperação de Senha) já consome dados reais via **Supabase**. As demais telas ainda dependem de **mock services** locais que serão migrados nas fases seguintes.

---

## 🧭 Fluxo Geral de Navegação

```
                    ┌──────────────┐
                    │  Splash /    │
                    │  Onboarding  │
                    └──────┬───────┘
                           │
              ┌────────────▼────────────┐
              │  Usuário autenticado?   │
              │  (Supabase Auth Session) │
              └────────────┬────────────┘
                     Não / │ \ Sim
                      ┌────┘  └────┐
                      ▼            ▼
              ┌──────────┐  ┌──────────┐
              │  Login   │  │   Home   │
              └────┬─────┘  └────┬─────┘
                   │             │
          ┌────────┼──────┐     │
          ▼        ▼      ▼     │
     Cadastro  Recuperar  ──────┘
               Senha
                           │
              ┌────────────▼────────────┐
              │   Bottom Navigation     │
              │                         │
              │  Home | Community |     │
              │  Activity | Progress | │
              │  Profile                │
              └─────────────────────────┘
```

---

## 📱 Descrição de Cada Tela

### 1. [x] Tela de Splash / Onboarding

**Rota:** `/onboarding`

| Componente    | Descrição                                          |
|--------------|-----------------------------------------------------|
| Hero Image    | Imagem/ilustração motivacional de corrida           |
| Título        | Nome do app e tagline                                |
| Subtítulo     | Breve descrição do conceito                          |
| Botão CTA     | "Começar" → Leva para **Cadastro**                  |
| Link Login    | "Já tenho conta" → Leva para **Login**               |

---

### 2. [x] Tela de Login

**Rota:** `/login`

| Componente         | Descrição                                      |
|-------------------|------------------------------------------------|
| Campo E-mail       | Input para e-mail do usuário                   |
| Campo Senha        | Input para senha (com toggle de visibilidade)  |
| Botão "Entrar"     | Autentica via SupabaseAuthService → redireciona para **Home** |
| Link "Esqueci minha senha" | Leva para **Recuperar Senha**          |
| Link "Criar conta" | Leva para **Cadastro**                        |

**Fluxos:**
- Login com sucesso (Real) → **Home**
- Credenciais inválidas → Mensagem de erro do Supabase
- "Esqueci minha senha" → **Recuperar Senha**

**Dados:** SupabaseAuthService valida credenciais no backend real.

---

### 3. [x] Tela de Cadastro

**Rota:** `/register`

| Componente         | Descrição                                      |
|-------------------|------------------------------------------------|
| Campo Nome         | Nome de exibição do corredor                   |
| Campo E-mail       | E-mail para cadastro                           |
| Campo Senha        | Senha com requisitos mínimos                   |
| Campo Confirmar Senha | Confirmação de senha                        |
| Botão "Cadastrar"  | Cria conta no Supabase (Real) → redireciona para **Home** |
| Link "Já tenho conta" | Volta para **Login**                        |

**Dados:** SupabaseAuthService cria usuário no auth.users e trigger cria `profiles`.

---

### 4. [x] Tela de Recuperar Senha

**Rota:** `/forgot-password`

| Componente         | Descrição                                      |
|-------------------|------------------------------------------------|
| Campo E-mail       | E-mail cadastrado                              |
| Botão "Enviar"     | Dispara e-mail de recuperação real via Supabase |
| Mensagem de sucesso | Confirma que o e-mail foi enviado |
| Link "Voltar"      | Retorna para **Login**                         |

**Dados:** SupabaseAuthService dispara processo de reset Password.

---

### 5. [x] Tela Home (Dashboard)

**Rota:** `/home`

| Componente         | Descrição                                      |
|-------------------|------------------------------------------------|
| Saudação           | "Olá, {nome}!" com horário contextual (dados mockados) |
| Card de Progresso  | Métricas resumidas — km rodados, territórios (mockados) |
| Card de Desafios   | Desafios ativos do momento (dados mockados)    |
| Card de Eventos    | Eventos da comunidade (dados mockados)          |
| FAB "Iniciar Corrida" | Botão flutuante → Leva para **Tela de Corrida** |
| Bottom Navigation  | Navegação entre as abas principais              |

**Dados:** MockRunService, MockRankingService fornecem métricas e desafios.

---

### 6. [x] Tela de Corrida (Running Screen)

**Rota:** `/run`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Mapa (fullscreen)    | Google Maps com a posição do usuário em tempo real |
| Trajeto              | Linha desenhada no mapa conforme o corredor se move |
| Overlay de Métricas  | Painel com: Distância, Calorias, Pace, Duração |
| Botão Pausar         | Pausa a corrida e o rastreamento GPS           |
| Botão Finalizar      | Encerra a corrida e salva os dados localmente  |

**Fluxos:**
- Pausar → Exibe botões "Retomar" e "Finalizar"
- Finalizar → Salva corrida localmente (mockado) → Exibe **Resumo da Corrida**
- Território conquistado → Animação de conquista

**Dados:** GPS real + cálculos locais. Dados salvos via MockRunService.

---

### 7. [x] Tela de Resumo da Corrida

**Rota:** `/run/summary`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Mapa com trajeto     | Visualização do percurso completo              |
| Métricas finais      | Distância, duração, calorias, pace             |
| Território ganho     | Área conquistada (se houver, calculada localmente) |
| Botão "Compartilhar" | Compartilha o resultado                        |
| Botão "Voltar"       | Retorna para **Home**                          |

**Fluxos:**
- "Compartilhar" → Simula o compartilhamento (ou abre janela nativa no device) com a imagem do trajeto e métricas
- "Voltar" → Limpa a stack de navegação e redireciona para a **Home**

**Dados:** Dados da corrida recém-finalizada (local) providos pelo `MockRunService`.

---

### 8. [x] Tela Community (Ranking / Leaderboard)

**Rota:** `/community`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Top 3 Destaque       | Avatares grandes dos 3 primeiros colocados     |
| Lista de Ranking     | Lista ordenada com avatar, nome, território, posição |
| Filtros              | Alternar entre: Território, Distância, Conquistas |

**Dados:** MockRankingService fornece lista de corredores fictícios.

---

### 9. [x] Tela Activity (Histórico)

**Rota:** `/activity`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Lista de corridas    | Histórico de corridas com data, distância, duração |
| Card de corrida      | Ao tocar → Exibe **Resumo da Corrida**        |
| Filtros de período   | Semana, Mês, Ano, Todos                        |

**Dados:** MockRunService retorna lista de corridas mockadas + corridas do usuário.

---

### 10. [x] Tela Progress (Progresso)

**Rota:** `/progress`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Gráfico semanal      | Distância percorrida por dia (dados mockados)  |
| Métricas totais      | Km total, Corridas totais, Territórios totais  |
| Nível do corredor    | Barra de progresso para o próximo nível        |
| Conquistas/Badges    | Medalhas e conquistas desbloqueadas            |

**Dados:** Calculados localmente a partir dos dados de MockRunService.

---

### 11. [x] Tela Profile (Perfil)

**Rota:** `/profile`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Avatar grande        | Foto/avatar do corredor (editável localmente)  |
| Nome do corredor     | Nome de exibição                               |
| Estatísticas         | Total de corridas, distância, territórios (mockados) |
| Botão "Editar Perfil" | Permite editar nome e avatar (salvo localmente) |
| Botão "Logout"       | Signout do Supabase → Volta para **Login**      |
| Configurações        | Preferências do app                            |

**Dados:** AuthService fornece dados do usuário autenticado.

---

## ⬇️ Bottom Navigation

| Aba          | Ícone     | Destino        |
|-------------|----------|----------------|
| Home         | 🏠       | `/home`         |
| Community    | 👥       | `/community`    |
| Activity     | 🏃       | `/activity`     |
| Progress     | 📊       | `/progress`     |
| Profile      | 👤       | `/profile`      |

---

## 🚀 Etapas de Desenvolvimentos (Roadmap)

Esta seção detalha os próximos passos para levar o Corrida Territorial de um MVP frontend para um produto completo e escalável.

### 🗺️ Telas e Componentes em Falta

Abaixo estão as interfaces e elementos visuais identificados como necessários para a versão completa:

| Categoria | Item | Descrição |
|-----------|------|-----------|
| **Telas** | [x] Central de Notificações | Lista de conquistas, novos desafios e interações sociais. |
| **Telas** | [x] Detalhes do Território | Informações sobre quem domina, histórico de disputas e área. |
| **Telas** | Amizades & Perfil de Terceiros | Buscar amigos, ver perfil de outros corredores e rankings comparativos. |
| **Telas** | [x] Detalhes de Conquistas | Galeria completa de medalhas com requisitos para desbloqueio. |
| **Telas** | Configurações Avançadas | Voz da corrida (feedback áudio), unidades (km/mi), privacidade. |
| **Componentes**| Design System (Buttons) | Botões padronizados (Primary, Secondary, Ghost, Disabled). |
| **Componentes**| Design System (Cards) | Cards unificados para Corridas, Territórios e Usuários. |
| **Componentes**| Feedbacks Visuais | Shimmer loading (esqueleto), Empty States e Diálogos de Sucesso. |
| **Componentes**| Custom Map UI | Filtros de mapa (exibir só meus, áreas de guerra) e ícones customizados. |

---

### 🛤️ Jornada de Evolução

---

### 🛤️ Jornada de Evolução (Foco em Frontend)

Como o projeto está focado 100% no **frontend com dados mockados**, as etapas seguem a evolução da UI, UX e lógica de cliente:

#### Etapa 1: Design System & Padronização UI
- [x] **Biblioteca de Widgets**: Criar pasta `lib/widgets/common/` com botões, cards e inputs padronizados.
- [x] **Theming**: Configurar `ThemeData` completo (Colors, TextStyles) para evitar estilos "hardcoded".
- [x] **Acessibilidade**: Revisar contrastes e tamanhos de fonte em todas as telas.
- [x] **Feedback Visual**: Implementar Shimmer Loaders reais para simular o carregamento de dados dos Mock Services.

#### Etapa 2: Lógica Avançada de Corrida (Client-Side)
- [ ] **Engine de GPS**: Refinar a captura de coordenadas para filtrar ruídos do sensor (geolocalização).
- [ ] **Feedback Sonoro**: Implementar player de som para avisos de "KM atingido" ou "Corrida Iniciada" (ativos locais).
- [ ] **Auto-Pause Mobile**: Implementar lógica de detecção de velocidade para pausar o cronômetro localmente.
- [ ] **Sobreposição de Mapa**: Melhorar a renderização do trajeto (Polyline) e marcadores customizados.

#### Etapa 3: Interface de Gamificação (Telas Faltantes)
- [x] **Galeria de Conquistas**: Implementar a tela detalhada de medalhas (badges) com estados de "Bloqueado/Desbloqueado".
- [x] **Central de Notificações**: UI para simular recebimento de alertas de sistema e conquistas.
- [x] **Detalhes de Território**: Criar o BottomSheet ou Tela que exibe informações sobre uma área clicada no mapa.

#### Etapa 4: Expansão Social (UI & Mocks)
- [ ] **Feed de Atividades**: Criar a lista de atividades global/amigos usando dados de `MockRunService`.
- [ ] **Busca de Usuários**: Implementar interface de busca e perfis de terceiros (com dados mockados).
- [ ] **Gerador de Compartilhamento**: Criar a lógica de capturar a tela (screenshot) do mapa e métricas para compartilhar nas redes.

#### Etapa 5: Lógica de Negócio no Frontend
- [ ] **Providers Robustos**: Refinar os `StateProviders` (Riverpod) para gerenciar estados complexos de filtragem no ranking e histórico.
- [ ] **Cálculos Locais**: Implementar lógica de frontend para calcular estimativa de calorias e pace médio em tempo real.
- [ ] **Persistência Local (Cache)**: Usar `shared_preferences` para salvar as configurações do usuário e o estado do onboarding localmente.

#### Etapa 6: Polish & Experiência do Usuário (UX)
- [ ] **Animações Lottie**: Adicionar animações suaves para vitórias de território e conquistas de badges.
- [ ] **Empty States**: Criar ilustrações e mensagens para quando não houver histórico ou amigos.
- [ ] **Transições de Rota**: Padronizar as transições do `GoRouter` (fade, slide) para uma sensação de app premium.

#### Etapa 7: Validação & Build de Demonstração
- [ ] **Mock Stress Test**: Garantir que o app se comporta bem com grandes volumes de dados mockados (ex: ranking com 100 nomes).
- [ ] **Performance Profiling**: Otimizar o uso de memória em telas com muitos polígonos no Google Maps.
- [ ] **Geração de APK/IPA**: Preparar a build para testes reais de campo (usando o app mockado na rua).



