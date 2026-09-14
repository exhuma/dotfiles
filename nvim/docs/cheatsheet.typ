// Neovim cheat sheet — regenerate with:
//   typst compile docs/cheatsheet.typ docs/nvim-cheatsheet.pdf
// Keep this in sync with lua/config/keymaps.lua and lua/plugins/*.lua.

#set page(paper: "a4", flipped: true, margin: 9mm)
#set text(font: "DejaVu Sans", size: 7.3pt)
#set par(leading: 0.45em)

#let mono(s) = text(font: "DejaVu Sans Mono", s)

// One category block: a black title bar + a two-column key/description
// table, optionally followed by an italic note.
#let cat(title, rows, note: none) = block(breakable: false, below: 6pt)[
  #block(fill: black, inset: (x: 3pt, y: 1.5pt), width: 100%, below: 2pt)[
    #text(fill: white, size: 7.8pt, weight: "bold", tracking: 0.4pt)[#upper(title)]
  ]
  #table(
    columns: (auto, 1fr),
    column-gutter: 5pt,
    stroke: none,
    inset: (x: 0pt, y: 1pt),
    fill: (_, row) => if calc.rem(row, 2) == 1 { rgb(240, 240, 240) } else { white },
    ..rows.map(r => (mono(r.at(0)), r.at(1))).flatten()
  )
  #if note != none [
    #text(style: "italic", size: 6.8pt, fill: rgb(50, 50, 50))[#note]
  ]
]

// ─── Header ──────────────────────────────────────────────────────────────
#grid(
  columns: (1fr, auto),
  align(horizon)[#text(size: 13pt, weight: "bold")[Neovim Cheat Sheet]],
  align(horizon + right)[
    #text(size: 7.5pt)[
      Leader = #mono[*\<Space\>*] #h(8pt) Local leader = #mono[*\\*] #h(8pt) ~/dotfiles/nvim
    ]
  ],
)
#line(length: 100%, stroke: 1.5pt)
#v(4pt)

// ─── Body: an explicit 4-column grid, manually balanced (Typst's own
// `columns()` fills sequentially rather than balancing like CSS multicol,
// which left a column empty and pushed the footer to a second page) ──────

#let col1 = [
  #cat("General Editing", (
    ("jj", "Escape insert mode"),
    ("C-s", "Save file"),
    ("Esc", "Clear search highlight"),
    ("n / N", "Next/prev search result (centered)"),
    ("* / #", "Search word under cursor (centered)"),
    ("g* / g#", "Search word, partial match (centered)"),
    ("j / k", "Move by display line (wrapped)"),
    ("A-j / A-k", "Move line/selection down/up"),
    ("< / >", "Indent, reselect (visual)"),
  ))
  #cat("Windows & Buffers", (
    ("C-h/j/k/l", "Move to window left/down/up/right"),
    ("C-Up/Down", "Resize horizontal split"),
    ("C-Left/Right", "Resize vertical split"),
    ("S-l / S-h", "Next / previous buffer"),
    ("<lead>bd", "Delete buffer"),
    ("]q / [q", "Next / previous quickfix item"),
  ))
  #cat("Timestamps", (
    ("F4", "Insert date (YYYY-MM-DD)"),
    ("F5", "Insert date + time"),
    ("F6", "Insert compact date (YYYYMMDD)"),
    ("dts", [Abbrev #sym.arrow.r live timestamp (insert)]),
  ))
  #cat("Find (Telescope)", (
    ("<lead>ff", "Find files"),
    ("<lead>fg", "Live grep"),
    ("<lead>fb", "Buffers"),
    ("<lead>fh", "Help tags"),
    ("<lead>fr", "Recent files"),
    ("<lead>fs", "Document symbols"),
    ("C-j / C-k", "In picker: next/prev result"),
    ("C-q", "In picker: send to quickfix"),
  ))
]

