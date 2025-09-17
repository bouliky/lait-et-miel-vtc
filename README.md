# Mon App Flutter

Bienvenue dans le projet Mon App Flutter ! Ce projet est une application Flutter simple qui démontre l'utilisation de différents widgets et la structure d'une application Flutter.

## Structure du projet

Le projet est organisé comme suit :

```
mon-app-flutter
├── lib
│   ├── main.dart          # Point d'entrée de l'application
│   ├── screens
│   │   └── home_screen.dart  # Écran principal de l'application
│   └── widgets
│       └── custom_widget.dart # Widget personnalisé
├── pubspec.yaml           # Configuration du projet
├── test
│   └── widget_test.dart   # Tests unitaires pour les widgets
└── README.md              # Documentation du projet
```

## Installation

Pour exécuter cette application, assurez-vous d'avoir Flutter installé sur votre machine. Vous pouvez suivre les instructions d'installation sur le site officiel de Flutter.

1. Clonez le dépôt :
   ```
   git clone https://github.com/votre-utilisateur/mon-app-flutter.git
   ```
2. Accédez au répertoire du projet :
   ```
   cd mon-app-flutter
   ```
3. Installez les dépendances :
   ```
   flutter pub get
   ```

## Exécution de l'application

Pour exécuter l'application, utilisez la commande suivante :
```
flutter run
```

## Tests

Pour exécuter les tests unitaires, utilisez la commande suivante :
```
flutter test
```

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à soumettre des demandes de tirage pour améliorer ce projet.

 Pour activer Google Maps plus tard :
Quand vous voudrez la carte interactive :
Obtenez une clé API Google Maps
Décommentez le script dans web/index.html
Changez useGoogleMaps = false en true (ligne 137 dans map_screen.dart)
Redémarrez l'application