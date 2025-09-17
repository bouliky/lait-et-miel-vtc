import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales inspirées du logo "Lait et Miel"
  static const Color primary = Color(0xFFD4AF37); // Or classique du logo
  static const Color secondary = Color(0xFFF5F5DC); // Beige lait
  static const Color accent = Color(0xFFB8860B); // Or foncé
  static const Color logoGold = Color(0xFFFFD700); // Or brillant
  static const Color logoCream = Color(0xFFFFF8DC); // Crème
  
  // Couleurs neutres
  static const Color background = Color(0xFFFFFDF5); // Blanc cassé
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFAF8F3);
  
  // Couleurs texte
  static const Color textPrimary = Color(0xFF2C2C2C);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Couleurs fonctionnelles
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Couleurs pour les boutons
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFFE0E0E0);
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [AppColors.background, AppColors.secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
