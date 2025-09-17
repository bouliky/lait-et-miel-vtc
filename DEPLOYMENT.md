# Guide de Déploiement - Lait et Miel VTC

## Déploiement sur Netlify

### Prérequis
- Compte Netlify
- Flutter SDK installé
- Git configuré

### Étapes de déploiement

#### 1. Préparation du projet
```bash
# Installer les dépendances
flutter pub get

# Construire l'application web
flutter build web --release
```

#### 2. Configuration Firebase
1. Créer un projet Firebase sur [console.firebase.google.com](https://console.firebase.google.com)
2. Activer Authentication, Firestore et Storage
3. Récupérer les clés de configuration
4. Mettre à jour `lib/firebase_options.dart` avec vos vraies clés

#### 3. Configuration des APIs
1. **Google Maps API** :
   - Aller sur [Google Cloud Console](https://console.cloud.google.com)
   - Activer l'API Maps JavaScript
   - Créer une clé API
   - Remplacer `YOUR_GOOGLE_MAPS_API_KEY` dans `web/index.html`

2. **Stripe** :
   - Créer un compte sur [stripe.com](https://stripe.com)
   - Récupérer les clés publiques
   - Mettre à jour `lib/services/payment_service.dart`

3. **PayPal** :
   - Créer un compte développeur sur [developer.paypal.com](https://developer.paypal.com)
   - Récupérer le Client ID
   - Mettre à jour `lib/services/payment_service.dart`

#### 4. Déploiement sur Netlify

##### Option 1 : Déploiement manuel
1. Aller sur [netlify.com](https://netlify.com)
2. Cliquer sur "New site from Git"
3. Connecter votre repository GitHub/GitLab
4. Configurer :
   - Build command: `flutter build web --release`
   - Publish directory: `build/web`
5. Cliquer sur "Deploy site"

##### Option 2 : Déploiement via CLI
```bash
# Installer Netlify CLI
npm install -g netlify-cli

# Se connecter à Netlify
netlify login

# Déployer
netlify deploy --prod --dir=build/web
```

#### 5. Configuration des variables d'environnement
Dans Netlify Dashboard > Site settings > Environment variables :
```
FIREBASE_API_KEY=votre_clé_firebase
FIREBASE_AUTH_DOMAIN=votre_domaine_firebase
FIREBASE_PROJECT_ID=votre_projet_id
STRIPE_PUBLISHABLE_KEY=votre_clé_stripe
PAYPAL_CLIENT_ID=votre_client_id_paypal
GOOGLE_MAPS_API_KEY=votre_clé_google_maps
```

#### 6. Configuration du domaine personnalisé
1. Aller dans Site settings > Domain management
2. Ajouter votre domaine personnalisé
3. Configurer les DNS selon les instructions Netlify

### Optimisations SEO

#### 1. Google Search Console
1. Ajouter votre site à [Google Search Console](https://search.google.com/search-console)
2. Soumettre le sitemap : `https://votre-domaine.com/sitemap.xml`

#### 2. Google Analytics
1. Créer un compte sur [analytics.google.com](https://analytics.google.com)
2. Récupérer l'ID de mesure
3. Remplacer `GA_MEASUREMENT_ID` dans `web/index.html`

#### 3. Optimisations supplémentaires
- Ajouter des données structurées JSON-LD
- Optimiser les images (WebP, compression)
- Configurer le cache des navigateurs
- Activer la compression gzip

### Monitoring et Maintenance

#### 1. Surveillance des performances
- Utiliser Netlify Analytics
- Configurer des alertes sur les erreurs
- Monitorer les temps de chargement

#### 2. Mises à jour
- Déployer automatiquement depuis la branche main
- Tester en local avant déploiement
- Sauvegarder les données importantes

#### 3. Sécurité
- Activer HTTPS (automatique sur Netlify)
- Configurer les headers de sécurité
- Surveiller les tentatives d'intrusion

### Commandes utiles

```bash
# Développement local
flutter run -d chrome

# Test de production local
flutter build web --release
cd build/web
python -m http.server 8000

# Vérification des performances
flutter build web --release --web-renderer html
```

### Support et Documentation

- [Documentation Flutter Web](https://flutter.dev/web)
- [Documentation Netlify](https://docs.netlify.com)
- [Documentation Firebase](https://firebase.google.com/docs)
- [Documentation Stripe](https://stripe.com/docs)
- [Documentation PayPal](https://developer.paypal.com/docs)

### Contact
Pour toute question technique, contactez l'équipe de développement.
