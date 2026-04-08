#!/bin/bash
set -e

echo "Building MyCatzApp.app..."

# Clean
rm -rf MyCatzApp.app MyCatzApp.icns MyCatzApp.iconset CATAI.app CATAI.icns CATAI.iconset

# Create icon from sprite
mkdir -p MyCatzApp.iconset
SRC=cute_orange_cat/rotations/south.png
for size in 16 32 64 128 256 512; do
    sips -z $size $size "$SRC" --out "MyCatzApp.iconset/icon_${size}x${size}.png" >/dev/null 2>&1
done
for size in 16 32 64 128 256; do
    double=$((size * 2))
    cp "MyCatzApp.iconset/icon_${double}x${double}.png" "MyCatzApp.iconset/icon_${size}x${size}@2x.png"
done
sips -z 1024 1024 "$SRC" --out "MyCatzApp.iconset/icon_512x512@2x.png" >/dev/null 2>&1
iconutil -c icns MyCatzApp.iconset -o MyCatzApp.icns
rm -rf MyCatzApp.iconset

# Create .app structure
mkdir -p MyCatzApp.app/Contents/MacOS MyCatzApp.app/Contents/Resources
cp MyCatzApp.icns MyCatzApp.app/Contents/Resources/
cp -R cute_orange_cat MyCatzApp.app/Contents/Resources/

# Info.plist
cat > MyCatzApp.app/Contents/Info.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleExecutable</key>
	<string>MyCatzApp</string>
	<key>CFBundleIdentifier</key>
	<string>com.dragonro.mycatzapp</string>
	<key>CFBundleName</key>
	<string>MyCatzApp</string>
	<key>CFBundleDisplayName</key>
	<string>MyCatzApp</string>
	<key>CFBundleVersion</key>
	<string>1.0.4</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0.4</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleIconFile</key>
	<string>MyCatzApp</string>
	<key>LSMinimumSystemVersion</key>
	<string>14.0</string>
	<key>LSUIElement</key>
	<true/>
	<key>NSHighResolutionCapable</key>
	<true/>
</dict>
</plist>
PLIST

# Compile
swiftc -O -o MyCatzApp.app/Contents/MacOS/MyCatzApp cat.swift -framework AppKit -framework Foundation

echo "✓ MyCatzApp.app built successfully!"
echo "Run: open MyCatzApp.app"
