# MyCatzApp Agent Context

## Current State

- Current branch: `release-1.0.6`
- App version: `1.0.6`
- Main source file: `cat.swift`
- Build script: `build.sh`
- Generated bundle: `MyCatzApp.app`
- Current working tree has uncommitted changes for:
  - Start-at-login setting
  - Version bump from `1.0.5` to `1.0.6`
  - README settings documentation

## Project Summary

MyCatzApp is a native macOS AppKit menu bar app. It renders pixel-art desktop cats as transparent overlay windows. Cats can move around active windows, sit on the Dock, meow, sleep, and be customized from a small pixel-styled settings window.

The project is intentionally minimal:

- Single Swift source file: `cat.swift`
- Shell build script: `build.sh`
- Sprite assets under `cute_orange_cat/`
- No Xcode project currently used

## Build And Run

Build:

```bash
./build.sh
```

Run:

```bash
open MyCatzApp.app
```

If an older instance is already running, quit it from the menu bar item before testing a rebuilt bundle.

## Important Implementation Details

### App Lifecycle

- Entry point is at the bottom of `cat.swift`.
- `CatAppDelegate.applicationDidFinishLaunching` loads assets, preferences, cat configs, status item, event monitors, and timers.
- The app uses accessory activation policy and `LSUIElement` in `Info.plist`, so it behaves as a menu bar/background app.

### Settings Window

- Settings are managed by `SettingsWindowController`.
- The settings UI is manually built in `buildContent()`.
- Controls are custom pixel-styled AppKit views, not SwiftUI.
- Settings currently include:
  - Language
  - Cats
  - Cat name
  - Custom color
  - Size
  - Start at login

### Persistence

Uses `UserDefaults.standard`.

Known keys:

- `catConfigs`
- `catScale`
- `ollamaModel`
- `catLang`
- `startAtLogin`

### Start At Login

Start-at-login support was added using `ServiceManagement.SMAppService.mainApp`.

Relevant code:

- `import ServiceManagement`
- `LoginItemState`
- `loginItemState()`
- `setStartAtLogin(_:)`
- `CatAppDelegate.setStartAtLoginPreference(_:)`
- `SettingsWindowController` checkbox wiring
- `PixelCheckbox`

This is the correct production path for modern macOS login items. Avoid legacy LaunchAgent plist hacks unless there is a specific compatibility requirement.

Important macOS behavior:

- This starts the app at user login, not before login at machine boot.
- macOS may return `requiresApproval`; the app displays a message telling the user to approve it in System Settings.
- The feature may behave differently when running unsigned/local builds versus a signed production release.

### PixelCheckbox Note

The first implementation used `NSView`, which did not reliably respond to clicks. It was changed to `NSControl` with:

- `acceptsFirstResponder`
- `acceptsFirstMouse(for:)`
- `mouseDown(with:)` toggling state and invoking the callback

If the checkbox appears inert, first confirm the rebuilt app is actually running.

## Versioning

Current version references:

- `cat.swift`: `APP_VERSION = "1.0.6"`
- `build.sh`: generated `CFBundleVersion`
- `build.sh`: generated `CFBundleShortVersionString`
- `MyCatzApp.app/Contents/Info.plist`: generated during build

When bumping versions, update `cat.swift` and the `build.sh` plist template, then run `./build.sh`.

## Validation Performed

The following validation has been run successfully:

```bash
./build.sh
```

Generated bundle values verified:

- `CFBundleShortVersionString = 1.0.6`
- `CFBundleVersion = 1.0.6`

## Recommended Next Steps

1. Run `open MyCatzApp.app`.
2. Open Settings from the menu bar cat icon.
3. Toggle `Start at login`.
4. Check macOS System Settings if approval is requested.
5. Commit the current changes when functionality is confirmed.

## Useful Commands

Check branch and working tree:

```bash
git status --short --branch
```

Find version references:

```bash
rg -n "1\\.0\\.6|APP_VERSION|CFBundleVersion|CFBundleShortVersionString" cat.swift build.sh MyCatzApp.app/Contents/Info.plist
```

Verify generated plist:

```bash
/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' MyCatzApp.app/Contents/Info.plist
/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' MyCatzApp.app/Contents/Info.plist
```

## Cautions

- Do not commit generated zip files unless the release process explicitly requires them.
- `build.sh` removes and recreates `MyCatzApp.app`.
- Keep changes surgical; this project has a compact single-file structure.
- Do not introduce SwiftUI or an Xcode project unless explicitly requested.
