# 🗺️ 04 — Roadmap e Sprints

## 🎯 Função deste Documento

Este documento organiza o **planejamento de desenvolvimento** do Corrida Territorial em sprints, definindo **o que construir**, **em qual ordem** e **com qual prioridade**. É o cronograma de execução do projeto.

**Use este documento para:**
- Saber o que deve ser implementado em cada sprint
- Priorizar tarefas quando houver dúvida sobre o que fazer em seguida
- Acompanhar o progresso geral do projeto
- Planejar a alocação de tempo e esforço
- Identificar dependências entre tarefas

---

## 📊 Visão Geral das Sprints

| Sprint | Tema                           | Duração  | Status      |
|--------|--------------------------------|----------|-------------|
| 1      | Fundação e Autenticação        | 2 semanas | 🟡 Em progresso |
| 2      | Corrida e Mapa                 | 2 semanas | ⚪ Pendente |
| 3      | Territórios e Ranking          | 2 semanas | ⚪ Pendente |
| 4      | Perfil, Histórico e Progresso  | 2 semanas | ⚪ Pendente |
| 5      | Desafios, Polish e Lançamento  | 2 semanas | ⚪ Pendente |

---

## 🏃 Sprint 1 — Fundação e Autenticação

**Objetivo:** Ter o projeto configurado, o Design System implementado, e o fluxo de autenticação completo funcionando.

### Tarefas

- [ ] Configurar projeto Flutter com dependências (Riverpod, GoRouter, Supabase)
- [ ] Criar estrutura de pastas (models, providers, services, screens, widgets, theme, routes)
- [ ] Implementar o Design System no código (cores, tipografia, tema)
- [ ] Configurar projeto no Supabase (Auth, Database)
- [ ] Criar tabela `profiles` com RLS
- [ ] Implementar tela de **Onboarding**
- [ ] Implementar tela de **Login**
- [ ] Implementar tela de **Cadastro**
- [ ] Implementar tela de **Recuperar Senha**
- [ ] Configurar rotas com GoRouter (protegidas e públicas)
- [ ] Implementar serviço de autenticação (AuthService)
- [ ] Implementar provider de autenticação (AuthProvider)
- [ ] Testar fluxo completo: cadastro → login → home → logout

---

## 🏃 Sprint 2 — Corrida e Mapa

**Objetivo:** O corredor consegue iniciar uma corrida, ver sua posição no mapa em tempo real e visualizar métricas durante a corrida.

### Tarefas

- [ ] Integrar Google Maps Flutter
- [ ] Implementar serviço de geolocalização (GeoService)
- [ ] Criar tela de **Corrida** com mapa fullscreen
- [ ] Implementar rastreamento de posição em tempo real
- [ ] Desenhar trajeto no mapa durante a corrida
- [ ] Implementar overlay de métricas (distância, calorias, pace, duração)
- [ ] Implementar funcionalidade de pausar/retomar corrida
- [ ] Implementar funcionalidade de finalizar corrida
- [ ] Criar tabela `runs` no Supabase com RLS
- [ ] Salvar dados da corrida ao finalizar
- [ ] Implementar tela de **Resumo da Corrida**
- [ ] Implementar tela **Home** (dashboard) com card de progresso

---

## 🏃 Sprint 3 — Territórios e Ranking

**Objetivo:** As corridas geram territórios no mapa e é possível visualizar o ranking entre corredores.

### Tarefas

- [ ] Criar tabela `territories` no Supabase com RLS
- [ ] Implementar lógica de cálculo de território a partir do trajeto da corrida
- [ ] Implementar RPC `conquer_territory` no Supabase
- [ ] Exibir territórios conquistados no mapa (polígonos coloridos)
- [ ] Implementar lógica de disputa/tomada de território
- [ ] Implementar RPC `calculate_ranking` no Supabase
- [ ] Implementar tela **Community** (Ranking/Leaderboard)
- [ ] Exibir Top 3 com destaque visual
- [ ] Implementar filtros de ranking (Território, Distância, Conquistas)
- [ ] Animação de "Território Conquistado"

---

## 🏃 Sprint 4 — Perfil, Histórico e Progresso

**Objetivo:** O corredor pode ver seu perfil, histórico de corridas e acompanhar seu progresso.

### Tarefas

- [ ] Implementar tela **Profile** com avatar e estatísticas
- [ ] Implementar edição de perfil (nome, avatar)
- [ ] Implementar upload de avatar no Supabase Storage
- [ ] Implementar tela **Activity** (Histórico de corridas)
- [ ] Implementar filtros de período (Semana, Mês, Ano)
- [ ] Implementar tela **Progress** com gráficos
- [ ] Implementar sistema de **nível do corredor**
- [ ] Implementar sistema de **badges/conquistas**
- [ ] Animações de "Novo Recorde" e "Level Up"

---

## 🏃 Sprint 5 — Desafios, Polish e Lançamento

**Objetivo:** Adicionar funcionalidades de engajamento, polir a experiência e preparar para lançamento.

### Tarefas

- [ ] Implementar sistema de **desafios** periódicos
- [ ] Implementar **eventos** da comunidade
- [ ] Botão de **compartilhar** resultados de corridas
- [ ] Revisar e polir todas as telas (animações, transições, feedback visual)
- [ ] Testes completos em dispositivo real (Android / iOS)
- [ ] Otimização de performance (especialmente mapa e GPS)
- [ ] Corrigir bugs conhecidos (ver `05-testes-e-bugs.md`)
- [ ] Configurar build de produção
- [ ] Deploy no Firebase Hosting (versão web, se aplicável)
- [ ] Preparar para publicação nas lojas (Play Store / App Store)

---

## 📌 Notas

- As sprints são estimativas e podem ser ajustadas conforme o andamento
- Tarefas podem ser detalhadas em sub-tarefas no Jira se necessário
- Consulte `01-requisitos-e-regras.md` para validar o escopo de cada tarefa
- Consulte `02-arquitetura-e-backend.md` para referência técnica durante a implementação
