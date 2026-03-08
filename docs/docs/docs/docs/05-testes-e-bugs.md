# 🧪 05 — Testes e Bugs

## 🎯 Função deste Documento

Este documento serve como **central de qualidade** do Corrida Territorial. Aqui ficam os **checklists de testes** que devem ser executados antes de cada release, a **lista de bugs conhecidos** que precisam ser corrigidos, e o **registro de problemas resolvidos** para referência futura.

**Use este documento para:**
- Executar testes manuais antes de lançar uma versão
- Registrar bugs encontrados durante desenvolvimento ou testes
- Consultar bugs conhecidos antes de reportar um novo
- Acompanhar quais correções já foram aplicadas
- Garantir que nenhum cenário crítico seja esquecido nos testes

---

## ✅ Checklists de Testes

### 🔐 Autenticação

- [ ] Login com e-mail e senha válidos → deve redirecionar para Home
- [ ] Login com senha incorreta → deve exibir mensagem de erro
- [ ] Login com e-mail não cadastrado → deve exibir mensagem de erro
- [ ] Cadastro com dados válidos → deve criar conta e redirecionar para Home
- [ ] Cadastro com e-mail já existente → deve exibir mensagem de erro
- [ ] Cadastro com senhas que não coincidem → deve bloquear o envio
- [ ] Recuperação de senha → deve enviar e-mail com link válido
- [ ] Logout → deve encerrar sessão e voltar para Login
- [ ] Sessão persistente → ao fechar e reabrir o app, continua logado
- [ ] Acesso a rotas protegidas sem login → deve redirecionar para Login

### 🏃 Corrida

- [ ] Iniciar corrida → mapa abre com posição do usuário
- [ ] GPS rastreia a posição corretamente em tempo real
- [ ] Trajeto é desenhado no mapa conforme o usuário se move
- [ ] Métricas atualizam em tempo real (distância, pace, calorias, duração)
- [ ] Pausar corrida → rastreamento e métricas param
- [ ] Retomar corrida → rastreamento e métricas continuam de onde pararam
- [ ] Finalizar corrida → dados são salvos corretamente no banco
- [ ] Resumo da corrida exibe dados corretos

### 🗺️ Territórios

- [ ] Território é calculado corretamente a partir do trajeto
- [ ] Território aparece no mapa com cor do conquistador
- [ ] Disputa de território funciona corretamente
- [ ] Ranking é atualizado após conquista de território

### 🏆 Ranking

- [ ] Leaderboard exibe corredores ordenados corretamente
- [ ] Filtro por Território funciona
- [ ] Filtro por Distância funciona
- [ ] Filtro por Conquistas funciona
- [ ] Top 3 exibidos com destaque visual correto

### 👤 Perfil

- [ ] Perfil exibe dados corretos do usuário logado
- [ ] Edição de nome funciona e salva no banco
- [ ] Upload de avatar funciona e exibe corretamente
- [ ] Estatísticas estão corretas (total corridas, km, territórios)

### 📊 Progresso e Histórico

- [ ] Histórico de corridas exibe todas as corridas do usuário
- [ ] Filtro de período funciona (Semana, Mês, Ano)
- [ ] Gráfico semanal exibe dados corretos
- [ ] Nível do corredor atualiza corretamente
- [ ] Badges são desbloqueadas conforme critérios atingidos

### 📱 Geral / UI

- [ ] Todas as telas carregam sem erro
- [ ] Navegação entre abas funciona corretamente
- [ ] App funciona em modo retrato
- [ ] Fontes e cores estão de acordo com o Design System
- [ ] Animações executam sem travamentos
- [ ] App não trava ao perder conexão com internet
- [ ] Loading states exibidos durante carregamentos

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