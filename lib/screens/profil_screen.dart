import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  // Données utilisateur simulées
  final Map<String, dynamic> userProfile = {
    'name': 'Jean Dupont',
    'email': 'jean.dupont@email.com',
    'phone': '+33 6 12 34 56 78',
    'memberSince': '2023',
    'totalTrips': 42,
    'favoriteDest': 'Aéroport Charles de Gaulle',
    'rating': 4.8,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildProfileInfo(),
              const SizedBox(height: 24),
              _buildStatsSection(),
              const SizedBox(height: 24),
              _buildPreferencesSection(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return CustomCard(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.textLight,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surface,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.verified,
                    size: 16,
                    color: AppColors.textLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            userProfile['name'],
            style: AppTextStyles.headingMedium,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: AppColors.warning,
                ),
                const SizedBox(width: 4),
                Text(
                  '${userProfile['rating']} / 5.0',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Membre depuis ${userProfile['memberSince']}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Informations personnelles',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.email, 'Email', userProfile['email']),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone, 'Téléphone', userProfile['phone']),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.location_on, 'Destination préférée', userProfile['favoriteDest']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Statistiques',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Trajets effectués',
                  '${userProfile['totalTrips']}',
                  Icons.drive_eta,
                  AppColors.info,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Note moyenne',
                  '${userProfile['rating']}/5',
                  Icons.star,
                  AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Économies',
                  '127€',
                  Icons.savings,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Points fidélité',
                  '1,250',
                  Icons.loyalty,
                  AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headingSmall.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Préférences',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPreferenceRow(
            'Notifications',
            'Recevoir les alertes de voyage',
            true,
            Icons.notifications,
          ),
          const SizedBox(height: 12),
          _buildPreferenceRow(
            'Mode sombre',
            'Interface en mode sombre',
            false,
            Icons.dark_mode,
          ),
          const SizedBox(height: 12),
          _buildPreferenceRow(
            'Géolocalisation',
            'Détecter automatiquement ma position',
            true,
            Icons.location_on,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceRow(
    String title,
    String subtitle,
    bool value,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            // Gérer le changement de préférence
          },
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Modifier le profil',
          icon: Icons.edit,
          isFullWidth: true,
          onPressed: () => _showEditDialog(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Historique',
                icon: Icons.history,
                isPrimary: false,
                onPressed: () => Navigator.pushNamed(context, '/reservation'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Support',
                icon: Icons.help,
                isPrimary: false,
                onPressed: () => _showSupportDialog(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Déconnexion',
          icon: Icons.logout,
          isPrimary: false,
          isFullWidth: true,
          onPressed: () => _showLogoutDialog(),
        ),
      ],
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le profil'),
        content: const Text('Fonctionnalité en cours de développement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Support client'),
        content: const Text('Email: support@laitetmiel.fr\nTéléphone: +33 1 23 45 67 89'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Déconnexion réussie'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}
