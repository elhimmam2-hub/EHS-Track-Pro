---
name: Serene Compliance
colors:
  surface: '#f6faff'
  surface-dim: '#d2dbe4'
  surface-bright: '#f6faff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#ecf5fe'
  surface-container: '#e6eff8'
  surface-container-high: '#e0e9f2'
  surface-container-highest: '#dbe4ed'
  on-surface: '#141d23'
  on-surface-variant: '#404943'
  inverse-surface: '#293138'
  inverse-on-surface: '#e9f2fb'
  outline: '#707973'
  outline-variant: '#bfc9c1'
  surface-tint: '#2c694e'
  primary: '#0f5238'
  on-primary: '#ffffff'
  primary-container: '#2d6a4f'
  on-primary-container: '#a8e7c5'
  inverse-primary: '#95d4b3'
  secondary: '#485f84'
  on-secondary: '#ffffff'
  secondary-container: '#bbd3fd'
  on-secondary-container: '#445a7f'
  tertiary: '#064c6c'
  on-tertiary: '#ffffff'
  tertiary-container: '#2b6485'
  on-tertiary-container: '#b3dfff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#b1f0ce'
  primary-fixed-dim: '#95d4b3'
  on-primary-fixed: '#002114'
  on-primary-fixed-variant: '#0e5138'
  secondary-fixed: '#d5e3ff'
  secondary-fixed-dim: '#b0c7f1'
  on-secondary-fixed: '#001b3c'
  on-secondary-fixed-variant: '#30476a'
  tertiary-fixed: '#c7e7ff'
  tertiary-fixed-dim: '#98cdf2'
  on-tertiary-fixed: '#001e2e'
  on-tertiary-fixed-variant: '#064c6b'
  background: '#f6faff'
  on-background: '#141d23'
  surface-variant: '#dbe4ed'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 34px
  headline-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  headline-sm:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 18px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.2px
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.3px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-mobile: 0.75rem
  margin: 1.25rem
  margin-mobile: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.875rem
  space-lg: 1.25rem
  space-xl: 2rem
---

## Brand & Style

This design system delivers an operational, field-ready mobile environment focused on Environmental, Health, and Safety (EHS) workflows. Designed specifically to reduce cognitive fatigue, screen glare, and visual alarmism during high-stakes compliance audits and incident reporting, the aesthetic balances functional utility with visual serenity.

### Personality & Emotional Resonance
- **Composed & Grounded:** Mitigates panic during hazard inspections through measured visual cues rather than harsh neon alarms.
- **Utilitarian & Trustworthy:** Direct, structured, and legible under varying light conditions (from direct outdoor sunlight to dimly lit industrial plants).
- **Tactile & Ergonomic:** Built with thumb-driven operational patterns, providing reassuring physical haptic and visual feedback.

### Design Movement: Modern Functional Minimal with Soft Skeuomorphic Tactility
The design synthesizes Modern Corporate clarity with soft, tactile physical metaphors. Surfaces employ subtle tonal stacking, hairline separation, and anti-glare surfaces rather than heavy borders or stark contrasts. Card surfaces and interactive inputs feel tangible, offering distinct physical press states that assure field inspectors their inputs are secured—even when working offline.

## Colors

The palette is engineered to replace eye strain and visual panic with clarity, purpose, and visual calm.

### Role Tokens & Hex Codes
- **Primary Eco-Green (`#2D6A4F`):** Deep Sage Green. Used for primary interactive actions, completed state validation, environment trackers, and bottom navigation active states.
- **Primary Light Accent (`#40916C`):** Soft Emerald. Used for hover states, active selections, and positive trends.
- **Secondary Safety Slate (`#1D3557`):** Deep Navy Slate. Conveys authority, regulatory compliance, and institutional trust. Used for primary typography, dominant app headers, and key audit markers.
- **Tertiary Accent (`#457B9D`):** Soft Slate Blue. Secondary accents, active chips, and information-tier icons.
- **Neutral Canvas (`#F8F9FA`):** Warm Off-White. Base background engineered to prevent harsh screen glare during extended outdoor mobile usage.
- **Neutral Surface / Layer (`#F1F3F5`):** Secondary container surface for grouped items and module backings.
- **Pure Surface (`#FFFFFF`):** High-priority card layers, active modal sheets, and floating bars.

