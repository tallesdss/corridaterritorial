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

---

## Investigação: Por que o Mapa Mapbox não está aparecendo?

Após análise do código-fonte e da estrutura do projeto, foram identificados os seguintes motivos para a ausência do mapa real:

### 1. Implementação Visual não Concluída (UI Mocks)
Embora o planejamento (`migracaoparabackend.md`) indique a Fase 3 como concluída, os componentes de interface ainda utilizam placeholders.
- **`RunningScreen`:** Utiliza um `Container` fixo com `Icon(Icons.map)` e o texto "Mock de Mapa em Tempo Real".
- **`RunSummaryScreen`:** Utiliza um layout similar de placeholder para o trajeto da corrida.

### 2. Ausência de Inicialização do SDK
O SDK do Mapbox exige a definição do Token de Acesso antes da renderização.
- Não foi encontrada a chamada `MapboxOptions.setAccessToken` no `main.dart` ou em controllers de inicialização.

### 3. Falta de Permissões Nativa
O arquivo `android/app/src/main/AndroidManifest.xml` não possui as permissões necessárias de GPS (`ACCESS_FINE_LOCATION` e `ACCESS_COARSE_LOCATION`), o que impede o mapa de carregar a localização do usuário mesmo que o widget fosse instanciado.

### 4. Configuração Gradle Pendente
Embora as chaves existam no `.env` e `local.properties`, o plugin `mapbox_maps_flutter` precisa ser corretamente instanciado no código Dart para substituir os `Container` mocks atuais.

**Conclusão:** O mapa não aparece simplesmente porque **ainda não foi injetado nos widgets de tela**. O projeto está preparado em nível de dependências e chaves, mas a "troca" do mock pelo `MapWidget` real ainda não foi executada na camada de visualização.

---

## Ações Realizadas para Correção (13/03/2026)

Para resolver a ausência do mapa e integrar o SDK real, foram executadas as seguintes correções:

### 1. Configuração de Permissões Nativas
- Adicionadas as permissões de localização no `AndroidManifest.xml`:
    - `ACCESS_FINE_LOCATION`
    - `ACCESS_COARSE_LOCATION`
    - `INTERNET`

### 2. Inicialização do SDK Mapbox
- Atualizado o arquivo `lib/main.dart` para realizar a importação do Mapbox e definir o token de acesso globalmente através de `MapboxOptions.setAccessToken` usando a chave `MAPBOX_PUBLIC_TOKEN` do arquivo `.env`.

### 3. Substituição de Mocks por Widgets Reais
- **`RunningScreen`:** Substituído o `Container` de placeholder pelo widget funcional `MapWidget`. Configurado com o estilo `DARK` e posição inicial em São Paulo.
- **`RunSummaryScreen`:** Substituído o ícone estático pelo widget `MapWidget` para exibição do trajeto da corrida no resumo.

### 5. Correção de Tipagem (Bug Fix)
- Corrigida a passagem de parâmetros para o `CameraOptions`. Inicialmente estava sendo passado um `Map` via `.toJson()`, mas o SDK `mapbox_maps_flutter` v2+ exige o objeto `Point` diretamente no campo `center`.

### 4. Sincronização de Documentação
- Atualizado o status implícito do projeto para refletir que a infraestrutura de visualização de mapa agora está conectada ao SDK real, permitindo iniciar o desenvolvimento das camadas de territórios e trajetos sobre o mapa vivo.