#let col2 = [
  #cat("LSP", (
    ("K", "Hover docs"),
    ("gd", "Go to definition"),
    ("gr", "References"),
    ("gi", "Go to implementation"),
    ("<lead>ca", "Code action"),
    ("<lead>rn", "Rename symbol"),
    ("<lead>e", "Show diagnostic (float)"),
    ("]d / [d", "Next / previous diagnostic"),
  ), note: [pyright, ruff, ts\_ls, eslint, lua\_ls])
  #cat("Completion (blink.cmp)", (
    ("Tab / S-Tab", "Navigate menu / snippet tabstop"),
    ("C-l", [*Accept suggestion*]),
    ("CR", "Always just a newline"),
    ("C-Space", "Show menu / toggle docs"),
    ("C-e", "Hide menu"),
    ("C-k", "Show signature help"),
    ("C-b / C-f", "Scroll docs up/down"),
  ), note: [Tab/Enter never auto-accept --- only C-l does.])
  #cat("AI Ghost Text (Supermaven)", (
    ("C-y", [*Accept full suggestion*]),
    ("C-j", "Accept one word"),
    ("C-]", "Clear suggestion"),
  ))
  #cat("Git", (
    ("<lead>gg", "Neogit status"),
    ("<lead>gd", "Diffview open"),
    ("<lead>gc", "Diffview close"),
    ("<lead>gh", "File history"),
    ("]h / [h", "Next / previous hunk"),
    ("<lead>hs", "Stage hunk"),
    ("<lead>hr", "Reset hunk"),
    ("<lead>hp", "Preview hunk"),
    ("<lead>hb", "Blame line"),
    ("<lead>hd", "Diff this"),
  ))
]

#let col3 = [
  #cat("File Explorer (oil)", (
    ("-", "Open parent directory"),
  ), note: [Directory is a buffer: edit it like text, :w to apply.])
  #cat("Folding", (
    ("zR / zM", "Open / close all folds"),
    ("zK", "Peek fold (or hover if none)"),
  ), note: [Standard za/zc/zo/zf still work as usual.])
  #cat("Treesitter", (
    ("C-Space", "Init / expand selection"),
    ("BS", "Shrink selection"),
    ("af / if", "Around / inside function"),
    ("ac / ic", "Around / inside class"),
    ("aa / ia", "Around / inside parameter"),
    ("]f / [f", "Next / prev function start"),
    ("]c / [c", "Next / prev class start"),
  ))
  #cat("Python & Debugging", (
    ("<lead>pv", "Select venv"),
    ("<lead>pc", "Show current venv"),
    ("<lead>db", "Toggle breakpoint"),
    ("<lead>dc", "Continue"),
    ("<lead>di", "Step into"),
    ("<lead>do", "Step over"),
    ("<lead>d S-o", "Step out (capital O)"),
    ("<lead>du", "Toggle DAP UI"),
  ))
  #cat("Diagnostics (Trouble)", (
    ("<lead>xx", "All diagnostics"),
    ("<lead>xX", "Buffer diagnostics"),
    ("<lead>xL", "Location list"),
    ("<lead>xQ", "Quickfix list"),
  ))
]

#let col4 = [
  #cat("Formatting", (
    ("<lead>lf", "Format file / selection"),
  ), note: [Auto-formats on save: ruff (py), prettier (js/ts/json/#sym.dots.h), stylua (lua).])
  #cat("Emmet & Tables", (
    ("C-z ,", "Emmet expand (html/css/jsx/tsx/vue)"),
  ), note: [vim-table-mode auto-formats Markdown/text tables as you type pipes.])
  #cat("Plugin Management", (
    ("<lead>L", "Lazy (plugin manager)"),
    ("<lead>M", "Mason (LSP/tool installer)"),
  ))
  #cat("Custom Snippets", (
    ("python", "pp dp rp pdb ipdb setup logger ifmain __ ut skip fail rt"),
    ("javascript", "prov req gd listen esym xhr (closure-js)"),
    ("typescript", "dp"),
    ("vue", "comp data meth"),
    ("gitconfig", "autopush"),
  ), note: [Type prefix, accept via completion menu (C-l) to expand.])
]

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8mm,
  col1, col2, col3, col4,
)

#v(4pt)
#line(length: 100%, stroke: 0.5pt + rgb(150, 150, 150))
#text(size: 6.5pt, fill: rgb(80, 80, 80))[
  Generated for ~/dotfiles/nvim --- regenerate from docs/cheatsheet.typ after editing keymaps.
]
