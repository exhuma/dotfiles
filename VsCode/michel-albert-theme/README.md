# Michel Albert theme

Dark and light VS Code themes generated from the Michel Albert design system.

## Install

Run the `install` script. It links this folder to
`~/.vscode/extensions/exhuma.michel-albert-theme-0.1.0`.

VS Code only loads a hand-placed extension folder when it is named
`<publisher>.<name>-<version>`. Rename the link in `install` when you change
`version` in `package.json`.

Quit VS Code completely and start it again, then pick *Michel Albert Dark* or
*Michel Albert Light* with Ctrl+K Ctrl+T.

## Package as .vsix

```
cd VsCode/michel-albert-theme
npx @vscode/vsce package --allow-missing-repository
code --install-extension michel-albert-theme-0.1.0.vsix
```

`--allow-missing-repository` is needed because `package.json` has no
`repository` field.

## License

MIT, see `LICENSE.md`.
