import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Données simulées des réservations
  final List<Map<String, dynamic>> upcomingReservations = [
    {
      'id': 'RES001',
      'type': 'VTC',
      'from': 'Charles de Gaulle Terminal 2',
      'to': 'Place Vendôme, Paris',
      'date': DateTime.now().add(const Duration(days: 2)),
      'time': '14:30',
      'status': 'confirmed',
      'price': '45€',
      'vehicle': 'Mercedes Classe E',
      'driver': 'Pierre Dubois',
    },
    {
      'id': 'RES002',
      'type': 'Location',
      'vehicle': 'BMW Série 3',
      'startDate': DateTime.now().add(const Duration(days: 5)),
      'endDate': DateTime.now().add(const Duration(days: 8)),
      'location': 'Agence République',
      'status': 'confirmed',
      'price': '267€',
      'duration': '3 jours',
    },
  ];

  final List<Map<String, dynamic>> pastReservations = [
    {
      'id': 'RES003',
      'type': 'VTC',
      'from': 'Gare du Nord',
      'to': 'Aéroport Orly',
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'time': '09:15',
      'status': 'completed',
      'price': '38€',
      'rating': 5,
    },
    {
      'id': 'RES004',
      'type': 'Location',
      'vehicle': 'Peugeot 308',
      'startDate': DateTime.now().subtract(const Duration(days: 30)),
      'endDate': DateTime.now().subtract(const Duration(days: 28)),
      'status': 'completed',
      'price': '156€',
      'rating': 4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Réservations'),
        backgroundColor: AppColors.primary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.textLight,
          labelColor: AppColors.textLight,
          unselectedLabelColor: AppColors.textLight.withOpacity(0.7),
          tabs: const [
            Tab(
              icon: Icon(Icons.upcoming),
              text: 'À venir',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'Historique',
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildUpcomingTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/reservation_form'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textLight),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    if (upcomingReservations.isEmpty) {
      return _buildEmptyState(
        'Aucune réservation à venir',
        'Réservez votre prochain trajet dès maintenant',
        Icons.calendar_today,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Prochains trajets', upcomingReservations.length),
          const SizedBox(height: 16),
          ...upcomingReservations
              .map((reservation) => _buildUpcomingReservationCard(reservation))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    if (pastReservations.isEmpty) {
      return _buildEmptyState(
        'Aucun historique',
        'Vos trajets passés apparaîtront ici',
        Icons.history,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Trajets terminés', pastReservations.length),
          const SizedBox(height: 16),
          ...pastReservations
              .map((reservation) => _buildPastReservationCard(reservation))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 60,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTextStyles.headingSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Nouvelle réservation',
              icon: Icons.add,
              onPressed: () => Navigator.pushNamed(context, '/reservation_form'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.headingMedium,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingReservationCard(Map<String, dynamic> reservation) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: reservation['type'] == 'VTC'
                      ? AppColors.info.withOpacity(0.1)
                      : AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  reservation['type'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: reservation['type'] == 'VTC'
                        ? AppColors.info
                        : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                reservation['price'],
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Réservation #${reservation['id']}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          if (reservation['type'] == 'VTC') ...[
            _buildLocationRow(
              Icons.my_location,
              reservation['from'],
              AppColors.primary,
            ),
            const SizedBox(height: 8),
            _buildLocationRow(
              Icons.place,
              reservation['to'],
              AppColors.accent,
            ),
          ] else ...[
            _buildInfoRow(
              Icons.car_rental,
              'Véhicule',
              reservation['vehicle'],
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.location_on,
              'Agence',
              reservation['location'],
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                _formatDate(reservation['date'] ?? reservation['startDate']),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (reservation['time'] != null) ...[
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  reservation['time'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Modifier',
                  icon: Icons.edit,
                  isPrimary: false,
                  onPressed: () => _showEditDialog(reservation),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Annuler',
                  icon: Icons.cancel,
                  isPrimary: false,
                  onPressed: () => _showCancelDialog(reservation),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPastReservationCard(Map<String, dynamic> reservation) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Terminé',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                reservation['price'],
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Réservation #${reservation['id']}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          if (reservation['type'] == 'VTC') ...[
            _buildLocationRow(
              Icons.my_location,
              reservation['from'],
              AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            _buildLocationRow(
              Icons.place,
              reservation['to'],
              AppColors.textSecondary,
            ),
          ] else ...[
            _buildInfoRow(
              Icons.car_rental,
              'Véhicule',
              reservation['vehicle'],
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                _formatDate(reservation['date'] ?? reservation['startDate']),
                style: AppTextStyles.bodyMedium,
              ),
              const Spacer(),
              if (reservation['rating'] != null) ...[
                ...List.generate(5, (index) {
                  return Icon(
                    index < reservation['rating']
                        ? Icons.star
                        : Icons.star_border,
                    size: 16,
                    color: AppColors.warning,
                  );
                }),
              ],
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Réserver à nouveau',
            icon: Icons.refresh,
            isPrimary: false,
            isFullWidth: true,
            onPressed: () => Navigator.pushNamed(context, '/reservation_form'),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String location, Color iconColor) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            location,
            style: AppTextStyles.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showEditDialog(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier la réservation'),
        content: Text(
          'Modification de la réservation #${reservation['id']}\n\nFonctionnalité en cours de développement.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Annuler la réservation'),
        content: Text(
          'Êtes-vous sûr de vouloir annuler la réservation #${reservation['id']} ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Réservation annulée avec succès'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Oui, annuler'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