### Contextual Status & Incident Roles
- **Hazard Critical / High Risk:** Terracotta Coral (`#E76F51`), paired with soft wash background (`#FDF0ED`). Avoids pure neon red to preserve calmness while retaining priority distinction.
- **Hazard Caution / Moderate Warning:** Muted Warm Amber (`#D97706`), paired with soft tint background (`#FEF7EC`).
- **Compliant / Resolved Safe:** Soft Sage (`#2D6A4F`), paired with calm background (`#EEF6F2`).
- **Offline / Sync State:** Warm Slate Slate Grey (`#5C677D`), paired with soft neutral (`#EDEFF2`).

## Typography

The type system prioritizes dual-script equilibrium across bidirectional mobile screens, standardizing on neutral geometric metrics for Latin pairings with system-level RTL font stack integration.

### Bidirectional & Multi-Script Handling
- **Latin Baseline:** Inter delivers dense optical clarity across tabular data sets, incident IDs, checklists, and operational timestamps.
- **Arabic Script Strategy:** When operating in RTL locales (e.g., Arabic EHS regional teams), swap the root font-family to native font stacks prioritized as: `'Readex Pro', 'Tajawal', 'Cairo', sans-serif`. 
- **Type Scale Ratio:** All Arabic text layers scale upwards by +1px relative to Latin body styles to guarantee equal optical x-height and counter-loop clarity.
- **Tabular Figures:** Tabular figures (`font-variant-numeric: tabular-nums`) must be activated across metrics, audit score counters, and sync status timers to prevent layout jitter during data updates.

## Layout & Spacing

Field inspection requires one-handed touch navigation, rapid thumb movement, and dense information grouping that does not cause visual crowding.

### Layout Model
- **Mobile-First Fixed Column Span:** Mobile devices (≤ 480px) operate on an 8pt vertical cadence within a single-column fluid card layout framed by `margin-mobile` (16px).
- **Tablet / Mounted Terminals:** (481px to 1024px) reflow into a 6-column fluid structure with a 240px persistent lateral task list and multi-column inspection checklists.
- **Thumb Zone Optimization:** Primary actions, incident capture triggers, and sync buttons are anchored to the lower 35% of the viewport (bottom navigation and thumb-reachable floating sheets).

### Touch Density Rules
- Strict minimum touch target dimension: **48x48px** for all actionable surfaces (checkboxes, photo-attachment handles, list headers, and navigation items) to accommodate gloved hands.

## Elevation & Depth

To preserve the visual comfort and glare-free design mandate, this system rejects harsh, high-contrast drop shadows. Elevation is rendered using ambient, chromatic surface tinting and stacked tonal planes.

### Surface Tonal Hierarchy
- **Level 0 (App Canvas):** `#F8F9FA` base ground.
- **Level 1 (Card & Module Layer):** `#FFFFFF` crisp baseline cards resting directly on Level 0. Outlined with a hairline border: `1px solid rgba(29, 53, 87, 0.08)`.
- **Level 2 (Active Touch & Card Hover):** Elevated cards during drag-and-drop or expanded audit steps: `box-shadow: 0 4px 16px -2px rgba(29, 53, 87, 0.06), 0 2px 6px -1px rgba(29, 53, 87, 0.04)`.
- **Level 3 (Sticky Nav, Floating Buttons, Bottom Sheets):** `box-shadow: 0 8px 24px -4px rgba(29, 53, 87, 0.09)`.
- **Level 4 (Modals & Severe Incident Overlays):** `#FFFFFF` paired with an ambient backdrop scrim: `rgba(29, 53, 87, 0.45)` with a `4px` blur to keep visual focus locked without inducing jarring blackouts.

