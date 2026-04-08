# MyCatzApp

Pixel-art desktop pet cats for macOS.

![Swift](https://img.shields.io/badge/Swift-native-orange) ![macOS](https://img.shields.io/badge/macOS-14%2B-blue)

![MyCatzApp Screenshot](screenshot.jpeg)

## Project Origin

This project started as a fork of [wil-pe/CATAI](https://github.com/wil-pe/CATAI), then evolved with significant behavior, UI, and packaging changes from that point.

## Features

- **Window companion cats** — Cats perch and move on application windows
- **Multi-cat management** — Add/remove cats and manage them from Settings
- **Custom color picker** — Change each cat color from Settings with live updates
- **Random meows** — Cats occasionally display cute meow bubbles
- **Pixel art UI** — Retro-styled settings and controls
- **Menu bar control** — Quick access to Settings and Quit from the 🐱 icon
- **Retina-ready rendering** — Nearest-neighbor scaling for crisp sprites
- **Multilingual UI** — French, English, Spanish

## Animations

Each cat uses hand-drawn sprites across 8 directions:

- **Walking**
- **Eating**
- **Drinking**
- **Angry**
- **Waking up**
- **Idle / Sleeping**

## Requirements

- macOS 14+ (Apple Silicon or Intel)

## Build & Run

### Build from source

```bash
./build.sh
open MyCatzApp.app
```

### Run helper script

```bash
./run.sh
```

### Download release

Get the latest zip from [Releases](https://github.com/dragonro/MyCatzApp/releases), then:

```bash
xattr -cr MyCatzApp.app
open MyCatzApp.app
```

## Settings

Open from the menu bar icon:

- **Language** — Switch UI language with flags
- **Cats** — Add/remove cats
- **Name** — Rename each cat
- **Color** — Pick a custom cat color
- **Size** — Scale cats

## How It Works

- Native macOS app in Swift
- Transparent `NSWindow` overlays for cat rendering
- Window tracking to keep cats aligned to active windows
- Pixel tinting pipeline for palette/custom colors
- Config and memory persisted in `UserDefaults`

## Project Structure

```text
.
├── cat.swift              # Main application source
├── build.sh               # Builds MyCatzApp.app
├── run.sh                 # Build/run helper
└── cute_orange_cat/       # Sprite assets
```

## License

MIT
