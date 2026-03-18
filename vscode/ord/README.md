# ORD Language Support for VS Code

Syntax highlighting for the [ORD hardware description language](https://ordec.readthedocs.io/), used by the ORDeC (Open Rapid Design Composer) IC design platform.

## Features

- Syntax highlighting for `.ord` files, including:
  - `cell` and `viewgen` declarations
  - `path` and `net` declarations
  - Connection operator (`--`)
  - Constrain operator (`!`)
  - Parameter access (`.$param`)
  - Dotted context access (`.name`, `..name`)
  - SI unit suffixes (`100n`, `3.14u`, `1M`)
  - Rational numbers (`1/3`, `100/7`)
  - Context elements (`Nmos m1:`, `inout vdd:`)
  - Full Python syntax support (ORD extends Python)
- Includes an ORD-specific dark color theme

## Installation

### From VSIX (recommended)

1. Install the packaging tool if you don't have it:
   ```
   npm install -g @vscode/vsce
   ```
2. From the `vscode/ord/` directory, package the extension:
   ```
   vsce package
   ```
3. Install the resulting `.vsix` file in VS Code:
   ```
   code --install-extension ord-0.0.1.vsix
   ```

### Development Mode

1. Open the `vscode/ord/` folder in VS Code.
2. Press `F5` to launch a new VS Code window with the extension loaded.
3. Open any `.ord` file to see syntax highlighting in action.

### Manual Installation

Copy the `vscode/ord/` directory into your VS Code extensions folder:

- **Linux:** `~/.vscode/extensions/ord/`
- **macOS:** `~/.vscode/extensions/ord/`
- **Windows:** `%USERPROFILE%\.vscode\extensions\ord\`

Then restart VS Code.

## Theme

The extension includes an **ORD Dark Plus** color theme optimized for ORD files. To activate it:

1. Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
2. Type "Color Theme" and select **Preferences: Color Theme**
3. Select **ORD Theme**
