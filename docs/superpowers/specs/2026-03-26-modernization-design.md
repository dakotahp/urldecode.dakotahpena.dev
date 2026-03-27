# URL Decode — Modernization Design

**Date:** 2026-03-26
**Status:** Approved

## Overview

Replace the existing Jekyll + Webpack + React 16 stack with a zero-dependency, zero-build-step static site. The core functionality (encode/decode toggle + input/output) is preserved. The visual design is overhauled to fully commit to the Drive movie poster aesthetic that the original site gestured toward but didn't execute.

## Tech Stack

**Before:** Jekyll (Ruby) + Webpack 4 + Babel 6 + React 16 + `webtoolkit.url.js`

**After:** Plain `index.html` + `style.css` + `script.js`. No build step. No npm. No Ruby. Committed directly to the `gh-pages` branch. GitHub Pages serves it as-is.

Encoding/decoding is handled entirely by native browser APIs (`encodeURIComponent` / `decodeURIComponent`) — no external library needed.

## Files

### Kept
- `CNAME` — domain binding, unchanged
- `robots.txt` — unchanged
- `googleabad8f5c4a056069.html` — Google Search Console verification, unchanged

### Created
- `index.html` — full page shell with meta tags, font link, stylesheet/script references
- `style.css` — all visual styling
- `script.js` — encode/decode logic (~20 lines)

### Deleted
Everything else: `Gemfile`, `Gemfile.lock`, `_config.yml`, `_layouts/`, `_assets/`, `webpack/`, `src/`, `webpack.config.js`, `Procfile`, `package.json`, `package-lock.json`, `javascripts/`, `stylesheets/`, `.tool-versions`, `font/`, `README.md`

## Visual Design

### Aesthetic
Full commitment to the Drive (2011) movie poster aesthetic: near-black background, hot pink as the sole accent color, atmospheric overlays, monospace typography.

### Layout — The Poster
Two distinct vertical zones:

1. **Hero (upper):** Giant italic serif title dominates the top half of the viewport. A thin rule and a subtitle sit below it. This zone is purely presentational — it establishes the visual identity.
2. **Tool (lower):** A compact, contained bar pinned to the bottom. Separated from the hero by a near-invisible top border. Holds the mode toggle and both input fields.

### Typography
- **Title:** Georgia italic, `clamp(4rem, 12vw, 8rem)`, hot pink with multi-layer glow (`text-shadow`)
- **All other text:** Inconsolata (Google Fonts), monospace
- **Toggle + labels:** Uppercase, wide letter-spacing, small size

### Color
- Background: `#0a0a0a`
- Primary/accent: `#f4579e` (hot pink)
- Inactive states: `rgba(244, 87, 158, 0.25)` and lower
- No secondary colors

### Atmosphere
- **Scanlines:** `repeating-linear-gradient` overlay, fixed position, `z-index: 100`
- **Vignette:** `radial-gradient` darkening toward edges, fixed position, `z-index: 99`

### Inputs
- No border box — underline only (`border-bottom`)
- Transparent background
- Hot pink text, monospace
- Placeholder text is very faint (`opacity ~0.15`)
- Input brightens its underline on `:focus`
- Output field is read-only, slightly dimmer than input

## Interaction Design

### Mode Toggle
- Two options: **Decode** / **Encode**, separated by `/`
- Active mode: full opacity + underline
- Inactive mode: faded (`opacity: 0.25`), no underline
- Clicking switches mode and re-processes current input value

### Encode/Decode Logic
- Input field: user types or pastes
- Output field: updates on every `input` event — no submit button
- Decode: `decodeURIComponent(value)` — on error (malformed URI), passes through unchanged
- Encode: `encodeURIComponent(value)`

### No Footer
The original footer ("Made in Coeur d'Alene · Source code") is removed. It added clutter to a tool page and broke the cinematic composition. Attribution can be added back later if desired via a minimal approach (e.g., a GitHub icon link).

## Deployment

No change to deployment mechanism. The `gh-pages` branch is served directly by GitHub Pages. With no build step, the workflow is: edit → commit → push → live.

`.superpowers/` should be added to `.gitignore`.
