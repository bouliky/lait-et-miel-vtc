import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/custom_card.dart';

class AdminDriversScreen extends StatefulWidget {
  @override
  _AdminDriversScreenState createState() => _AdminDriversScreenState();
}

class _AdminDriversScreenState extends State<AdminDriversScreen> {
  final List<Map<String, dynamic>> _drivers = [
    {
      'id': 'DRV001',
      'nom': 'Jean',
      'prenom': 'Martin',
      'email': 'jean.martin@laitetmiel.com',
      'telephone': '+33 6 12 34 56 78',
      'statut': 'Actif',
      'experience': '5 ans',
      'note': '4.8',
      'vehicule': 'Mercedes Classe E',
      'permis': 'B',
      'dateEmbauche': '2019-03-15',
      'image': 'assets/images/driver.jpg',
    },
    {
      'id': 'DRV002',
      'nom': 'Sophie',
      'prenom': 'Bernard',
      'email': 'sophie.bernard@laitetmiel.com',
      'telephone': '+33 6 23 45 67 89',
      'statut': 'Actif',
      'experience': '3 ans',
      'note': '4.9',
      'vehicule': 'BMW Série 3',
      'permis': 'B',
      'dateEmbauche': '2021-06-10',
      'image': 'assets/images/driver.jpg',
    },
    {
      'id': 'DRV003',
      'nom': 'Marc',
      'prenom': 'Lefebvre',
      'email': 'marc.lefebvre@laitetmiel.com',
      'telephone': '+33 6 34 56 78 90',
      'statut': 'En congé',
      'experience': '7 ans',
      'note': '4.7',
      'vehicule': 'Audi A6',
      'permis': 'B',
      'dateEmbauche': '2017-01-20',
      'image': 'assets/images/driver.jpg',
    },
    {
      'id': 'DRV004',
      'nom': 'Claire',
      'prenom': 'Moreau',
      'email': 'claire.moreau@laitetmiel.com',
      'telephone': '+33 6 45 67 89 01',
      'statut': 'Actif',
      'experience': '2 ans',
      'note': '4.6',
      'vehicule': 'Range Rover Evoque',
      'permis': 'B',
      'dateEmbauche': '2022-09-05',
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
                      'Gestion des Chauffeurs',
                      style: AppTextStyles.headingLarge,
                    ),
                    const SizedBox(height: 16),
                    
                    // Statistiques rapides
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Total',
                            '${_drivers.length}',
                            AppColors.primary,
                            Icons.person,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Actifs',
                            '${_drivers.where((d) => d['statut'] == 'Actif').length}',
                            AppColors.success,
                            Icons.check_circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Moyenne',
                            '4.8',
                            AppColors.accent,
                            Icons.star,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Liste des chauffeurs
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _drivers.length,
                  itemBuilder: (context, index) {
                    final driver = _drivers[index];
                    return _buildDriverCard(driver);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDriverDialog();
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.person_add),
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

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    Color statusColor;
    switch (driver['statut']) {
      case 'Actif':
        statusColor = AppColors.success;
        break;
      case 'En congé':
        statusColor = AppColors.warning;
        break;
      case 'Inactif':
        statusColor = AppColors.error;
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
                  driver['statut'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                driver['id'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Photo et informations principales
          Row(
            children: [
              // Photo du chauffeur
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.surface,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    driver['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Informations du chauffeur
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${driver['prenom']} ${driver['nom']}',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      driver['vehicule'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          driver['note'],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ${driver['experience']}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Actions rapides
              Column(
                children: [
                  IconButton(
                    onPressed: () => _callDriver(driver),
                    icon: Icon(
                      Icons.phone,
                      color: AppColors.success,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _messageDriver(driver),
                    icon: Icon(
                      Icons.message,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Contact et détails
          Row(
            children: [
              Icon(
                Icons.email,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  driver['email'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Icon(
                Icons.phone,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                driver['telephone'],
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
                    _showDriverDetails(driver);
                  },
                  child: Text('Détails'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _editDriver(driver);
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

  void _callDriver(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appel vers ${driver['telephone']}'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _messageDriver(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message à ${driver['prenom']} ${driver['nom']}'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showDriverDetails(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Détails du chauffeur'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', driver['id']),
            _buildDetailRow('Nom', '${driver['prenom']} ${driver['nom']}'),
            _buildDetailRow('Email', driver['email']),
            _buildDetailRow('Téléphone', driver['telephone']),
            _buildDetailRow('Statut', driver['statut']),
            _buildDetailRow('Expérience', driver['experience']),
            _buildDetailRow('Note', driver['note']),
            _buildDetailRow('Véhicule', driver['vehicule']),
            _buildDetailRow('Permis', driver['permis']),
            _buildDetailRow('Date d\'embauche', driver['dateEmbauche']),
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

  void _editDriver(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Modification du chauffeur ${driver['id']}'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showAddDriverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ajouter un chauffeur'),
        content: Text('Fonctionnalité d\'ajout de chauffeur à implémenter'),
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
