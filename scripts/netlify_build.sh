#!/usr/bin/env bash
set -euo pipefail

echo "➡️  Netlify build: install Flutter and build web"

FLUTTER_VERSION="${FLUTTER_VERSION:-3.35.4}"
echo "📦 Installing Flutter ${FLUTTER_VERSION}"

curl -L "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -o flutter.tar.xz
tar xf flutter.tar.xz
export PATH="$PWD/flutter/bin:$PATH"

flutter --version
flutter config --no-analytics
flutter doctor -v || true

echo "📦 flutter pub get"
flutter pub get

echo "🏗️  Building Flutter Web (release)"
flutter build web --release --web-renderer html

echo "✅ Build completed (build/web)"

