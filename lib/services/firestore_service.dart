// services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_request.dart';
import '../models/asset.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to add an asset
  Future<void> addAsset(Asset asset) async {
    try {
      await _db.collection('assets').add(asset.toMap());
    } catch (e) {
      print('Error adding asset: $e');
      rethrow;
    }
  }

  // Method to get assets
  Stream<List<Asset>> getAssets() {
    return _db.collection('assets').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Asset.fromMap(doc.data() as Map<String, dynamic>)
          ..id = doc.id; // Get document ID
      }).toList();
    });
  }

  // Method to add a service request
  Future<void> addServiceRequest(ServiceRequest request) async {
    try {
      await _db.collection('service_requests').add(request.toMap());
    } catch (e) {
      print('Error adding service request: $e');
      rethrow;
    }
  }

  // Method to get service requests
  Stream<List<ServiceRequest>> getServiceRequests() {
    return _db.collection('service_requests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceRequest.fromMap(doc.data() as Map<String, dynamic>)
          ..id = doc.id; // Get document ID
      }).toList();
    });
  }
}
