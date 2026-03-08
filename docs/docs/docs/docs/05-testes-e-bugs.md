# 🧪 05 — Testes e Bugs

## 🎯 Função deste Documento

Este documento serve como **central de qualidade** do Corrida Territorial. Aqui ficam os **checklists de testes** que devem ser executados antes de cada release, a **lista de bugs conhecidos** que precisam ser corrigidos, e o **registro de problemas resolvidos** para referência futura.

**Use este documento para:**
- Executar testes manuais antes de lançar uma versão
- Registrar bugs encontrados durante desenvolvimento ou testes
- Consultar bugs conhecidos antes de reportar um novo
- Acompanhar quais correções já foram aplicadas
- Garantir que nenhum cenário crítico seja esquecido nos testes

> ⚠️ **Todos os testes são frontend-only.** Validações são feitas contra dados mockados e estado local. Nenhum teste depende de backend real.

---

## ✅ Checklists de Testes

### 🔐 Autenticação (MockAuthService)

- [ ] Login com e-mail e senha válidos (mockados) → deve redirecionar para Home
- [ ] Login com senha incorreta → deve exibir mensagem de erro
- [ ] Login com e-mail não cadastrado (mockado) → deve exibir mensagem de erro
- [ ] Cadastro com dados válidos → deve criar conta local e redirecionar para Home
- [ ] Cadastro com e-mail já existente (mockado) → deve exibir mensagem de erro
- [ ] Cadastro com senhas que não coincidem → deve bloquear o envio
- [ ] Recuperação de senha → deve simular envio e exibir mensagem de sucesso
- [ ] Logout → deve limpar estado local e voltar para Login
- [ ] Sessão em memória → estado de autenticação mantido durante uso do app
- [ ] Acesso a rotas protegidas sem login → deve redirecionar para Login

### 🏃 Corrida

- [ ] Iniciar corrida → mapa abre com posição do usuário (GPS real)
- [ ] GPS rastreia a posição corretamente em tempo real
- [ ] Trajeto é desenhado no mapa conforme o usuário se move
- [ ] Métricas atualizam em tempo real (distância, pace, calorias, duração) — cálculo local
- [ ] Pausar corrida → rastreamento e métricas param
- [ ] Retomar corrida → rastreamento e métricas continuam de onde pararam
- [ ] Finalizar corrida → dados são salvos localmente (MockRunService)
- [ ] Resumo da corrida exibe dados corretos da corrida finalizada

### 🗺️ Territórios (Mockados)

- [ ] Território é calculado corretamente a partir do trajeto (algoritmo local)
- [ ] Território aparece no mapa com cor do conquistador
- [ ] Disputa de território funciona corretamente (lógica local)
- [ ] Dados de territórios mockados são exibidos corretamente no mapa

### 🏆 Ranking (Dados Mockados)

- [ ] Leaderboard exibe corredores mockados ordenados corretamente
- [ ] Filtro por Território funciona
- [ ] Filtro por Distância funciona
- [ ] Filtro por Conquistas funciona
- [ ] Top 3 exibidos com destaque visual correto

### 👤 Perfil (Dados Locais)

- [ ] Perfil exibe dados corretos do usuário mockado logado
- [ ] Edição de nome funciona e salva localmente
- [ ] Seleção de avatar funciona e exibe corretamente
- [ ] Estatísticas estão corretas (calculadas a partir dos dados mockados)

### 📊 Progresso e Histórico (Dados Mockados)

- [ ] Histórico de corridas exibe corridas mockadas + corridas do usuário
- [ ] Filtro de período funciona (Semana, Mês, Ano)
- [ ] Gráfico semanal exibe dados corretos (calculados localmente)
- [ ] Nível do corredor atualiza corretamente (lógica local)
- [ ] Badges são desbloqueadas conforme critérios atingidos (verificação local)

### 📱 Geral / UI

- [ ] Todas as telas carregam sem erro
- [ ] Navegação entre abas funciona corretamente
- [ ] App funciona em modo retrato
- [ ] Fontes e cores estão de acordo com o Design System
- [ ] Animações executam sem travamentos
- [ ] Loading states exibidos durante operações simuladas
- [ ] App funciona sem conexão com internet (exceto mapa)

---

## 🐛 Bugs Conhecidos

> Registre aqui bugs encontrados que ainda não foram corrigidos.

| # | Descrição | Tela | Severidade | Status | Data |
|---|-----------|------|-----------|--------|------|
| 1 | Exemplo: ParentDataWidget error em layout X | Login | 🟡 Média | 🔴 Aberto | 2026-03-04 |

### Severidades
- 🔴 **Crítica** — App trava ou perde dados
- 🟠 **Alta** — Funcionalidade principal não funciona
- 🟡 **Média** — Funcionalidade funciona mas com problema visual ou de UX
- 🟢 **Baixa** — Detalhe cosmético ou melhoria menor

---

## ✅ Bugs Resolvidos

> Mova bugs corrigidos para cá com a data da correção.

| # | Descrição | Tela | Correção Aplicada | Data Correção |
|---|-----------|------|-------------------|---------------|
| — | — | — | — | — |

---

## 📌 Notas

- Execute o checklist completo de testes **antes de cada merge para a branch principal**
- Bugs críticos devem ser corrigidos **antes de qualquer nova feature**
- Consulte `01-requisitos-e-regras.md` para validar o comportamento esperado
- Consulte `03-fluxo-e-telas.md` para verificar a navegação esperada
- Todos os testes validam contra **dados mockados** — testes de integração com backend serão criados no futuro