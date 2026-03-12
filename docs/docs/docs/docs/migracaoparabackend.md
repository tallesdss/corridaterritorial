# 🏗️ Planejamento de Implementação: Backend & Integração Real

Este documento detalha o planejamento estratégico para a migração do **Corrida Territorial** de um ambiente 100% Mockado para uma infraestrutura escalável com **Supabase** e integração real com **Mapbox API**.

---

## 🚦 Fase 0: Preparação e Infraestrutura
Configuração das ferramentas base e ambiente de nuvem.

- [x] **Configuração do Projeto Supabase:**
    - [x] Criar novo projeto no console do Supabase.
    - [x] Definir `SUPABASE_URL` e `SUPABASE_ANON_KEY` nas variáveis de ambiente (.env).
- [ ] **Configuração Mapbox:**
    - [x] Criar conta no Mapbox e gerar `Public Access Token`.
    - [x] Criar `Secret Access Token` com escopo `Downloads:Read` para configuração do SDK Android.
    - [x] Configurar `mapbox_maps_flutter` no projeto Android/iOS (incluindo permissões de download no Gradle).
    - [x] Adicionar Secret Token no arquivo `gradle.properties` global ou local.
- [x] **Dependências Flutter:**
    - [x] Adicionar `supabase_flutter` ao `pubspec.yaml`.
    - [x] Adicionar `flutter_dotenv` para gestão de segredos.
- [x] **Inicialização do SDK:**
    - [x] Configurar inicialização do Supabase no `main.dart`.

---

## 🔐 Fase 1: Autenticação Real
Substituição do `MockAuthService` pelo Supabase Auth.

- [x] **Migração de Fluxo de Auth:**
    - [x] Implementar `SupabaseAuthService` herdando da interface base.
    - [x] Login com E-mail/Senha nativo do Supabase.
    - [x] Implementar Recuperação de Senha via link de e-mail (Deep Link).
- [x] **Persistência de Sessão:**
    - [x] Garantir que o `AuthProvider` escute o stream de estado da sessão do Supabase.
- [x] **Criação de Perfis Automática:**
    - [x] Configurar Trigger no Postgres para criar uma entrada na tabela `profiles` sempre que um novo usuário for criado no Auth.


---

## 📂 Fase 2: Modelagem de Dados (Postgres)
Design do banco de dados e políticas de segurança (RLS).

- [x] **Tabela `profiles`:**
    - [x] Campos: `id` (references auth.users), `username`, `avatar_url`, `level`, `xp`, `total_distance`.
- [x] **Tabela `runs`:**
    - [x] Campos: `id`, `user_id`, `distance`, `duration`, `pace`, `calories`, `poly_path` (GeoJSON/TEXT), `created_at`.
- [x] **Tabela `territories`:**
    - [x] Campos: `id`, `owner_id`, `area_polygon` (PostGIS geometry), `conquered_at`, `status` (active/contested).
- [x] **Políticas de RLS (Row Level Security):**
    - [x] Usuários só podem editar seus próprios perfis.
    - [x] Corridas são privadas ao usuário (ou públicas para ranking).
    - [x] Territórios são leitura pública, mas escrita via Function.

---

## 🏃 Fase 3: Persistência de Corridas e Mapa
Transformar a atividade local em dados persistentes e globais.

- [ ] **Salvamento de Trajeto:**
    - [ ] Conversão da lista de `LatLng` da corrida em formato PostGIS ou GeoJSON para armazenamento duradouro.
- [ ] **Otimização de Trajeto:**
    - [ ] Implementar algoritmo RDP (Ramer-Douglas-Peucker) no frontend antes de enviar para o backend (redução de pontos).
- [ ] **Integração Real de Mapa:**
    - [ ] Substituir polylines mockadas por renderização de dados vindos do banco.
    - [ ] Implementar carregamento de territórios visíveis por "Bounding Box" (carregar apenas o que está na tela).

---

## 🌍 Fase 4: Lógica de Territórios (Edge Functions)
A inteligência do "jogo de conquista" processada no servidor para evitar trapaças.

- [ ] **Supabase Edge Function `process-conquest`:**
    - [ ] Receber o log da corrida finalizada.
    - [ ] Calcular a interseção do trajeto com territórios existentes usando PostGIS.
    - [ ] Atribuir novo território ou atualizar o domíno de um existente.
- [ ] **Webhooks e Notificações:**
    - [ ] Disparar notificação (Push) quando um usuário perder um território para outro corredor.

---

## 🏆 Fase 5: Gamificação e Ranking Real
Substituir `MockRankingService` e `MockAchievementService`.

- [ ] **Ranking Dinâmico:**
    - [ ] Criar View no Postgres para calcular o Top Corredores (Territórios, Distância, XP).
    - [ ] Implementar Real-time (Subscription) no ranking para atualizações ao vivo.
- [ ] **Sistema de Conquistas:**
    - [ ] Lógica de backend para validar se o usuário atingiu metas (ex: 'Maratonista' ao atingir 42km total).
- [ ] **Upload de Media:**
    - [ ] Configurar Supabase Storage para fotos de perfil reais (substituir avatares locais).

---

## 🧹 Fase 6: Limpeza e Remoção de Mocks
O passo final para a produção.

- [ ] **Remoção de Arquivos:**
    - [ ] Deletar pasta `lib/services/mocks`.
    - [ ] Remover instâncias de `MockProvider` e trocar por `SupabaseProvider`.
- [ ] **Validação de Performance:**
    - [ ] Testar latência de rede e tempos de resposta do banco.
- [ ] **Finalização de UI:**
    - [ ] Adicionar Shimmer reais nos estados de `AsyncValue` do Riverpod enquanto aguarda o Supabase.

---

## 📅 Cronograma Sugerido

| Sprint | Foco | Complexidade |
| :--- | :--- | :--- |
| **S1** | Infra, Auth e Perfil Base | Baixa |
| **S2** | Modelagem SQL e Persistência de Corridas | Média |
| **S3** | PostGIS & Lógica de Territórios (Backend) | Alta |
| **S4** | Ranking Real-time e Social | Média |
| **S5** | Media Storage e Remoção de Mocks | Baixa |
