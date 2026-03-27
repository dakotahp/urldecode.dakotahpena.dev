# URL Decode Modernization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the Jekyll + Webpack + React 16 stack with a zero-dependency, zero-build-step static site that delivers the same encode/decode functionality in a Drive-inspired cinematic design.

**Architecture:** Three files — `index.html`, `style.css`, `script.js` — committed directly to the `gh-pages` branch. No build step, no npm, no Ruby. GitHub Pages serves them as-is. All encoding/decoding is handled by native browser APIs.

**Tech Stack:** Vanilla HTML5, CSS3, ES5-compatible JavaScript, Inconsolata via Google Fonts, native `encodeURIComponent` / `decodeURIComponent`.

**Spec:** `docs/superpowers/specs/2026-03-26-modernization-design.md`

---

## File Map

| Action | Path | Responsibility |
|--------|------|---------------|
| Create | `index.html` | Page shell, meta tags, font link, markup |
| Create | `style.css` | All visual styling — Drive aesthetic |
| Create | `script.js` | Encode/decode logic, mode toggle |
| Modify | `.gitignore` | Add `.superpowers/` |
| Delete | `Gemfile`, `Gemfile.lock` | Jekyll Ruby dependency files |
| Delete | `_config.yml` | Jekyll config |
| Delete | `_layouts/` | Jekyll layout templates |
| Delete | `_assets/` | Jekyll asset pipeline |
| Delete | `webpack/` | Webpack entry + React components |
| Delete | `src/` | Sass source |
| Delete | `webpack.config.js` | Webpack config |
| Delete | `Procfile` | Process runner config |
| Delete | `package.json`, `package-lock.json` | npm manifests |
| Delete | `javascripts/` | Webpack output + webtoolkit |
| Delete | `stylesheets/` | Compiled CSS |
| Delete | `font/` | Bundled font files |
| Delete | `README.md` | Stale project readme |
| Delete | `.tool-versions` | asdf version pins for old stack |

---

## Task 1: Update `.gitignore` and remove old stack files

**Files:**
- Modify: `.gitignore`
- Delete: `Gemfile`, `Gemfile.lock`, `_config.yml`, `_layouts/`, `_assets/`, `webpack/`, `src/`, `webpack.config.js`, `Procfile`, `package.json`, `package-lock.json`, `javascripts/`, `stylesheets/`, `font/`, `README.md`, `.tool-versions`

- [ ] **Step 1: Update `.gitignore`**

Replace the entire contents of `.gitignore` with:

```
.superpowers/
```

- [ ] **Step 2: Delete old stack files**

```bash
git rm -r Gemfile Gemfile.lock _config.yml _layouts _assets webpack src webpack.config.js Procfile package.json package-lock.json javascripts stylesheets font README.md .tool-versions
```

Expected output: a list of `rm` lines for each file/directory.

- [ ] **Step 3: Verify only expected files remain**

```bash
git status
```

Expected: `.gitignore` modified, all the deleted files staged, and `CNAME`, `robots.txt`, `googleabad8f5c4a056069.html`, `404.html` untouched.

- [ ] **Step 4: Commit**

```bash
git add .gitignore
git commit -m "Remove old Jekyll/Webpack/React stack"
```

---

## Task 2: Create `script.js`

**Files:**
- Create: `script.js`

- [ ] **Step 1: Create `script.js`**

```javascript
(function () {
  var input = document.getElementById('input-url');
  var output = document.getElementById('output-url');
  var btnDecode = document.getElementById('btn-decode');
  var btnEncode = document.getElementById('btn-encode');
  var mode = 'decode';

  function process() {
    var val = input.value;
    if (!val) { output.value = ''; return; }
    try {
      output.value = mode === 'decode'
        ? decodeURIComponent(val)
        : encodeURIComponent(val);
    } catch (e) {
      output.value = val;
    }
  }

  input.addEventListener('input', process);

  btnDecode.addEventListener('click', function (e) {
    e.preventDefault();
    mode = 'decode';
    btnDecode.classList.add('active');
    btnEncode.classList.remove('active');
    process();
  });

  btnEncode.addEventListener('click', function (e) {
    e.preventDefault();
    mode = 'encode';
    btnEncode.classList.add('active');
    btnDecode.classList.remove('active');
    process();
  });
}());
```

- [ ] **Step 2: Commit**

```bash
git add script.js
git commit -m "Add vanilla JS encode/decode logic"
```

---

## Task 3: Create `style.css`

**Files:**
- Create: `style.css`

- [ ] **Step 1: Create `style.css`**

