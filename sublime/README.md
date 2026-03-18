# ORD Language Support for Sublime Text

Syntax highlighting for the [ORD hardware description language](https://ordec.readthedocs.io/), used by the ORDeC (Open Rapid Design Composer) IC design platform.

## Features

- Extends Sublime Text's built-in Python syntax with ORD-specific constructs:
  - `cell` and `viewgen` declarations
  - `path` and `net` declarations
  - Connection operator (`--`)
  - Constrain operator (`!`)
  - Parameter access (`.$param`)
  - Dotted context access (`.name`, `..name`)
  - SI unit suffixes (`100n`, `3.14u`, `1M`)
  - Rational numbers (`1/3`, `100/7`)
  - Context elements (`Nmos m1:`, `inout vdd:`)

## Installation

### Manual Installation

1. Copy the `Ord.sublime-syntax` file into your Sublime Text Packages directory:

   - **Linux:** `~/.config/sublime-text/Packages/User/`
   - **macOS:** `~/Library/Application Support/Sublime Text/Packages/User/`
   - **Windows:** `%APPDATA%\Sublime Text\Packages\User\`

   Alternatively, create a dedicated `Ord` package directory:

   - **Linux:** `~/.config/sublime-text/Packages/Ord/`
   - **macOS:** `~/Library/Application Support/Sublime Text/Packages/Ord/`
   - **Windows:** `%APPDATA%\Sublime Text\Packages\Ord\`

2. Restart Sublime Text.

3. Open any `.ord` file -- it should automatically use ORD syntax highlighting.

### Via Menu

You can also install by navigating to:
**Preferences > Browse Packages...** which opens the Packages directory. Create an `Ord/` folder there and copy `Ord.sublime-syntax` into it.

## Verification

After installation, open a `.ord` file. You should see "Ord" displayed in the bottom-right corner of the Sublime Text status bar, indicating the ORD syntax is active.

If it doesn't activate automatically, click the syntax selector in the bottom-right corner and choose **Ord** from the list.
