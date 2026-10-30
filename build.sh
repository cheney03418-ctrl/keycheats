#!/bin/zsh
# 构建并安装 快捷键速查.app（原生 Swift，无第三方依赖）
# 用法：./build.sh          构建 + 安装到 ~/Applications 并重启
#      ./build.sh --build  只构建，不安装
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"
APP="$ROOT/build/快捷键速查.app"
DEST="$HOME/Applications/快捷键速查.app"

rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

swiftc -O -swift-version 5 \
  -target arm64-apple-macos13.0 \
  -framework AppKit -framework Carbon \
  -o "$APP/Contents/MacOS/KeyCheats" \
  "$ROOT/main.swift"

cp "$ROOT/Info.plist" "$APP/Contents/Info.plist"
cp "$ROOT/AppIcon.icns" "$APP/Contents/Resources/AppIcon.icns"
codesign --force --sign - "$APP" >/dev/null 2>&1 || true
echo "built: $APP  ($(du -sh "$APP" | cut -f1))"

if [[ "$1" != "--build" ]]; then
  pkill -f "快捷键速查.app/Contents/MacOS/KeyCheats" 2>/dev/null || true
  sleep 0.5
  mkdir -p "$HOME/Applications"
  rm -rf "$DEST"
  cp -R "$APP" "$DEST"
  open "$DEST"
  echo "installed & relaunched: $DEST"
fi
