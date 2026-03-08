# 📋 01 — Requisitos e Regras de Negócio

## 🎯 Função deste Documento

Este documento define **todas as regras de negócio do Corrida Territorial**, sem entrar em detalhes de código ou tecnologia. Aqui descrevemos **O QUE** o sistema deve fazer e **POR QUÊ**, servindo como a fonte de verdade para o escopo e as funcionalidades do projeto.

**Use este documento para:**
- Entender o propósito de cada funcionalidade antes de implementá-la
- Validar se uma feature está dentro do escopo do projeto
- Alinhar expectativas sobre o comportamento esperado do sistema
- Servir de referência durante code reviews e testes

---

## 📌 Visão Geral do Produto

O **Corrida Territorial** é um aplicativo mobile que transforma corridas no mundo real em conquistas de territórios virtuais no mapa. Os usuários competem entre si para dominar áreas geográficas, criando um loop de motivação que combina **corrida + território + competição**.

> ⚠️ **Nota sobre dados:** Nesta fase, todo o projeto é **100% frontend**. Todos os dados (usuários, corridas, territórios, ranking) são fornecidos por **dados mockados** que simulam o comportamento real. Esses mockups poderão ser substituídos por dados de um backend (ex: Supabase) no futuro.

---

## 🔐 Regras de Autenticação

- O usuário deve poder se cadastrar com e-mail e senha (simulado com mockup)
- O usuário deve poder fazer login com credenciais válidas (validação local com dados mockados)
- O sistema deve oferecer **recuperação de senha** via e-mail (UI funcional, envio simulado)
- O usuário deve permanecer logado até fazer logout manualmente (estado gerenciado localmente)
- Dados pessoais devem ser protegidos e acessíveis apenas pelo próprio usuário

---

## 🏃 Regras de Corrida

- O sistema deve rastrear a posição do usuário em tempo real via GPS durante uma corrida
- A corrida deve registrar: **distância percorrida**, **duração**, **calorias estimadas** e **pace médio**
- O usuário pode **pausar** e **retomar** uma corrida em andamento
- O usuário pode **finalizar** uma corrida a qualquer momento
- Ao finalizar, os dados devem ser salvos localmente (mockup — substituível por backend no futuro)
- O trajeto da corrida deve ser desenhado no mapa em tempo real

---

## 🗺️ Regras de Território

- Ao completar um percurso, o corredor **conquista o território** correspondente à área coberta pela corrida
- Territórios são exibidos no mapa com identificação visual do conquistador
- Se outro corredor percorrer a mesma área com desempenho superior, ele pode **tomar o território**
- O tamanho do território conquistado é proporcional à área do percurso realizado
- Territórios são carregados a partir de **dados mockados** (substituíveis por backend no futuro)

---

## 🏆 Regras de Ranking

- O sistema deve exibir um **ranking/leaderboard** de corredores (dados mockados)
- O ranking pode ser ordenado por:
  - Área total de território conquistado
  - Distância total percorrida
  - Número total de conquistas
- O ranking exibe dados mockados que simulam múltiplos corredores

---

## 👤 Regras de Perfil

- Cada corredor deve ter um perfil com: **nome**, **avatar** e **estatísticas** (mockup local)
- As estatísticas devem incluir: total de corridas, distância total, territórios conquistados
- O corredor pode visualizar seu próprio histórico de corridas (dados mockados)

---

## 🎯 Regras de Desafios e Eventos

- O sistema pode apresentar desafios periódicos aos corredores (ex: "Corra 10km esta semana") — dados mockados
- Eventos especiais podem ser criados para engajar a comunidade — dados mockados
- A conclusão de desafios pode gerar recompensas visuais ou pontuação extra

---

## 📦 Estratégia de Dados Mockados

Todos os dados do app são fornecidos por **mock providers/services** locais:

| Dado              | Fonte Mockada                          | Substituição Futura        |
|-------------------|----------------------------------------|----------------------------|
| Usuário/Auth      | Dados fixos em memória                 | Supabase Auth              |
| Perfil            | Objeto local com nome, avatar, stats   | Tabela `profiles`          |
| Corridas          | Lista de corridas simuladas            | Tabela `runs`              |
| Territórios       | Polígonos pré-definidos no mapa        | Tabela `territories`       |
| Ranking           | Lista de corredores fictícios          | RPC `calculate_ranking`    |
| Desafios/Eventos  | Lista estática de desafios             | Tabela futura              |

> 💡 A arquitetura de **Services + Providers (Riverpod)** facilita a troca de dados mockados por dados reais sem alterar a UI.

---

## 🚫 Fora do Escopo (v1)

- Sistema de pagamentos ou monetização
- Chat entre usuários
- Integração com wearables (smartwatches)
- Modo offline completo
- **Backend real** (Supabase, Firebase, etc.) — será integrado em fase futura
