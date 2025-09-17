import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  
  // Position par défaut (Paris)
  static const LatLng _initialPosition = LatLng(48.8566, 2.3522);
  
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  
  LatLng? selectedLocation;
  bool isSearchMode = false;
  final TextEditingController _searchController = TextEditingController();

  // Données simulées des véhicules disponibles
  final List<Map<String, dynamic>> nearbyVehicles = [
    {
      'id': 'V001',
      'driver': 'Pierre Martin',
      'rating': 4.8,
      'eta': '3 min',
      'position': const LatLng(48.8556, 2.3522),
      'type': 'Économique',
      'price': '25€',
    },
    {
      'id': 'V002',
      'driver': 'Sophie Dubois',
      'rating': 4.9,
      'eta': '5 min',
      'position': const LatLng(48.8576, 2.3500),
      'type': 'Premium',
      'price': '35€',
    },
    {
      'id': 'V003',
      'driver': 'Marc Lefebvre',
      'rating': 4.7,
      'eta': '7 min',
      'position': const LatLng(48.8540, 2.3550),
      'type': 'Confort',
      'price': '30€',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    // Ajouter les marqueurs des véhicules disponibles
    for (var vehicle in nearbyVehicles) {
      _markers.add(
        Marker(
          markerId: MarkerId(vehicle['id']),
          position: vehicle['position'],
          infoWindow: InfoWindow(
            title: vehicle['driver'],
            snippet: '${vehicle['type']} - ${vehicle['eta']} - ${vehicle['price']}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _getMarkerColor(vehicle['type']),
          ),
          onTap: () => _showVehicleDetails(vehicle),
        ),
      );
    }
  }

  double _getMarkerColor(String type) {
    switch (type) {
      case 'Économique':
        return BitmapDescriptor.hueGreen;
      case 'Premium':
        return BitmapDescriptor.hueBlue;
      case 'Confort':
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: Icon(isSearchMode ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearchMode = !isSearchMode;
                if (!isSearchMode) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Carte Google Maps avec gestion d'erreur
          _buildMapWidget(),
          
          // Barre de recherche
          if (isSearchMode) _buildSearchBar(),
          
          // Panneau d'informations en bas
          _buildBottomPanel(),
          
          // Boutons d'action flottants
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  Widget _buildMapWidget() {
    // Pour l'instant, utilisons toujours le fallback pour éviter les erreurs Google Maps
    // Changez cette condition à true quand vous avez configuré votre clé API
    bool useGoogleMaps = false;
    
    if (useGoogleMaps) {
      try {
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: const CameraPosition(
            target: _initialPosition,
            zoom: 14,
          ),
          markers: _markers,
          polylines: _polylines,
          onTap: (LatLng position) {
            if (isSearchMode) {
              _onMapTapped(position);
            }
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          trafficEnabled: true,
          buildingsEnabled: true,
        );
      } catch (e) {
        return _buildMapFallback();
      }
    } else {
      return _buildMapFallback();
    }
  }

  Widget _buildMapFallback() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.backgroundGradient,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            CustomCard(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 50,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Mode Carte Simplifiée',
                    style: AppTextStyles.headingMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Localisation: Paris, France',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Zone de service: Île-de-France',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Réserver VTC',
                          icon: Icons.local_taxi,
                          onPressed: () => Navigator.pushNamed(context, '/vtc'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Louer voiture',
                          icon: Icons.car_rental,
                          isPrimary: false,
                          onPressed: () => Navigator.pushNamed(context, '/location'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppColors.info,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Carte Interactive Disponible',
                        style: AppTextStyles.headingSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Pour activer la carte Google Maps interactive avec localisation des véhicules en temps réel :',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  _buildConfigStep('1', 'Obtenez une clé API Google Maps'),
                  _buildConfigStep('2', 'Décommentez le script dans web/index.html'),
                  _buildConfigStep('3', 'Changez useGoogleMaps à true'),
                  _buildConfigStep('4', 'Redémarrez l\'application'),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Guide détaillé',
                    icon: Icons.help,
                    isPrimary: false,
                    isFullWidth: true,
                    onPressed: () => _showMapConfigDialog(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: CustomCard(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Rechercher une adresse...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: AppColors.primary),
              suffixIcon: Icon(Icons.mic, color: AppColors.textSecondary),
            ),
            onSubmitted: (value) => _searchLocation(value),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Véhicules à proximité',
                        style: AppTextStyles.headingSmall,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${nearbyVehicles.length}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyVehicles.length,
                      itemBuilder: (context, index) {
                        return _buildVehicleCard(nearbyVehicles[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Ma position',
                          icon: Icons.my_location,
                          isPrimary: false,
                          onPressed: _goToCurrentLocation,
                        ),
                      ),
                      const SizedBox(width: 12),
          Expanded(
                        child: CustomButton(
                          text: 'Réserver',
                          icon: Icons.local_taxi,
                          onPressed: () => Navigator.pushNamed(context, '/vtc'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      child: CustomCard(
        padding: const EdgeInsets.all(12),
        onTap: () => _showVehicleDetails(vehicle),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getVehicleTypeColor(vehicle['type']),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  vehicle['type'],
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  vehicle['price'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              vehicle['driver'],
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 14,
                  color: AppColors.warning,
                ),
                const SizedBox(width: 4),
                Text(
                  vehicle['rating'].toString(),
                  style: AppTextStyles.bodySmall,
                ),
                const Spacer(),
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppColors.info,
                ),
                const SizedBox(width: 4),
                Text(
                  vehicle['eta'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.info,
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

  Widget _buildFloatingButtons() {
    return Positioned(
      right: 16,
      top: 100,
      child: Column(
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "zoom_in",
            backgroundColor: AppColors.surface,
            onPressed: _zoomIn,
            child: const Icon(Icons.zoom_in, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "zoom_out",
            backgroundColor: AppColors.surface,
            onPressed: _zoomOut,
            child: const Icon(Icons.zoom_out, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "traffic",
            backgroundColor: AppColors.surface,
            onPressed: _toggleTraffic,
            child: const Icon(Icons.traffic, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Color _getVehicleTypeColor(String type) {
    switch (type) {
      case 'Économique':
        return AppColors.success;
      case 'Premium':
        return AppColors.info;
      case 'Confort':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      selectedLocation = position;
      _markers.removeWhere((marker) => marker.markerId.value == 'selected');
      _markers.add(
        Marker(
          markerId: const MarkerId('selected'),
          position: position,
          infoWindow: const InfoWindow(title: 'Position sélectionnée'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  void _searchLocation(String query) {
    // Simulation de recherche - dans une vraie app, utilisez l'API Google Places
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recherche: $query'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _goToCurrentLocation() {
    try {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_initialPosition, 16),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fonction de géolocalisation non disponible'),
          backgroundColor: AppColors.warning,
        ),
      );
    }
  }

  void _zoomIn() {
    try {
      mapController.animateCamera(CameraUpdate.zoomIn());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Zoom non disponible'),
          backgroundColor: AppColors.warning,
        ),
      );
    }
  }

  void _zoomOut() {
    try {
      mapController.animateCamera(CameraUpdate.zoomOut());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Zoom non disponible'),
          backgroundColor: AppColors.warning,
        ),
      );
    }
  }

  void _showMapConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.map,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),
            const Text('Configuration Google Maps'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Étapes pour activer la carte interactive :',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildDialogStep('1', 'Créer un projet Google Cloud'),
              _buildDialogStep('2', 'Activer l\'API "Maps JavaScript API"'),
              _buildDialogStep('3', 'Créer une clé API'),
              _buildDialogStep('4', 'Dans web/index.html, décommenter et remplacer\n"YOUR_API_KEY_HERE" par votre clé'),
              _buildDialogStep('5', 'Dans map_screen.dart, changer\n"useGoogleMaps = false" en "true"'),
              _buildDialogStep('6', 'Redémarrer l\'application'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'L\'application fonctionne parfaitement sans Google Maps !',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Compris',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleTraffic() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Circulation activée/désactivée'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showVehicleDetails(Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
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
                        vehicle['driver'],
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
                            '${vehicle['rating']} / 5.0',
                            style: AppTextStyles.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getVehicleTypeColor(vehicle['type']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              vehicle['type'],
                              style: AppTextStyles.bodySmall.copyWith(
                                color: _getVehicleTypeColor(vehicle['type']),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildDetailItem(Icons.access_time, 'Arrivée', vehicle['eta']),
                const SizedBox(width: 24),
                _buildDetailItem(Icons.euro, 'Prix estimé', vehicle['price']),
              ],
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Réserver ce véhicule',
              icon: Icons.check_circle,
              isFullWidth: true,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/vtc');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
