import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/logo_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête avec logo et titre
                _buildHeader(),
                const SizedBox(height: 30),
                
                // Message de bienvenue
                _buildWelcomeSection(),
                const SizedBox(height: 30),
                
                // Services principaux
                _buildMainServices(context),
                const SizedBox(height: 30),
                
                // Services supplémentaires
                _buildAdditionalServices(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const LogoWidget(
              width: 180,
              height: 80,
              showText: false,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Lait et Miel',
            style: AppTextStyles.headingLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Transport de luxe à votre service',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.waving_hand,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Bienvenue !',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Découvrez nos services de transport premium. Que vous souhaitiez réserver un VTC ou louer une voiture, nous avons la solution parfaite pour vous.',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildMainServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nos Services',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                icon: Icons.local_taxi,
                title: 'VTC Premium',
                subtitle: 'Transport avec chauffeur',
                onTap: () => Navigator.pushNamed(context, '/vtc'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildServiceCard(
                icon: Icons.car_rental,
                title: 'Location',
                subtitle: 'Voitures de luxe',
                onTap: () => Navigator.pushNamed(context, '/location'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: AppColors.textLight,
              size: 30,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.headingSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions Rapides',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Réserver un trajet',
          icon: Icons.book_online,
          isFullWidth: true,
          onPressed: () => Navigator.pushNamed(context, '/reservation_form'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Mon Profil',
                icon: Icons.person,
                isPrimary: false,
                onPressed: () => Navigator.pushNamed(context, '/profil'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Espace Chauffeur',
                icon: Icons.drive_eta,
                isPrimary: false,
                onPressed: () => Navigator.pushNamed(context, '/driver'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Administration',
          icon: Icons.admin_panel_settings,
          isPrimary: false,
          onPressed: () => Navigator.pushNamed(context, '/admin'),
        ),
      ],
    );
  }
}
