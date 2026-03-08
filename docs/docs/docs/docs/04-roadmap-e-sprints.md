# 🗺️ 04 — Roadmap e Sprints

## 🎯 Função deste Documento

Este documento organiza o **planejamento de desenvolvimento** do Corrida Territorial em sprints, definindo **o que construir**, **em qual ordem** e **com qual prioridade**. É o cronograma de execução do projeto.

**Use este documento para:**
- Saber o que deve ser implementado em cada sprint
- Priorizar tarefas quando houver dúvida sobre o que fazer em seguida
- Acompanhar o progresso geral do projeto
- Planejar a alocação de tempo e esforço
- Identificar dependências entre tarefas

> ⚠️ **100% Frontend:** Todas as sprints são exclusivamente frontend. Dados são fornecidos por **mock services/data** que poderão ser substituídos por backend real no futuro.

---

## 📊 Visão Geral das Sprints

| Sprint | Tema                           | Duração  | Status      |
|--------|--------------------------------|----------|-------------|
| 1      | Fundação e Autenticação        | 2 semanas | � Concluída  |
| 2      | Corrida e Mapa                 | 2 semanas | 🟡 Em progresso |
| 3      | Territórios e Ranking          | 2 semanas | ⚪ Pendente |
| 4      | Perfil, Histórico e Progresso  | 2 semanas | ⚪ Pendente |
| 5      | Desafios, Polish e Lançamento  | 2 semanas | ⚪ Pendente |

---

## 🏃 Sprint 1 — Fundação e Autenticação

**Objetivo:** Ter o projeto configurado, o Design System implementado, e o fluxo de autenticação completo funcionando com dados mockados.

### Tarefas

1. [x] Configurar projeto Flutter com dependências (Riverpod, GoRouter, Google Fonts)
2. [x] Criar estrutura de pastas (models, providers, services, screens, widgets, theme, routes, mocks)
3. [x] Implementar o Design System no código (cores, tipografia, tema) conforme `designsystem.md`
4. [x] Criar modelos de dados (`UserModel`) com dados mockados
5. [x] Implementar `MockAuthService` (signUp, signIn, signOut, resetPassword simulados)
6. [x] Implementar `AuthProvider` com Riverpod (gerenciamento de estado de autenticação)
7. [x] Implementar tela de **Onboarding** com Design System
8. [x] Implementar tela de **Login** com validação local (MockAuthService)
9. [x] Implementar tela de **Cadastro** com validação de formulário
10. [x] Implementar tela de **Recuperar Senha** com simulação de envio
11. [x] Configurar rotas com GoRouter (protegidas e públicas, redirect baseado em AuthProvider)
12. [x] Testar fluxo completo: cadastro → login → home → logout (tudo mockado)

---

## 🏃 Sprint 2 — Corrida e Mapa

**Objetivo:** O corredor consegue iniciar uma corrida, ver sua posição no mapa em tempo real e visualizar métricas durante a corrida.

### Tarefas

1. [ ] Integrar Google Maps Flutter
2. [ ] Implementar serviço de geolocalização (GeoService) com GPS real
3. [ ] Criar tela de **Corrida** com mapa fullscreen e Design System
4. [ ] Implementar rastreamento de posição em tempo real
5. [ ] Desenhar trajeto no mapa durante a corrida
6. [ ] Implementar overlay de métricas (distância, calorias, pace, duração) — cálculo local
7. [ ] Implementar funcionalidade de pausar/retomar corrida
8. [ ] Implementar funcionalidade de finalizar corrida
9. [ ] Criar modelo `RunModel` e dados mockados de corridas anteriores
10. [ ] Implementar `MockRunService` (salvar e listar corridas localmente)
11. [ ] Implementar tela de **Resumo da Corrida** com dados locais
12. [ ] Implementar tela **Home** (dashboard) com cards de progresso (dados mockados)

---

## 🏃 Sprint 3 — Territórios e Ranking

**Objetivo:** As corridas geram territórios no mapa (cálculo local) e é possível visualizar o ranking com dados mockados.

### Tarefas

1. [ ] Criar modelo `TerritoryModel` com dados mockados de territórios
2. [ ] Implementar lógica de cálculo de território a partir do trajeto da corrida (algoritmo local)
3. [ ] Implementar `MockTerritoryService` (conquista e listagem de territórios locais)
4. [ ] Exibir territórios conquistados no mapa (polígonos coloridos)
5. [ ] Implementar lógica de disputa/tomada de território (simulada localmente)
6. [ ] Criar modelo `RankerModel` com dados mockados de corredores fictícios
7. [ ] Implementar `MockRankingService` (ranking calculado localmente)
8. [ ] Implementar tela **Community** (Ranking/Leaderboard) com dados mockados
9. [ ] Exibir Top 3 com destaque visual
10. [ ] Implementar filtros de ranking (Território, Distância, Conquistas)
11. [ ] Animação de "Território Conquistado"

---

## 🏃 Sprint 4 — Perfil, Histórico e Progresso

**Objetivo:** O corredor pode ver seu perfil, histórico de corridas e acompanhar seu progresso (tudo com dados mockados).

### Tarefas

1. [ ] Implementar tela **Profile** com avatar e estatísticas (dados mockados)
2. [ ] Implementar edição de perfil (nome, avatar) — salvo localmente
3. [ ] Implementar seleção de avatar local (galeria de avatares ou image picker local)
4. [ ] Implementar tela **Activity** (Histórico de corridas com dados mockados)
5. [ ] Implementar filtros de período (Semana, Mês, Ano)
6. [ ] Implementar tela **Progress** com gráficos (dados calculados localmente)
7. [ ] Implementar sistema de **nível do corredor** (lógica local)
8. [ ] Implementar sistema de **badges/conquistas** (verificação local contra dados mockados)
9. [ ] Animações de "Novo Recorde" e "Level Up"

---

## 🏃 Sprint 5 — Desafios, Polish e Lançamento

**Objetivo:** Adicionar funcionalidades de engajamento com dados mockados, polir a experiência e preparar para lançamento.

### Tarefas

1. [ ] Implementar sistema de **desafios** periódicos (dados mockados)
2. [ ] Implementar **eventos** da comunidade (dados mockados)
3. [ ] Botão de **compartilhar** resultados de corridas (share nativo)
4. [ ] Revisar e polir todas as telas (animações, transições, feedback visual)
5. [ ] Testes completos em dispositivo real (Android / iOS)
6. [ ] Otimização de performance (especialmente mapa e GPS)
7. [ ] Corrigir bugs conhecidos (ver `05-testes-e-bugs.md`)
8. [ ] Preparar documentação para futura integração com backend
9. [ ] Configurar build de produção
10. [ ] Preparar para publicação nas lojas (Play Store / App Store)

---

## 📌 Notas

- As sprints são estimativas e podem ser ajustadas conforme o andamento
- **Todos os dados são mockados** — a troca para backend real será feita em fase futura
- A arquitetura de Services + Providers facilita a substituição de mocks por serviços reais
- Consulte `01-requisitos-e-regras.md` para validar o escopo de cada tarefa
- Consulte `02-arquitetura-frontend.md` para referência técnica durante a implementação
