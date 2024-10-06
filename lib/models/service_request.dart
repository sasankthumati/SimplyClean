import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simply_clean/models/checkboxOption.dart';
import 'package:simply_clean/models/serviceType.dart';

class ServiceRequest {
  String id; // Document ID
  String assetId;
  ServiceType serviceType;
  String description;
  List<CheckboxOption> selectedOptions;
  double totalCost;
  DateTime? requestDate; // Add this line

  ServiceRequest({
    this.id = '',
    required this.assetId,
    required this.serviceType,
    required this.description,
    required this.selectedOptions,
    required this.totalCost,
    this.requestDate, // Update this line
  });

  Map<String, dynamic> toMap() {
    return {
      'assetId': assetId,
      'serviceType': serviceType.toString().split('.').last,
      'description': description,
      'selectedOptions': selectedOptions.map((option) => option.toMap()).toList(),
      'totalCost': totalCost,
      'requestDate': requestDate?.toUtc(), // Store date as UTC
    };
  }

  factory ServiceRequest.fromMap(Map<String, dynamic> map) {
    return ServiceRequest(
      id: map['id'] ?? '',
      assetId: map['assetId'],
      serviceType: ServiceType.values.firstWhere((e) => e.toString().split('.').last == map['serviceType']),
      description: map['description'],
      selectedOptions: List<CheckboxOption>.from(
        map['selectedOptions']?.map((option) => CheckboxOption.fromMap(option)) ?? []),
      totalCost: map['totalCost'] ?? 0.0,
      requestDate: (map['requestDate'] as Timestamp?)?.toDate(), // Convert Firestore Timestamp to DateTime
    );
  }

  factory ServiceRequest.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ServiceRequest.fromMap(data)..id = doc.id; // Set the document ID
  }
}
