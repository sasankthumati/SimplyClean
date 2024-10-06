// screens/request_service_screen.dart
import 'package:flutter/material.dart';
import 'package:simply_clean/models/checkboxOption.dart';
import 'package:simply_clean/models/serviceType.dart';
import '../models/service_request.dart';

class RequestServiceScreen extends StatefulWidget {
  @override
  _RequestServiceScreenState createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  String? selectedAsset; // Nullable string for selected asset
  ServiceType? selectedServiceType;
  String description = '';
  List<CheckboxOption> options = []; // Initialize options based on service type

  @override
  void initState() {
    super.initState();
    // Initialize options based on selected service type (you can define your options)
    options = [
      CheckboxOption(name: 'Floor Vacuum', cost: 50.0),
      CheckboxOption(name: 'Bathroom Cleaning', cost: 30.0),
      CheckboxOption(name: 'Kitchen Cleaning', cost: 70.0),
      CheckboxOption(name: 'Replace Tissue', cost: 20.0),
      CheckboxOption(name: 'Wash Sheets', cost: 25.0),
    ];
  }

  void calculateTotalCost() {
    double total = 0.0;
    for (var option in options) {
      if (option.isSelected) {
        total += option.cost;
      }
    }
    // Update the total cost in the UI or model
    print("Total Cost: $total");
  }

  void onAssetSelected(String? assetId) { // Changed to nullable String
    setState(() {
      selectedAsset = assetId; // Update selected asset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Select Asset'),
              value: selectedAsset,
              onChanged: onAssetSelected, // Now accepts nullable String
              items: <String>[
                'Asset 1',
                'Asset 2',
                'Asset 3', // Replace with your asset data
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<ServiceType>(
              hint: Text('Select Service Type'),
              value: selectedServiceType,
              onChanged: (ServiceType? newValue) {
                setState(() {
                  selectedServiceType = newValue;
                });
              },
              items: ServiceType.values.map<DropdownMenuItem<ServiceType>>((ServiceType value) {
                return DropdownMenuItem<ServiceType>(
                  value: value,
                  child: Text(value.toString().split('.').last),
                );
              }).toList(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            ...options.map((option) {
              return CheckboxListTile(
                title: Text(option.name),
                value: option.isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    option.isSelected = value ?? false;
                    calculateTotalCost(); // Recalculate cost when checkbox changes
                  });
                },
              );
            }).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create service request logic
                final serviceRequest = ServiceRequest(
                  assetId: selectedAsset!,
                  serviceType: selectedServiceType!,
                  description: description,
                  selectedOptions: options.where((option) => option.isSelected).toList(),
                  totalCost: options.where((option) => option.isSelected).fold(0.0, (sum, option) => sum + option.cost),
                );
                // Handle the service request (e.g., save to database)
                print('Service Request Created: ${serviceRequest.totalCost}');
              },
              child: Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
