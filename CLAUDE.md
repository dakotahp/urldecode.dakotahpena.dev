# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A zero-dependency static site deployed on GitHub Pages. It provides URL encoding and decoding via native browser APIs. There is no build step, no npm, no framework — just three files served directly from the `gh-pages` branch.

## Development

Open `index.html` directly in a browser to develop locally:

```bash
xdg-open index.html   # Linux
open index.html        # macOS
```

There are no build commands, test commands, or linters. Changes are live immediately on reload.

## Deployment

Commit and push to `gh-pages`. GitHub Pages serves the branch directly.

```bash
git push origin gh-pages
```

The live site is at `https://urldecode.dakotahpena.dev`.

## Architecture

Three files:

- **`index.html`** — page shell, meta tags, font imports, markup
- **`style.css`** — all styling
- **`script.js`** — all behaviour (IIFE, ~37 lines)

### Layout

`body` is a flex column stretched to `100vh`. `main` fills the remaining space (`flex: 1`), itself a flex column. `.hero` fills the upper portion (`flex: 1`), pushing `.tool-wrapper` to the bottom of the viewport. This creates the two-zone poster layout.

### JS

`script.js` is a single IIFE. It reads four element IDs (`input-url`, `output-url`, `btn-decode`, `btn-encode`), maintains a `mode` variable (`'decode'` or `'encode'`), and runs `encodeURIComponent`/`decodeURIComponent` on every `input` event. On malformed input, the decode path catches and passes the value through unchanged.

### CSS

The design is inspired by the Drive (2011) movie poster: near-black background (`#0a0a0a`), hot pink (`#f4579e`) as the sole accent. `body::before` is a scanline overlay (fixed, `z-index: 100`). `body::after` is a radial vignette (fixed, `z-index: 99`). Content sits at `z-index: 10`. `.toggle a` uses opacity (`0.25` inactive, `1` active) rather than color to indicate state.

## Files Not to Touch

- `CNAME` — domain binding for GitHub Pages
- `googleabad8f5c4a056069.html` — Google Search Console verification
- `robots.txt`
- `404.html`
