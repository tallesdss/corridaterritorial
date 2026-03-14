# Simulação de Uso do Aplicativo

Para facilitar o desenvolvimento e testes das funcionalidades de caminhada, territórios e conquistas, foram gerados dados fictícios para o usuário de teste principal.

## Usuário de Teste
- **E-mail:** dartdynamicsprogramadores@gmail.com
- **ID:** `a950e4e8-84c7-447d-9cc1-3ccdbc3f3ba4`

## Dados Simulados em 13/03/2026

### 1. Perfil do Usuário
- **Nível:** 3
- **XP:** 1250
- **Distância Total:** 10.5 km

### 2. Atividades (Runs)
Foram inseridas 3 atividades recentes:
- **Atividade 1:** 5.2 km | 30 min | Pace: 5.77 min/km
- **Atividade 2:** 3.5 km | 20 min | Pace: 5.71 min/km
- **Atividade 3:** 1.8 km | 10 min | Pace: 5.56 min/km
*As rotas foram geradas como `LINESTRING` geográficos na região de São Paulo/Brasil.*

### 3. Territórios Conquistados
Foram gerados **5 territórios** (polígonos de aproximadamente 100m x 100m) atribuídos ao usuário, simulando a exploração de uma área urbana.

### 4. Conquistas (Achievements)
- **Desbloqueada:** `Primeira Passada` (ID: `92fbac91-7e99-4cb7-a359-d511935e641c`)
- **Progresso:** Registrado no histórico do usuário.

### 5. Notificações
Foram adicionadas 3 notificações de exemplo:
- Boas-vindas ao sistema.
- Confirmação de novo território conquistado.
- Alerta de conquista desbloqueada.

---

## Como Replicar a Simulação
Caso precise limpar os dados ou simular para outro usuário, utilize o script SQL abaixo no Console do Supabase:

```sql
-- Exemplo de inserção de corrida
INSERT INTO public.runs (user_id, distance, duration, pace, calories, path_geom)
VALUES ('USER_ID', 5.0, 1500, 5.0, 400, ST_GeomFromText('LINESTRING(...)', 4326));
```
