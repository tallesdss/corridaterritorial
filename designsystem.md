# 🎨 Running Territory App — Design System

## 🎯 Objetivo

Definir padrões visuais e componentes para o aplicativo de corrida e conquista de territórios. O design prioriza métricas claras, foco na atividade física e elementos de gamificação.

---

# 🧠 Princípios de Design

• **Foco na atividade** → métricas e percurso são o elemento central
• **Alto contraste** → fundo escuro para melhor leitura ao ar livre
• **Feedback visual forte** → ações importantes com cores vibrantes
• **Gamificação** → reforçar conquistas e progresso do usuário

---

# 🎨 Paleta de Cores

## Primary

Cor principal usada em ações e destaques.

Primary: #C8FF2F
Primary Dark: #A6D81F
Primary Light: #E2FF7A

## Background

Background Dark: #0F1115
Background Medium: #1A1D23
Background Card: #23262D

## Text

Text Primary: #FFFFFF
Text Secondary: #9EA3AE
Text Muted: #6B7280

## Status

Success: #22C55E
Warning: #FACC15
Error: #EF4444
Info: #3B82F6

---

# 🔤 Tipografia

Fonte recomendada

Inter
ou
SF Pro

## Heading

H1
Size: 34
Weight: Bold

H2
Size: 24
Weight: SemiBold

H3
Size: 20
Weight: Medium

## Body

Body Large
Size: 16
Weight: Regular

Body Medium
Size: 14
Weight: Regular

Caption
Size: 12
Weight: Regular

## Métricas de corrida

Metric Large
Size: 32
Weight: Bold

Metric Medium
Size: 20
Weight: SemiBold

---

# 📦 Sistema de Espaçamento

Spacing baseado em múltiplos de 4.

4px
8px
12px
16px
24px
32px
40px
48px

Uso comum

Card padding → 16
Section spacing → 24
Screen margin → 20

---

# 🔘 Botões

## Primary Button

Usado para ações principais.

Background: Primary
Text: Dark
Height: 56px
Border Radius: 28px
Font: 16 SemiBold

Exemplos

Start Journey
Start Run
Conquer Territory

## Secondary Button

Background: Transparent
Border: 1px solid #2B2F36
Text: White
Radius: 20

---

# 📦 Cards

Usados no dashboard.

Background: #23262D
Border Radius: 20
Padding: 16
Shadow: leve

Estrutura

Card
├ Title
├ Subtitle
└ Metric

---

# 📊 Componentes de Métricas

Utilizados durante corrida.

Distance
Calories
Pace
Time
Heart Rate

Layout

Metric Value
Metric Label

Exemplo

7.2 km
Distance

---

# 🗺️ Map Screen Layout

Componentes

Map View
Running Path
User Position Marker
Metrics Overlay
Control Buttons

Overlay de métricas

Distance
Calories
Pace
Duration

---

# 🧭 Navegação

Barra inferior com 5 itens.

Home
Community
Activity
Progress
Profile

Configuração

Background: Dark
Active Icon: Primary
Inactive Icon: Gray

---

# 🧍 Sistema de Avatar

Cada usuário possui um avatar animado.

Usado para

Mapa
Ranking
Perfil
Conquista de território

Avatar pode ter animação idle.

---

# ✨ Sistema de Animações

Recomendado usar Lottie.

Eventos animados

Territory Conquered
New Record
Run Completed
Level Up

---

# 📱 Telas Principais

## Onboarding

Componentes

Hero image
Headline
Call to Action Button
Login link

---

## Dashboard

Componentes

Greeting
Progress Card
Challenges
Events
Bottom Navigation

---

## Running Screen

Componentes

Map
Metrics
Route line
Start button
Pause button
Finish button

---

## Ranking Screen

Componentes

Top runners
Avatar
Territory size
Position

Ranking baseado em

Área total dominada
Número de territórios
Distância corrida

---

# 📐 Grid System

Mobile Grid: 4 columns
Margin: 20
Gutter: 12

---

# 🧱 Flutter Theme Base

```dart
ThemeData(
  scaffoldBackgroundColor: Color(0xFF0F1115),
  primaryColor: Color(0xFFC8FF2F),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    bodyMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFF9EA3AE),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFC8FF2F),
      foregroundColor: Colors.black,
      shape: StadiumBorder(),
      minimumSize: Size(double.infinity, 56),
    ),
  ),
)
```

---

# 🧠 Referência de UX

Esse estilo de interface é inspirado em apps como o Nike Run Club e o Strava.

Padrões utilizados nesses apps

Tema escuro
Métricas grandes
Mapas interativos
Gamificação da corrida

---

# 🚀 Objetivo do Design

Criar uma experiência que combine

atividade física
competição
visualização territorial
gamificação

transformando corridas em uma disputa territorial no mapa.
