import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/logo_widget.dart';
import 'admin_reservations_screen.dart';
import 'admin_vehicles_screen.dart';
import 'admin_drivers_screen.dart';
import 'admin_analytics_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    _DashboardHome(),
    AdminReservationsScreen(),
    AdminVehiclesScreen(),
    AdminDriversScreen(),
    AdminAnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const LogoIcon(size: 32),
            const SizedBox(width: 12),
            Text('Administration'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Réservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Véhicules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Chauffeurs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analyses',
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.backgroundGradient,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistiques principales
              _buildStatsSection(),
              const SizedBox(height: 24),
              
              // Actions rapides
              _buildQuickActions(),
              const SizedBox(height: 24),
              
              // Activité récente
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vue d\'ensemble',
          style: AppTextStyles.headingLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Réservations',
                value: '24',
                subtitle: '+12% ce mois',
                icon: Icons.book_online,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                title: 'Véhicules',
                value: '8',
                subtitle: '6 disponibles',
                icon: Icons.directions_car,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Chauffeurs',
                value: '12',
                subtitle: '10 actifs',
                icon: Icons.person,
                color: AppColors.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                title: 'Revenus',
                value: '€2,450',
                subtitle: '+8% ce mois',
                icon: Icons.euro,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.trending_up,
                color: AppColors.success,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.headingLarge.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Nouvelle réservation',
                icon: Icons.add_circle_outline,
                color: AppColors.primary,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'Ajouter véhicule',
                icon: Icons.add_box_outlined,
                color: AppColors.success,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Nouveau chauffeur',
                icon: Icons.person_add_outlined,
                color: AppColors.info,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'Rapports',
                icon: Icons.assessment_outlined,
                color: AppColors.accent,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activité récente',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        CustomCard(
          child: Column(
            children: [
              _buildActivityItem(
                icon: Icons.book_online,
                title: 'Nouvelle réservation',
                subtitle: 'Paris → Nice - 14:30',
                time: 'Il y a 5 min',
                color: AppColors.primary,
              ),
              const Divider(),
              _buildActivityItem(
                icon: Icons.check_circle,
                title: 'Réservation confirmée',
                subtitle: 'Aéroport CDG → Centre ville',
                time: 'Il y a 15 min',
                color: AppColors.success,
              ),
              const Divider(),
              _buildActivityItem(
                icon: Icons.directions_car,
                title: 'Véhicule assigné',
                subtitle: 'Mercedes Classe E - Chauffeur: Jean D.',
                time: 'Il y a 30 min',
                color: AppColors.info,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
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
          Text(
            time,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