## Shapes

The design uses a rounded geometry level (`roundedness: 2`), balancing structural precision with an approachable, calm softness.

### Geometry Specifications
- **Cards & Data Modules:** `0.75rem` (12px) border radius. Gives cards clean definition without looking childlike or overly sharp.
- **Buttons & Input Fields:** `0.5rem` (8px) radius. Retains operational rigidity and clear field boundaries.
- **Badges, Status Pills & Sync Toggles:** Fully pill-shaped (`9999px`) to create clear semantic contrast against rectangular data cards.
- **Interactive Toggles & Checkboxes:** `0.375rem` (6px) rounded squares, making hit targets distinct and visually distinct from radio circles.

## Components

### Buttons
- **Primary Operational:** Deep Sage (`#2D6A4F`) background, `#FFFFFF` text, `48px` minimum height, bold 14px centered typography. Subtle inset top-edge highlight (`box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2)`).
- **Secondary / Actionable Neutral:** Surface white with `1.5px` border of Slate Blue tint (`rgba(29, 53, 87, 0.18)`), Slate Blue text (`#1D3557`).
- **Destructive / High Hazard:** Coral Terracotta fill (`#E76F51`) with `#FFFFFF` text; used exclusively for lockout, tagout, or fatal risk logging.
- **Disabled State:** Warm grey background (`#E9ECEF`) with muted label (`#ADB5BD`), preventing false-positive clicks.

### Incident Chips & Status Badges
- **Shape & Spacing:** Fully pill-shaped (`rounded-full`), `space-xs` (4px) vertical padding, `space-sm` (8px) horizontal padding.
- **Compliant:** Background `#EEF6F2`, Text `#2D6A4F`, accompanied by a solid 6px Sage status dot.
- **Moderate Risk:** Background `#FEF7EC`, Text `#D97706`, accompanied by an Amber dot.
- **Severe Hazard:** Background `#FDF0ED`, Text `#E76F51`, accompanied by a Terracotta Coral dot.
- **Offline Queued:** Background `#EDEFF2`, Text `#5C677D`, with an offline synchronization pulse icon.

### Cards & Audit Lists
- **Structure:** Level 1 `#FFFFFF` surface container with a `1px` subtle border (`#E5E9F0`).
- **Internal Padding:** `space-md` (14px) mobile, `space-lg` (20px) tablet.
- **List Items:** Separated by hairline borders (`#F1F3F5`). Active items trigger a `2px` left border (or right border in RTL modes) painted with Primary Sage (`#2D6A4F`).

### Inputs, Checkboxes & Form Fields
- **Inspection Inputs:** `48px` minimum field height. `#FFFFFF` background, `1.5px` neutral border (`#DEE2E6`). Active focus state: `1.5px` border (`#2D6A4F`) plus a `3px` calm focus ring (`rgba(64, 145, 108, 0.15)`).
- **Checkboxes:** Size `22x22px` housed inside a `48x48px` padded touch zone. Unchecked: `1.5px` Slate border (`#CED4DA`). Checked: Solid `#2D6A4F` fill with crisp white check mark icon.
- **Radio Buttons:** `22x22px` circle with a `6px` concentric dot when activated.

### Field-Specific Components
- **Offline Sync Indicator Bar:** Fixed-position pill or top app bar banner. `#1D3557` deep slate surface with crisp white micro-copy, animated sync glyph, and pending changes counter (`"3 Audits Pending Sync"`).
- **Ergonomic Bottom App Bar:** High-elevation bar (`56px` height + safe area insets). Features 4 primary modules (Dashboard, Audits, Incidents, Profile) alongside a raised central `52px` action button for instant hazard reporting.
- **Risk Assessment Matrix Selector:** Modular 5x5 segmented touch-grid utilizing the calm status color scale, avoiding jarring saturated colors to maintain readable matrix indices.