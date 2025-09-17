import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/custom_card.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  @override
  _AdminAnalyticsScreenState createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  String _selectedPeriod = 'Ce mois';

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
                // En-tête avec sélecteur de période
                Row(
                  children: [
                    Text(
                      'Analyses & Rapports',
                      style: AppTextStyles.headingLarge,
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: _selectedPeriod,
                      onChanged: (String? newValue) {
                        setState(() => _selectedPeriod = newValue!);
                      },
                      items: <String>['Cette semaine', 'Ce mois', 'Ce trimestre', 'Cette année']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Métriques principales
                _buildMainMetrics(),
                const SizedBox(height: 24),
                
                // Graphiques
                _buildChartsSection(),
                const SizedBox(height: 24),
                
                // Top performances
                _buildTopPerformances(),
                const SizedBox(height: 24),
                
                // Rapports détaillés
                _buildDetailedReports(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Métriques principales',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Revenus',
                '€12,450',
                '+15%',
                AppColors.success,
                Icons.euro,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                'Réservations',
                '89',
                '+8%',
                AppColors.primary,
                Icons.book_online,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Clients',
                '156',
                '+12%',
                AppColors.info,
                Icons.person,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                'Satisfaction',
                '4.8/5',
                '+0.2',
                AppColors.accent,
                Icons.star,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String change, Color color, IconData icon) {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  change,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Évolution des revenus',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        CustomCard(
          child: Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48,
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Graphique des revenus',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'Intégration avec une bibliothèque de graphiques',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopPerformances() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top performances',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        CustomCard(
          child: Column(
            children: [
              _buildPerformanceItem(
                'Chauffeur le plus actif',
                'Jean Martin',
                '24 trajets',
                AppColors.primary,
                Icons.person,
              ),
              const Divider(),
              _buildPerformanceItem(
                'Véhicule le plus utilisé',
                'Mercedes Classe E',
                '18 réservations',
                AppColors.success,
                Icons.directions_car,
              ),
              const Divider(),
              _buildPerformanceItem(
                'Trajet le plus populaire',
                'Paris → Nice',
                '12 réservations',
                AppColors.info,
                Icons.route,
              ),
              const Divider(),
              _buildPerformanceItem(
                'Client le plus fidèle',
                'Marie Dubois',
                '8 réservations',
                AppColors.accent,
                Icons.favorite,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceItem(String category, String name, String value, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rapports détaillés',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildReportCard(
                'Rapport financier',
                'Analyse des revenus et coûts',
                Icons.account_balance_wallet,
                AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildReportCard(
                'Rapport clients',
                'Analyse de la satisfaction',
                Icons.person_outline,
                AppColors.info,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildReportCard(
                'Rapport véhicules',
                'Utilisation et maintenance',
                Icons.directions_car,
                AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildReportCard(
                'Rapport chauffeurs',
                'Performance et disponibilité',
                Icons.person,
                AppColors.accent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return CustomCard(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Génération du rapport: $title'),
            backgroundColor: color,
          ),
        );
      },
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
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
