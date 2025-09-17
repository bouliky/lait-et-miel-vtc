#!/bin/bash

# Script de build pour Lait et Miel VTC
# Usage: ./scripts/build.sh [--release|--debug]

set -e

echo "🚀 Démarrage du build Lait et Miel VTC..."

# Vérifier que Flutter est installé
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter n'est pas installé. Veuillez installer Flutter d'abord."
    exit 1
fi

# Vérifier la version de Flutter
echo "📱 Version de Flutter: $(flutter --version | head -n 1)"

# Nettoyer le cache
echo "🧹 Nettoyage du cache..."
flutter clean

# Récupérer les dépendances
echo "📦 Récupération des dépendances..."
flutter pub get

# Analyser le code
echo "🔍 Analyse du code..."
flutter analyze

# Exécuter les tests
echo "🧪 Exécution des tests..."
flutter test

# Build selon l'argument
if [ "$1" = "--release" ]; then
    echo "🏗️ Build de production..."
    flutter build web --release --web-renderer html
    echo "✅ Build de production terminé dans build/web/"
elif [ "$1" = "--debug" ]; then
    echo "🏗️ Build de debug..."
    flutter build web --debug --web-renderer html
    echo "✅ Build de debug terminé dans build/web/"
else
    echo "🏗️ Build par défaut (release)..."
    flutter build web --release --web-renderer html
    echo "✅ Build terminé dans build/web/"
fi

# Vérifier la taille du build
echo "📊 Taille du build:"
du -sh build/web/

echo "🎉 Build terminé avec succès!"
echo "📁 Fichiers générés dans: build/web/"
echo "🌐 Pour tester localement: cd build/web && python -m http.server 8000"
