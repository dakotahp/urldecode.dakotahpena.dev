# urldecode.dakotahpena.dev

A URL encoder/decoder. Paste a URL, get it back decoded or encoded.

**[urldecode.dakotahpena.dev](https://urldecode.dakotahpena.dev)**

## Stack

Zero dependencies. No build step. Three files: `index.html`, `style.css`, `script.js`. Deployed directly from the `gh-pages` branch via GitHub Pages.

Encoding and decoding use native browser APIs (`encodeURIComponent` / `decodeURIComponent`).

## Local development

```bash
open index.html       # macOS
xdg-open index.html   # Linux
```

## Deploy

```bash
git push origin gh-pages
```

## Design

Inspired by the Drive (2011) movie poster. Near-black background, hot pink accent, scanline and vignette overlays, italic serif title with glow.
