import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String selectedCategory = 'economy';
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location de voiture'),
        backgroundColor: AppColors.primary,
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
              _buildHeader(),
              const SizedBox(height: 24),
              _buildDateSelection(),
              const SizedBox(height: 24),
              _buildVehicleCategories(),
              const SizedBox(height: 24),
              _buildFeaturedVehicles(),
              const SizedBox(height: 30),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CustomCard(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.car_rental,
              color: AppColors.textLight,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location Premium',
                  style: AppTextStyles.headingSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Voitures de luxe disponibles 24h/24',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Période de location',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  'Début',
                  startDate,
                  Icons.flight_takeoff,
                  () => _selectDate(context, true),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateField(
                  'Fin',
                  endDate,
                  Icons.flight_land,
                  () => _selectDate(context, false),
                ),
              ),
            ],
          ),
          if (startDate != null && endDate != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Durée: ${endDate!.difference(startDate!).inDays} jours',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateField(
    String label,
    DateTime? date,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  date != null
                      ? '${date.day}/${date.month}/${date.year}'
                      : 'Sélectionner',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCategories() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.category,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Catégories',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip('economy', 'Économique', Icons.directions_car),
                _buildCategoryChip('compact', 'Compacte', Icons.local_taxi),
                _buildCategoryChip('luxury', 'Luxe', Icons.airport_shuttle),
                _buildCategoryChip('suv', 'SUV', Icons.rv_hookup),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String value, String label, IconData icon) {
    final isSelected = selectedCategory == value;
    
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: FilterChip(
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = value;
          });
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.textLight : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.textLight : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildFeaturedVehicles() {
    final vehicles = [
      {
        'name': 'BMW Série 3',
        'category': 'Luxe',
        'price': '89€/jour',
        'features': ['Automatique', 'GPS', 'Climatisation'],
        'rating': 4.8,
      },
      {
        'name': 'Mercedes Classe A',
        'category': 'Compacte',
        'price': '65€/jour',
        'features': ['Automatique', 'Bluetooth', 'Sièges cuir'],
        'rating': 4.6,
      },
      {
        'name': 'Range Rover Evoque',
        'category': 'SUV',
        'price': '120€/jour',
        'features': ['4x4', 'Caméra de recul', 'Toit ouvrant'],
        'rating': 4.9,
      },
    ];

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Véhicules populaires',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...vehicles.map((vehicle) => _buildVehicleCard(vehicle)).toList(),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle['name'],
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            vehicle['category'],
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.warning,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              vehicle['rating'].toString(),
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                vehicle['price'],
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: (vehicle['features'] as List<String>)
                .map(
                  (feature) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Voir tous les véhicules',
          icon: Icons.search,
          isFullWidth: true,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Recherche de véhicules...'),
                backgroundColor: AppColors.info,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Réserver un véhicule',
          icon: Icons.event_available,
          isPrimary: false,
          isFullWidth: true,
          onPressed: () => Navigator.pushNamed(context, '/reservation_form'),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textLight,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
          }
        } else {
          if (startDate == null || picked.isAfter(startDate!)) {
            endDate = picked;
          }
        }
      });
    }
  }
}
