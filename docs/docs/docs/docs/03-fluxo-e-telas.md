# 🖥️ 03 — Fluxo de Navegação e Telas

## 🎯 Função deste Documento

Este documento descreve a **jornada do usuário** dentro do aplicativo e detalha **cada tela** com seus componentes visuais, ações possíveis e para onde cada interação leva. É o mapa de navegação completo do Corrida Territorial.

**Use este documento para:**
- Entender o fluxo completo de navegação do app
- Saber quais componentes cada tela deve conter antes de implementá-la
- Validar se a experiência do usuário está coerente
- Planejar a implementação de novas telas e transições
- Servir como referência para designers e desenvolvedores

> ⚠️ **Dados Mockados:** Todas as telas consomem dados de **mock services** locais. Nenhuma tela depende de backend real. Os mockups poderão ser substituídos por dados reais no futuro.

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
              │  (estado local mockado) │
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
| Botão "Entrar"     | Valida com MockAuthService → redireciona para **Home** |
| Link "Esqueci minha senha" | Leva para **Recuperar Senha**          |
| Link "Criar conta" | Leva para **Cadastro**                        |

**Fluxos:**
- Login com sucesso (mockado) → **Home**
- Senha incorreta → Exibe mensagem de erro (validação local)
- "Esqueci minha senha" → **Recuperar Senha**

**Dados:** MockAuthService valida credenciais contra dados mockados locais.

---

### 3. [x] Tela de Cadastro

**Rota:** `/register`

| Componente         | Descrição                                      |
|-------------------|------------------------------------------------|
| Campo Nome         | Nome de exibição do corredor                   |
| Campo E-mail       | E-mail para cadastro                           |
| Campo Senha        | Senha com requisitos mínimos                   |
| Campo Confirmar Senha | Confirmação de senha                        |
| Botão "Cadastrar"  | Cria conta local (mockada) → redireciona para **Home** |
| Link "Já tenho conta" | Volta para **Login**                        |

**Dados:** MockAuthService cria usuário localmente.

---

### 4. [x] Tela de Recuperar Senha

**Rota:** `/forgot-password`

| Componente         | Descrição                                      |
|-------------------|------------------------------------------------|
| Campo E-mail       | E-mail cadastrado                              |
| Botão "Enviar"     | Simula envio de e-mail (delay mockado)         |
| Mensagem de sucesso | Confirma que o "e-mail foi enviado" (mockado) |
| Link "Voltar"      | Retorna para **Login**                         |

**Dados:** MockAuthService simula envio com delay e retorna sucesso.

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

### 10. [ ] Tela Progress (Progresso)

**Rota:** `/progress`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Gráfico semanal      | Distância percorrida por dia (dados mockados)  |
| Métricas totais      | Km total, Corridas totais, Territórios totais  |
| Nível do corredor    | Barra de progresso para o próximo nível        |
| Conquistas/Badges    | Medalhas e conquistas desbloqueadas            |

**Dados:** Calculados localmente a partir dos dados de MockRunService.

---

### 11. [ ] Tela Profile (Perfil)

**Rota:** `/profile`

| Componente           | Descrição                                     |
|---------------------|------------------------------------------------|
| Avatar grande        | Foto/avatar do corredor (editável localmente)  |
| Nome do corredor     | Nome de exibição                               |
| Estatísticas         | Total de corridas, distância, territórios (mockados) |
| Botão "Editar Perfil" | Permite editar nome e avatar (salvo localmente) |
| Botão "Logout"       | Limpa estado local → Volta para **Login**      |
| Configurações        | Preferências do app                            |

**Dados:** MockAuthService fornece dados do usuário mockado.

---

## ⬇️ Bottom Navigation

| Aba          | Ícone     | Destino        |
|-------------|----------|----------------|
| Home         | 🏠       | `/home`         |
| Community    | 👥       | `/community`    |
| Activity     | 🏃       | `/activity`     |
| Progress     | 📊       | `/progress`     |
| Profile      | 👤       | `/profile`      |