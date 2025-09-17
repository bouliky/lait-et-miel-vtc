import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class ReservationFormScreen extends StatefulWidget {
  @override
  _ReservationFormScreenState createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _departController = TextEditingController();
  final _destinationController = TextEditingController();
  final _noteController = TextEditingController();
  
  String serviceType = 'vtc';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int passengers = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réserver un trajet'),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildServiceSelection(),
                const SizedBox(height: 24),
                _buildLocationFields(),
                const SizedBox(height: 24),
                _buildDateTimeSelection(),
                const SizedBox(height: 24),
                _buildPassengerSelection(),
                const SizedBox(height: 24),
                _buildAdditionalNotes(),
                const SizedBox(height: 30),
                _buildSubmitButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CustomCard(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.book_online,
              color: AppColors.textLight,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Réservation de trajet',
            style: AppTextStyles.headingMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Planifiez votre voyage à l\'avance',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSelection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.build,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Type de service',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildServiceOption(
                  'vtc',
                  'VTC',
                  'Avec chauffeur',
                  Icons.local_taxi,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildServiceOption(
                  'location',
                  'Location',
                  'Voiture seule',
                  Icons.car_rental,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOption(
    String value,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = serviceType == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          serviceType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationFields() {
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
          TextFormField(
            controller: _departController,
            decoration: const InputDecoration(
              labelText: 'Point de départ',
              prefixIcon: Icon(Icons.my_location, color: AppColors.primary),
              hintText: 'Adresse de départ',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Le point de départ est requis';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destination',
              prefixIcon: Icon(Icons.place, color: AppColors.accent),
              hintText: 'Adresse de destination',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'La destination est requise';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Voir sur la carte',
            icon: Icons.map,
            isPrimary: false,
            isFullWidth: true,
            onPressed: () => Navigator.pushNamed(context, '/map'),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Date et heure',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDateField(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimeField(),
              ),
            ],
          ),
          if (selectedDate != null && selectedTime != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Réservation programmée',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.success,
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

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () => _selectDate(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Date',
                  style: AppTextStyles.label,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'Sélectionner une date',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField() {
    return GestureDetector(
      onTap: () => _selectTime(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Heure',
                  style: AppTextStyles.label,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              selectedTime != null
                  ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                  : 'Sélectionner l\'heure',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerSelection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Nombre de passagers',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: passengers > 1
                    ? () {
                        setState(() {
                          passengers--;
                        });
                      }
                    : null,
                icon: Icon(
                  Icons.remove_circle,
                  color: passengers > 1 ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  passengers.toString(),
                  style: AppTextStyles.headingSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              IconButton(
                onPressed: passengers < 8
                    ? () {
                        setState(() {
                          passengers++;
                        });
                      }
                    : null,
                icon: Icon(
                  Icons.add_circle,
                  color: passengers < 8 ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                passengers == 1 ? '1 passager' : '$passengers passagers',
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalNotes() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note_add,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Notes supplémentaires',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Informations complémentaires, préférences...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      text: isLoading ? 'Réservation en cours...' : 'Confirmer la réservation',
      icon: isLoading ? null : Icons.check_circle,
      isFullWidth: true,
      isLoading: isLoading,
      onPressed: isLoading ? null : _submitReservation,
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
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
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
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
        selectedTime = picked;
      });
    }
  }

  Future<void> _submitReservation() async {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null || selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner la date et l\'heure'),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      // Simulation d'une requête
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Réservation confirmée ! Un email de confirmation vous sera envoyé.'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 4),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _departController.dispose();
    _destinationController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
