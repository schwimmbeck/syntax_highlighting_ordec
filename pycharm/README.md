# ORD Language Support for PyCharm / IntelliJ IDEA

Syntax highlighting for the [ORD hardware description language](https://ordec.readthedocs.io/), used by the ORDeC (Open Rapid Design Composer) IC design platform.

This uses IntelliJ's built-in TextMate bundle support to provide syntax highlighting for `.ord` files.

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

## Installation

1. Open PyCharm (or any JetBrains IDE).
2. Go to **Settings** (`Ctrl+Alt+S` / `Cmd+,`).
3. Navigate to **Editor > TextMate Bundles**.
4. Click the **+** button.
5. Browse to and select the `ord.tmbundle` folder (the folder inside `pycharm/`, not `pycharm/` itself).
6. Click **OK** to confirm.
7. Restart the IDE if prompted.

After installation, any `.ord` file will automatically be highlighted using the ORD grammar.

## Supported IDEs

This TextMate bundle works with all JetBrains IDEs that support TextMate bundles:

- PyCharm (Community and Professional)
- IntelliJ IDEA (Community and Ultimate)
- CLion
- WebStorm
- GoLand
- Other JetBrains IDEs

## Notes

- The TextMate bundle uses the same grammar as the VS Code extension.
- Color mapping depends on your IDE's current color scheme. The IDE automatically maps TextMate scopes to its own color settings.
- To customize colors: **Settings > Editor > Color Scheme > TextMate** lets you adjust how TextMate scopes are rendered.
