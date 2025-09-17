import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class DriverScreen extends StatefulWidget {
  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isOnline = false;

  // Données simulées du chauffeur
  final Map<String, dynamic> driverProfile = {
    'name': 'Marc Lefebvre',
    'rating': 4.9,
    'totalRides': 1247,
    'todayEarnings': '187€',
    'monthlyEarnings': '3,420€',
    'vehicleModel': 'Mercedes Classe E',
    'licensePlate': 'AB-123-CD',
  };

  final List<Map<String, dynamic>> todayRides = [
    {
      'id': 'RIDE001',
      'passenger': 'Sophie Martin',
      'from': 'Gare de Lyon',
      'to': 'Aéroport Charles de Gaulle',
      'time': '09:30',
      'status': 'completed',
      'price': '45€',
      'rating': 5,
    },
    {
      'id': 'RIDE002',
      'passenger': 'Jean Dupont',
      'from': 'Place de la République',
      'to': 'La Défense',
      'time': '14:15',
      'status': 'in_progress',
      'price': '28€',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Chauffeur'),
        backgroundColor: AppColors.primary,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Switch(
              value: isOnline,
              onChanged: (value) {
                setState(() {
                  isOnline = value;
                });
                _showStatusDialog(value);
              },
              activeColor: AppColors.success,
              activeTrackColor: AppColors.success.withOpacity(0.3),
              inactiveThumbColor: AppColors.textSecondary,
              inactiveTrackColor: AppColors.textSecondary.withOpacity(0.3),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.textLight,
          labelColor: AppColors.textLight,
          unselectedLabelColor: AppColors.textLight.withOpacity(0.7),
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Tableau de bord'),
            Tab(icon: Icon(Icons.drive_eta), text: 'Mes courses'),
            Tab(icon: Icon(Icons.person), text: 'Profil'),
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
            _buildDashboardTab(),
            _buildRidesTab(),
            _buildProfileTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 24),
          _buildStatusCard(),
          const SizedBox(height: 24),
          _buildEarningsSection(),
          const SizedBox(height: 24),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
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
              Icons.person,
              color: AppColors.textLight,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bonjour ${driverProfile['name']} !',
                  style: AppTextStyles.headingSmall,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.warning,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${driverProfile['rating']} / 5.0',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${driverProfile['totalRides']} courses',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return CustomCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.success : AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isOnline ? 'En ligne' : 'Hors ligne',
                style: AppTextStyles.headingSmall.copyWith(
                  color: isOnline ? AppColors.success : AppColors.error,
                ),
              ),
              const Spacer(),
              Switch(
                value: isOnline,
                onChanged: (value) {
                  setState(() {
                    isOnline = value;
                  });
                },
                activeColor: AppColors.success,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isOnline
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isOnline ? Icons.check_circle : Icons.pause_circle,
                  color: isOnline ? AppColors.success : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isOnline
                        ? 'Vous êtes disponible pour recevoir des courses'
                        : 'Activez le mode en ligne pour recevoir des courses',
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mes gains',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildEarningCard(
                'Aujourd\'hui',
                driverProfile['todayEarnings'],
                Icons.today,
                AppColors.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildEarningCard(
                'Ce mois',
                driverProfile['monthlyEarnings'],
                Icons.calendar_month,
                AppColors.success,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEarningCard(String title, String amount, IconData icon, Color color) {
    return CustomCard(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            amount,
            style: AppTextStyles.headingMedium.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions rapides',
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Historique',
                icon: Icons.history,
                isPrimary: false,
                onPressed: () => _showHistoryDialog(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Support',
                icon: Icons.help,
                isPrimary: false,
                onPressed: () => _showSupportDialog(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRidesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Courses d\'aujourd\'hui',
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
                  '${todayRides.length}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...todayRides.map((ride) => _buildRideCard(ride)).toList(),
        ],
      ),
    );
  }

  Widget _buildRideCard(Map<String, dynamic> ride) {
    final isCompleted = ride['status'] == 'completed';
    
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
                  color: isCompleted
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isCompleted ? 'Terminée' : 'En cours',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isCompleted ? AppColors.success : AppColors.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                ride['price'],
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                ride['passenger'],
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.my_location,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ride['from'],
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.place,
                size: 16,
                color: AppColors.accent,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ride['to'],
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                ride['time'],
                style: AppTextStyles.bodyMedium,
              ),
              if (isCompleted && ride['rating'] != null) ...[
                const Spacer(),
                ...List.generate(5, (index) {
                  return Icon(
                    index < ride['rating']
                        ? Icons.star
                        : Icons.star_border,
                    size: 16,
                    color: AppColors.warning,
                  );
                }),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDriverInfo(),
          const SizedBox(height: 24),
          _buildVehicleInfo(),
          const SizedBox(height: 24),
          _buildProfileActions(),
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Informations chauffeur',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Nom', driverProfile['name']),
          const SizedBox(height: 12),
          _buildInfoRow('Note moyenne', '${driverProfile['rating']} / 5.0'),
          const SizedBox(height: 12),
          _buildInfoRow('Courses totales', driverProfile['totalRides'].toString()),
        ],
      ),
    );
  }

  Widget _buildVehicleInfo() {
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
                'Véhicule',
                style: AppTextStyles.headingSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Modèle', driverProfile['vehicleModel']),
          const SizedBox(height: 12),
          _buildInfoRow('Plaque d\'immatriculation', driverProfile['licensePlate']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
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
          ),
        ),
      ],
    );
  }

  Widget _buildProfileActions() {
    return Column(
      children: [
        CustomButton(
          text: 'Modifier le profil',
          icon: Icons.edit,
          isFullWidth: true,
          onPressed: () => _showEditProfileDialog(),
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Paramètres',
          icon: Icons.settings,
          isPrimary: false,
          isFullWidth: true,
          onPressed: () => _showSettingsDialog(),
        ),
      ],
    );
  }

  void _showStatusDialog(bool isOnline) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isOnline ? 'Vous êtes maintenant en ligne' : 'Vous êtes maintenant hors ligne',
        ),
        backgroundColor: isOnline ? AppColors.success : AppColors.info,
      ),
    );
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historique des courses'),
        content: const Text('Fonctionnalité en cours de développement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Support chauffeur'),
        content: const Text('Email: support-chauffeur@laitetmiel.fr\nTéléphone: +33 1 23 45 67 89'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le profil'),
        content: const Text('Fonctionnalité en cours de développement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Paramètres'),
        content: const Text('Fonctionnalité en cours de développement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
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
