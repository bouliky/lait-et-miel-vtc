import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class VtcScreen extends StatefulWidget {
  @override
  _VtcScreenState createState() => _VtcScreenState();
}

class _VtcScreenState extends State<VtcScreen> {
  String selectedVehicleType = 'economy';
  final TextEditingController _departController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commander un VTC'),
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
              _buildLocationInputs(),
              const SizedBox(height: 24),
              _buildVehicleSelection(),
              const SizedBox(height: 24),
              _buildPriceEstimate(),
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
              Icons.local_taxi,
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
                  'Service VTC Premium',
                  style: AppTextStyles.headingSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Réservez votre chauffeur privé en quelques clics',
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

  Widget _buildLocationInputs() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Itinéraire',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _departController,
            decoration: InputDecoration(
              labelText: 'Point de départ',
              prefixIcon: const Icon(Icons.my_location, color: AppColors.primary),
              suffixIcon: IconButton(
                icon: const Icon(Icons.gps_fixed),
                onPressed: () {
                  // Géolocalisation
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destination',
              prefixIcon: Icon(Icons.place, color: AppColors.accent),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Inverser',
                  icon: Icons.swap_vert,
                  isPrimary: false,
                  onPressed: () {
                    final temp = _departController.text;
                    _departController.text = _destinationController.text;
                    _destinationController.text = temp;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Carte',
                  icon: Icons.map,
                  isPrimary: false,
                  onPressed: () => Navigator.pushNamed(context, '/map'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_car,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Choisir votre véhicule',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildVehicleOption(
            'economy',
            'Économique',
            '1-4 passagers',
            '25€',
            Icons.directions_car,
          ),
          const SizedBox(height: 12),
          _buildVehicleOption(
            'comfort',
            'Confort',
            '1-4 passagers',
            '35€',
            Icons.local_taxi,
          ),
          const SizedBox(height: 12),
          _buildVehicleOption(
            'premium',
            'Premium',
            '1-4 passagers',
            '55€',
            Icons.airport_shuttle,
          ),
          const SizedBox(height: 12),
          _buildVehicleOption(
            'van',
            'Van',
            '1-8 passagers',
            '75€',
            Icons.rv_hookup,
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOption(
    String value,
    String title,
    String subtitle,
    String price,
    IconData icon,
  ) {
    final isSelected = selectedVehicleType == value;
    
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedVehicleType = value;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: selectedVehicleType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedVehicleType = newValue!;
                  });
                },
                activeColor: AppColors.primary,
              ),
              const SizedBox(width: 12),
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceEstimate() {
    return CustomCard(
        child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Estimation du prix',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                    Text(
                      'Prix estimé',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      'Durée: ~25 min',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Text(
                  '35€',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
          ],
        ),
      ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Réserver maintenant',
          icon: Icons.check_circle,
          isFullWidth: true,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Réservation VTC confirmée !'),
                backgroundColor: AppColors.success,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Programmer pour plus tard',
          icon: Icons.schedule,
          isPrimary: false,
          isFullWidth: true,
          onPressed: () => Navigator.pushNamed(context, '/reservation_form'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _departController.dispose();
    _destinationController.dispose();
    super.dispose();
  }
}
