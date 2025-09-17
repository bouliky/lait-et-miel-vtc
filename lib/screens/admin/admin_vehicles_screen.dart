import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/custom_card.dart';

class AdminVehiclesScreen extends StatefulWidget {
  @override
  _AdminVehiclesScreenState createState() => _AdminVehiclesScreenState();
}

class _AdminVehiclesScreenState extends State<AdminVehiclesScreen> {
  final List<Map<String, dynamic>> _vehicles = [
    {
      'id': 'VH001',
      'marque': 'Mercedes-Benz',
      'modele': 'Classe E',
      'annee': '2023',
      'immatriculation': 'AB-123-CD',
      'type': 'Berline',
      'statut': 'Disponible',
      'kilometrage': '15,000 km',
      'carburant': 'Diesel',
      'prix': '€450/jour',
      'image': 'assets/images/driver.jpg',
    },
    {
      'id': 'VH002',
      'marque': 'BMW',
      'modele': 'Série 3',
      'annee': '2022',
      'immatriculation': 'EF-456-GH',
      'type': 'Berline',
      'statut': 'En service',
      'kilometrage': '28,000 km',
      'carburant': 'Essence',
      'prix': '€380/jour',
      'image': 'assets/images/driver.jpg',
    },
    {
      'id': 'VH003',
      'marque': 'Audi',
      'modele': 'A6',
      'annee': '2023',
      'immatriculation': 'IJ-789-KL',
      'type': 'Berline',
      'statut': 'Maintenance',
      'kilometrage': '12,000 km',
      'carburant': 'Hybride',
      'prix': '€420/jour',
      'image': 'assets/images/driver.jpg',
    },
    {
      'id': 'VH004',
      'marque': 'Range Rover',
      'modele': 'Evoque',
      'annee': '2022',
      'immatriculation': 'MN-012-OP',
      'type': 'SUV',
      'statut': 'Disponible',
      'kilometrage': '22,000 km',
      'carburant': 'Diesel',
      'prix': '€520/jour',
      'image': 'assets/images/driver.jpg',
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
              // En-tête
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gestion des Véhicules',
                      style: AppTextStyles.headingLarge,
                    ),
                    const SizedBox(height: 16),
                    
                    // Statistiques rapides
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Total',
                            '${_vehicles.length}',
                            AppColors.primary,
                            Icons.directions_car,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Disponibles',
                            '${_vehicles.where((v) => v['statut'] == 'Disponible').length}',
                            AppColors.success,
                            Icons.check_circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'En service',
                            '${_vehicles.where((v) => v['statut'] == 'En service').length}',
                            AppColors.info,
                            Icons.directions_car_filled,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Liste des véhicules
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = _vehicles[index];
                    return _buildVehicleCard(vehicle);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddVehicleDialog();
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return CustomCard(
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
            style: AppTextStyles.headingMedium.copyWith(
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    Color statusColor;
    switch (vehicle['statut']) {
      case 'Disponible':
        statusColor = AppColors.success;
        break;
      case 'En service':
        statusColor = AppColors.info;
        break;
      case 'Maintenance':
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
          // En-tête avec statut
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  vehicle['statut'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                vehicle['id'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Image et informations principales
          Row(
            children: [
              // Image du véhicule
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.surface,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    vehicle['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.directions_car,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Informations du véhicule
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle['marque']} ${vehicle['modele']}',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${vehicle['annee']} • ${vehicle['type']}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicle['immatriculation'],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              
              // Prix
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    vehicle['prix'],
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    vehicle['kilometrage'],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Détails techniques
          Row(
            children: [
              Icon(
                Icons.local_gas_station,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                vehicle['carburant'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.speed,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                vehicle['kilometrage'],
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
                    _showVehicleDetails(vehicle);
                  },
                  child: Text('Détails'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _editVehicle(vehicle);
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

  void _showVehicleDetails(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Détails du véhicule'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', vehicle['id']),
            _buildDetailRow('Marque', vehicle['marque']),
            _buildDetailRow('Modèle', vehicle['modele']),
            _buildDetailRow('Année', vehicle['annee']),
            _buildDetailRow('Immatriculation', vehicle['immatriculation']),
            _buildDetailRow('Type', vehicle['type']),
            _buildDetailRow('Statut', vehicle['statut']),
            _buildDetailRow('Kilométrage', vehicle['kilometrage']),
            _buildDetailRow('Carburant', vehicle['carburant']),
            _buildDetailRow('Prix', vehicle['prix']),
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
            width: 100,
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

  void _editVehicle(Map<String, dynamic> vehicle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Modification du véhicule ${vehicle['id']}'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showAddVehicleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ajouter un véhicule'),
        content: Text('Fonctionnalité d\'ajout de véhicule à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer'),
          ),
        ],
      ),
    );
  }
}