```css
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
}

body {
  background: #0a0a0a;
  color: #f4579e;
  font-family: 'Inconsolata', 'Courier New', monospace;
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
}

/* Scanlines */
body::before {
  content: '';
  position: fixed;
  inset: 0;
  background: repeating-linear-gradient(
    0deg,
    transparent,
    transparent 3px,
    rgba(0, 0, 0, 0.12) 3px,
    rgba(0, 0, 0, 0.12) 4px
  );
  pointer-events: none;
  z-index: 100;
}

/* Vignette */
body::after {
  content: '';
  position: fixed;
  inset: 0;
  background: radial-gradient(ellipse at center, transparent 35%, rgba(0, 0, 0, 0.65) 100%);
  pointer-events: none;
  z-index: 99;
}

/* ── Hero ── */
.hero {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 48px 24px 24px;
  position: relative;
  z-index: 10;
}

.site-title {
  font-family: Georgia, 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  font-size: clamp(4rem, 12vw, 8rem);
  letter-spacing: 0.22em;
  color: #f4579e;
  text-shadow:
    0 0 20px rgba(244, 87, 158, 0.8),
    0 0 60px rgba(244, 87, 158, 0.35),
    0 0 140px rgba(244, 87, 158, 0.15);
  line-height: 1;
}

.title-rule {
  width: 48px;
  height: 1px;
  background: rgba(244, 87, 158, 0.35);
  margin: 20px auto 16px;
}

.site-subtitle {
  font-size: clamp(0.6rem, 1.2vw, 0.72rem);
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: rgba(244, 87, 158, 0.28);
  line-height: 1.7;
}

/* ── Tool bar ── */
.tool-wrapper {
  width: 100%;
  display: flex;
  justify-content: center;
}

.tool {
  border-top: 1px solid rgba(244, 87, 158, 0.07);
  padding: 36px 40px 48px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
  position: relative;
  z-index: 10;
  background: rgba(0, 0, 0, 0.2);
  width: 100%;
  max-width: 800px;
}

/* ── Toggle ── */
.toggle {
  display: flex;
  align-items: center;
  gap: 20px;
  font-size: 0.9rem;
  letter-spacing: 0.28em;
  text-transform: uppercase;
}

.toggle a {
  color: #f4579e;
  text-decoration: none;
  opacity: 0.25;
  padding-bottom: 3px;
  border-bottom: 1px solid transparent;
  transition: opacity 0.2s;
  cursor: pointer;
}

.toggle a.active {
  opacity: 1;
  border-bottom-color: #f4579e;
}

.toggle a:hover {
  opacity: 0.6;
}

.toggle-sep {
  color: rgba(244, 87, 158, 0.12);
  font-size: 1.1rem;
}

/* ── Fields ── */
.fields {
  display: flex;
  align-items: center;
  gap: 20px;
  width: 100%;
}

input[type="text"] {
  flex: 1;
  background: transparent;
  border: none;
  border-bottom: 1px solid rgba(244, 87, 158, 0.25);
  color: #f4579e;
  font-family: 'Inconsolata', 'Courier New', monospace;
  font-size: 1.25rem;
  padding: 14px 4px;
  text-align: center;
  outline: none;
  letter-spacing: 0.03em;
  transition: border-color 0.2s;
  caret-color: #f4579e;
  min-width: 0;
}

input[type="text"]::placeholder {
  color: rgba(244, 87, 158, 0.15);
  letter-spacing: 0.18em;
  text-transform: uppercase;
  font-size: 0.78rem;
}

input[type="text"]:focus {
  border-bottom-color: rgba(244, 87, 158, 0.7);
}

.field-arrow {
  color: rgba(244, 87, 158, 0.2);
  font-size: 1.2rem;
  flex-shrink: 0;
}
```

- [ ] **Step 2: Commit**

```bash
git add style.css
git commit -m "Add Drive-inspired CSS"
```

---

## Task 4: Create `index.html`

**Files:**
- Create: `index.html`

- [ ] **Step 1: Create `index.html`**

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Decode or Encode URL Strings | urldecode.dakotahpena.dev</title>
  <meta name="description" content="Convert URLs to decoded or encoded strings.">
  <meta name="google-site-verification" content="hB6Q_GIiFTkyXpLycD5jJf-_Fz7oE9Sg8sutXTE_QZI">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inconsolata:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
  <script async defer data-website-id="d7e9dab2-7af9-4f6c-895a-3a2789af62a4" src="https://analytics.dakotahpena.dev/umami.js"></script>
</head>
<body>
  <main>
    <div class="hero">
      <h1 class="site-title">DECODE</h1>
      <div class="title-rule"></div>
      <p class="site-subtitle">Convert URLs to decoded<br>or encoded strings</p>
    </div>
    <div class="tool-wrapper">
      <div class="tool">
        <nav class="toggle">
          <a class="active" id="btn-decode">Decode</a>
          <span class="toggle-sep">/</span>
          <a id="btn-encode">Encode</a>
        </nav>
        <div class="fields">
          <input type="text" id="input-url" placeholder="Paste URL here" autocomplete="off" spellcheck="false">
          <span class="field-arrow">→</span>
          <input type="text" id="output-url" placeholder="Output" readonly>
        </div>
      </div>
    </div>
  </main>
  <script src="script.js"></script>
</body>
</html>
```

- [ ] **Step 2: Commit**

```bash
git add index.html
git commit -m "Add index.html"
```

---

## Task 5: Verify in browser and push

- [ ] **Step 1: Open `index.html` directly in a browser**

```bash
open index.html
# or on Linux:
xdg-open index.html
```

- [ ] **Step 2: Verify decode mode**

Paste `hello%20world%3F` into the input field.
Expected output: `hello world?`

- [ ] **Step 3: Verify encode mode**

Click **Encode**, clear the input, paste `hello world?`.
Expected output: `hello%20world%3F`

- [ ] **Step 4: Verify error handling**

In decode mode, paste a malformed string: `hello%ZZworld`.
Expected: input passes through unchanged (no crash, no blank output).

- [ ] **Step 5: Verify visual**

Confirm scanlines and vignette are visible, title glows pink, toggle shows active/inactive states correctly, fields are underline-only.

- [ ] **Step 6: Push to GitHub Pages**

```bash
git push origin gh-pages
```

Wait ~60 seconds, then open `https://urldecode.dakotahpena.dev` and repeat the verification steps above on the live site.
