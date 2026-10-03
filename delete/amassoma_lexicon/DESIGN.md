---
name: Amassoma Lexicon
colors:
  surface: '#fcf9f2'
  surface-dim: '#dcdad3'
  surface-bright: '#fcf9f2'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3ec'
  surface-container: '#f0eee7'
  surface-container-high: '#ebe8e1'
  surface-container-highest: '#e5e2db'
  on-surface: '#1c1c18'
  on-surface-variant: '#45464d'
  inverse-surface: '#31312c'
  inverse-on-surface: '#f3f0e9'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#9b4500'
  on-secondary: '#ffffff'
  secondary-container: '#fd8a42'
  on-secondary-container: '#682c00'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#0d1c2f'
  on-tertiary-container: '#76859b'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#ffdbca'
  secondary-fixed-dim: '#ffb68e'
  on-secondary-fixed: '#331200'
  on-secondary-fixed-variant: '#763300'
  tertiary-fixed: '#d5e3fd'
  tertiary-fixed-dim: '#b9c7e0'
  on-tertiary-fixed: '#0d1c2f'
  on-tertiary-fixed-variant: '#3a485c'
  background: '#fcf9f2'
  on-background: '#1c1c18'
  surface-variant: '#e5e2db'
typography:
  headline-xl:
    fontFamily: Merriweather
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
  headline-xl-mobile:
    fontFamily: Merriweather
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-lg:
    fontFamily: Merriweather
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-lg-mobile:
    fontFamily: Merriweather
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 30px
  headline-md:
    fontFamily: Merriweather
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  title-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  title-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 26px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 22px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 10px
    fontWeight: '600'
    lineHeight: 14px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-tablet: 1.5rem
  gutter-desktop: 2rem
  margin: 1rem
  margin-tablet: 2rem
  margin-desktop: 3rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system embodies an authoritative, scholarly, and culturally grounded presence tailored for the documentation and daily usage of the Amassoma language (an Ijaw/Izon dialect of Bayelsa State, Nigeria). Drawing inspiration from classical academic reference texts—such as the Oxford English Dictionary—the aesthetic balances rigorous lexicographical heritage with modern digital utility.

The visual direction merges **Academic Editorial Modernism** with the physical warmth of archival parchment. The interface avoids cold, clinical software tropes in favor of an inviting, scholarly tone that dignifies indigenous linguistic heritage. It provides researchers, native speakers, students, and preservationists with an institutional yet welcoming tool. Tactile cues, subtle borders, high-contrast typography, and careful typographic rhythm ensure clarity, authority, and sustained reading comfort over long sessions.

## Colors

The color palette reflects institutional authority balanced against warm earthy pigments found across the Niger Delta:

- **Primary (`#0F172A`)**: Deep Academic Ink. Used for principal headwords, high-emphasis text, primary icons, and focused navigation states. Conveys archival weight and scholarly precision.
- **Secondary (`#B45309`)**: Terracotta Ochre. Used for semantic accents, active search indicators, phonetic/tonal highlights, audio playback buttons, and lexical tags (e.g., etymology and parts of speech).
- **Tertiary (`#334155`)**: Slate Graphite. Deployed for definition text, sub-sense indicators, and metadata labels requiring neutral legibility without competing with headwords.
- **Neutral (`#F8F5EE`)**: Parchment Ground. Forms the foundational surface layer, mimicking warm book paper to eliminate screen glare and ease prolonged lexicographical study. Paired with pure `#FFFFFF` for elevated lexical entry cards and `#E7E0D3` / `#E2E8F0` for low-contrast divider rules.

## Typography

The typographic system relies on an intentional pairing: **Merriweather** for headwords, lemma titles, and linguistic examples, coupled with **Plus Jakarta Sans** for UI controls, search interactions, phonetic guides, and definitions.

A critical requirement for the Amassoma language is flawless rendering of sub-dots, tone markers, and diacritics (`ẹ`, `ọ`, `ị`, `ụ`, and high/low accent marks). Both fonts feature expansive Unicode Latin coverage and generous vertical metrics, preventing clipping of tone markers above or under-dots below vowel stems.

- **Headwords**: Rendered in `headline-xl` or `headline-lg` Merriweather to assert lexicographical authority.
- **Senses and Glosses**: Formatted with `body-lg` or `body-md` Plus Jakarta Sans, providing open apertures and high legibility at dense layout densities.
- **Grammatical Metadata**: Parts of speech, tone classifications, and inflectional paradigms rely on `label-md` or `label-sm` set in medium/semi-bold weights with subtle tracking to maintain clarity at compact sizes.

## Layout & Spacing

The layout employs an intentional editorial reading grid structured to handle hierarchical lexicographical data:

