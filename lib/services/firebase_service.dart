import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseFirestore? _firestore;
  static FirebaseAuth? _auth;
  static FirebaseStorage? _storage;

  static FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  static FirebaseAuth get auth {
    _auth ??= FirebaseAuth.instance;
    return _auth!;
  }

  static FirebaseStorage get storage {
    _storage ??= FirebaseStorage.instance;
    return _storage!;
  }

  // Initialisation de Firebase
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Authentification
  static Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Erreur de connexion: $e');
      return null;
    }
  }

  static Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Erreur de création de compte: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static User? get currentUser => auth.currentUser;

  // Gestion des réservations
  static Future<String?> createReservation(Map<String, dynamic> reservationData) async {
    try {
      final docRef = await firestore.collection('reservations').add({
        ...reservationData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });
      return docRef.id;
    } catch (e) {
      print('Erreur création réservation: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getReservations() async {
    try {
      final querySnapshot = await firestore
          .collection('reservations')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      print('Erreur récupération réservations: $e');
      return [];
    }
  }

  static Future<bool> updateReservation(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('reservations').doc(id).update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Erreur mise à jour réservation: $e');
      return false;
    }
  }

  static Future<bool> deleteReservation(String id) async {
    try {
      await firestore.collection('reservations').doc(id).delete();
      return true;
    } catch (e) {
      print('Erreur suppression réservation: $e');
      return false;
    }
  }

  // Gestion des véhicules
  static Future<String?> createVehicle(Map<String, dynamic> vehicleData) async {
    try {
      final docRef = await firestore.collection('vehicles').add({
        ...vehicleData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'status': 'available',
      });
      return docRef.id;
    } catch (e) {
      print('Erreur création véhicule: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getVehicles() async {
    try {
      final querySnapshot = await firestore
          .collection('vehicles')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      print('Erreur récupération véhicules: $e');
      return [];
    }
  }

  static Future<bool> updateVehicle(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('vehicles').doc(id).update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Erreur mise à jour véhicule: $e');
      return false;
    }
  }

  // Gestion des chauffeurs
  static Future<String?> createDriver(Map<String, dynamic> driverData) async {
    try {
      final docRef = await firestore.collection('drivers').add({
        ...driverData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'status': 'active',
      });
      return docRef.id;
    } catch (e) {
      print('Erreur création chauffeur: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getDrivers() async {
    try {
      final querySnapshot = await firestore
          .collection('drivers')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      print('Erreur récupération chauffeurs: $e');
      return [];
    }
  }

  static Future<bool> updateDriver(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('drivers').doc(id).update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Erreur mise à jour chauffeur: $e');
      return false;
    }
  }

  // Gestion des paiements
  static Future<String?> createPayment(Map<String, dynamic> paymentData) async {
    try {
      final docRef = await firestore.collection('payments').add({
        ...paymentData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      print('Erreur création paiement: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getPayments() async {
    try {
      final querySnapshot = await firestore
          .collection('payments')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      print('Erreur récupération paiements: $e');
      return [];
    }
  }

  // Gestion des clients
  static Future<String?> createClient(Map<String, dynamic> clientData) async {
    try {
      final docRef = await firestore.collection('clients').add({
        ...clientData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      print('Erreur création client: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getClients() async {
    try {
      final querySnapshot = await firestore
          .collection('clients')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      print('Erreur récupération clients: $e');
      return [];
    }
  }

  // Statistiques
  static Future<Map<String, dynamic>> getStatistics() async {
    try {
      final reservationsSnapshot = await firestore.collection('reservations').get();
      final vehiclesSnapshot = await firestore.collection('vehicles').get();
      final driversSnapshot = await firestore.collection('drivers').get();
      final paymentsSnapshot = await firestore.collection('payments').get();

      double totalRevenue = 0;
      for (var doc in paymentsSnapshot.docs) {
        final data = doc.data();
        if (data['status'] == 'completed' && data['amount'] != null) {
          totalRevenue += (data['amount'] as num).toDouble();
        }
      }

      return {
        'totalReservations': reservationsSnapshot.docs.length,
        'totalVehicles': vehiclesSnapshot.docs.length,
        'totalDrivers': driversSnapshot.docs.length,
        'totalRevenue': totalRevenue,
        'activeReservations': reservationsSnapshot.docs.where((doc) => 
          doc.data()['status'] == 'confirmed' || doc.data()['status'] == 'in_progress'
        ).length,
        'availableVehicles': vehiclesSnapshot.docs.where((doc) => 
          doc.data()['status'] == 'available'
        ).length,
        'activeDrivers': driversSnapshot.docs.where((doc) => 
          doc.data()['status'] == 'active'
        ).length,
      };
    } catch (e) {
      print('Erreur récupération statistiques: $e');
      return {};
    }
  }

  // Upload de fichiers
  static Future<String?> uploadFile(String path, List<int> data) async {
    try {
      final ref = storage.ref().child(path);
      final uploadTask = ref.putData(Uint8List.fromList(data));
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Erreur upload fichier: $e');
      return null;
    }
  }

  // Écoute en temps réel
  static Stream<List<Map<String, dynamic>>> listenToReservations() {
    return firestore
        .collection('reservations')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data(),
        }).toList());
  }

  static Stream<List<Map<String, dynamic>>> listenToVehicles() {
    return firestore
        .collection('vehicles')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data(),
        }).toList());
  }

  static Stream<List<Map<String, dynamic>>> listenToDrivers() {
    return firestore
        .collection('drivers')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data(),
        }).toList());
  }
}
