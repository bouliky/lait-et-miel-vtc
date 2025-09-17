import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/custom_card.dart';

class AdminReservationsScreen extends StatefulWidget {
  @override
  _AdminReservationsScreenState createState() => _AdminReservationsScreenState();
}

class _AdminReservationsScreenState extends State<AdminReservationsScreen> {
  String _selectedFilter = 'Toutes';

  final List<Map<String, dynamic>> _reservations = [
    {
      'id': 'RES001',
      'client': 'Marie Dubois',
      'type': 'VTC',
      'trajet': 'Paris → Nice',
      'date': '2024-01-15',
      'heure': '14:30',
      'statut': 'Confirmée',
      'prix': '€450',
      'chauffeur': 'Jean Martin',
      'vehicule': 'Mercedes Classe E',
    },
    {
      'id': 'RES002',
      'client': 'Pierre Durand',
      'type': 'Location',
      'trajet': 'Aéroport CDG → Centre ville',
      'date': '2024-01-15',
      'heure': '16:00',
      'statut': 'En cours',
      'prix': '€120',
      'chauffeur': 'Sophie Bernard',
      'vehicule': 'BMW Série 3',
    },
    {
      'id': 'RES003',
      'client': 'Anna Schmidt',
      'type': 'VTC',
      'trajet': 'Nice → Monaco',
      'date': '2024-01-16',
      'heure': '09:00',
      'statut': 'En attente',
      'prix': '€180',
      'chauffeur': 'Marc Lefebvre',
      'vehicule': 'Audi A6',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // En-tête avec filtres
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gestion des Réservations',
                      style: AppTextStyles.headingLarge,
                    ),
                    const SizedBox(height: 16),
                    
                    // Filtres
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Toutes'),
                          const SizedBox(width: 8),
                          _buildFilterChip('Confirmées'),
                          const SizedBox(width: 8),
                          _buildFilterChip('En cours'),
                          const SizedBox(width: 8),
                          _buildFilterChip('En attente'),
                          const SizedBox(width: 8),
                          _buildFilterChip('Annulées'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Liste des réservations
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = _reservations[index];
                    return _buildReservationCard(reservation);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ajouter une nouvelle réservation
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedFilter = label);
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
    );
  }

  Widget _buildReservationCard(Map<String, dynamic> reservation) {
    Color statusColor;
    switch (reservation['statut']) {
      case 'Confirmée':
        statusColor = AppColors.success;
        break;
      case 'En cours':
        statusColor = AppColors.info;
        break;
      case 'En attente':
        statusColor = AppColors.warning;
        break;
      default:
        statusColor = AppColors.textSecondary;
    }

    return CustomCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de la carte
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  reservation['statut'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                reservation['id'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Informations principales
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reservation['client'],
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reservation['trajet'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    reservation['prix'],
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    reservation['type'],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Détails
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '${reservation['date']} à ${reservation['heure']}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.person,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                reservation['chauffeur'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showReservationDetails(reservation);
                  },
                  child: Text('Détails'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _editReservation(reservation);
                  },
                  child: Text('Modifier'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReservationDetails(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Détails de la réservation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', reservation['id']),
            _buildDetailRow('Client', reservation['client']),
            _buildDetailRow('Type', reservation['type']),
            _buildDetailRow('Trajet', reservation['trajet']),
            _buildDetailRow('Date', reservation['date']),
            _buildDetailRow('Heure', reservation['heure']),
            _buildDetailRow('Statut', reservation['statut']),
            _buildDetailRow('Prix', reservation['prix']),
            _buildDetailRow('Chauffeur', reservation['chauffeur']),
            _buildDetailRow('Véhicule', reservation['vehicule']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _editReservation(Map<String, dynamic> reservation) {
    // Implémenter l'édition de réservation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Modification de la réservation ${reservation['id']}'),
        backgroundColor: AppColors.info,
      ),
    );
  }
}