- **Grid Architecture**: A 4-column grid on mobile (360px–599px), transitioning to an 8-column layout on tablet (600px–1023px), and a centered 12-column reading column on desktop (1024px+). The maximum content width for dictionary entry views is capped at 860px to maintain comfortable typographic line lengths (60–75 characters per line).
- **Rhythm**: Spacing follows a clean 4px/8px incremental base. Lexical senses are delineated with `space-md` gaps, while nested sub-definitions use indented left padding equal to `space-lg`.
- **Search & Diacritic Input Dock**: Placed immediately adjacent to the global search bar, the diacritic helper bar utilizes `space-xs` item gaps to create an ergonomic horizontal ribbon for rapid input of specialized characters.

## Elevation & Depth

This design system uses **Tonal Layers** combined with **Low-Contrast Outlines** rather than dramatic, deep drop-shadows, honoring the tactile, flat quality of ink and bound volumes:

- **Surface Level 0 (Canvas)**: Warm Parchment (`#F8F5EE`), grounding the entire application viewport.
- **Surface Level 1 (Card & Entry Containers)**: Warm Pure White (`#FFFFFF`) with a 1px hairline border in `#E7E0D3`. It provides distinct foreground separation without harsh digital contrast.
- **Surface Level 2 (Floating Action Bars / Sticky Headwords)**: Surface `#FFFFFF` with a 1px border in `#E2E8F0` and an ambient, low-opacity shadow (`box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05)`).
- **Overlay & Popover Surfaces**: Search suggestions, phonetic keyboards, and filter sheets use `#FFFFFF` outlined in `#CBD5E1` with a soft ambient veil (`rgba(15, 23, 42, 0.25)`).

## Shapes

The design system adopts a **Soft (Level 1)** geometric standard. Containers, definition cards, and inputs utilize a `4px` (`0.25rem`) base radius, maintaining an archival, structured appearance reminiscent of bookplates and catalog indices.

Exceptions are made for interactive utility elements:
- **Audio pronunciation buttons** and **Part-of-Speech badges** utilize full pill geometry to communicate clickability and contrast against the rectangular structure of entry cards.
- **Diacritic quick-selector keys** use a balanced `4px` radius to simulate tactile mechanical keycaps.

## Components

### 1. Headword Entry Cards
- **Container**: Elevated `#FFFFFF` card with a `1px` solid border (`#E7E0D3`) and `space-lg` internal padding.
- **Structure**:
  1. Headword (`headline-xl`, `#0F172A`) alongside tone accents.
  2. Phonetic transcription (`body-md`, `#64748B`, enclosed in brackets).
  3. Inline Audio Pronunciation Pill.
  4. Numbered definitions (`body-lg`, `#334155`) with bold secondary counters (`#B45309`).
  5. Contextual usage examples italicized in Merriweather (`body-md`, `#475569`) paired with English translations (`body-sm`, `#64748B`).

### 2. Audio Pronunciation Button
- **Geometry**: Compact pill-shaped chip (`border-radius: 9999px`) with `space-xs` vertical and `space-sm` horizontal padding.
- **Colors**: Background `#F8F5EE`, border `1px solid #E7E0D3`, active wave icon and text in `#B45309`.
- **States**: Hover warms the background to `#F1EAD9`; active playing state renders an animated waveform icon.

### 3. Search Bar with Diacritic Quick-Input Bar
- **Input Field**: Elevated card container featuring a search icon, placeholder text ("Search Amassoma or English..."), and quick clear action.
- **Diacritic Ribbon**: Fixed directly beneath or inside the active search field. A horizontal sequence of quick-tap keys (`ẹ`, `ọ`, `ị`, `ụ`, high tone ´, low tone `). Each key has a 36x36px minimum touch target, `#F8F5EE` surface, and crisp `#0F172A` label.

### 4. Part-of-Speech Chips
- **Geometry**: Compact pill or 4px rounded chip.
- **Style**: Subtle background tint (`#FEF3C7`), text `#B45309` set in `label-sm` uppercase with `0.05em` letter-spacing (e.g., `NOUN`, `TRANSITIVE VERB`, `IDEOPHONE`).

### 5. Buttons & Actions
- **Primary Button**: Deep academic navy (`#0F172A`) background, white text (`label-md`), `4px` corner radius.
- **Secondary Button**: Ochre outline (`1px solid #B45309`), text `#B45309`, transparent or warm parchment hover.
- **Icon Actions (Bookmark, Share, Cite)**: Minimalist ghost icon buttons with `#475569` strokes, transitioning to `#B45309` on interaction.

### 6. Senses and Sub-definition Hierarchy
- **Primary Sense**: Indented with `space-sm`, preceded by an ochre bold numeral (`1.`, `2.`).
- **Sub-senses**: Further indented by `space-lg`, prefaced by alphabetical markers (`a.`, `b.`) in `#64748B`, keeping cross-references clearly legible.