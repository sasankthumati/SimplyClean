import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CreateAssetScreen extends StatefulWidget {
  @override
  _CreateAssetScreenState createState() => _CreateAssetScreenState();
}

class _CreateAssetScreenState extends State<CreateAssetScreen> {
  Position? _currentPosition;
  String _address = "";
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sqFeetController = TextEditingController();
  final TextEditingController _bedroomCountController = TextEditingController();
  final TextEditingController _floorCountController = TextEditingController();
  final TextEditingController _bathroomCountController = TextEditingController();

  Future<void> _getCurrentLocation() async {
    try {
      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permissions if not granted
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Handle permission denied scenario
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permissions are denied.')),
          );
          return;
        }
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      Placemark place = placemarks[0];

      // Update state to reflect the address
      setState(() {
        _address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
        _addressController.text = _address; // Set the address to the TextField
      });
    } catch (e) {
      print('Could not get location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not get location. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _addressController, // Allow typing in the address
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Press the pin icon to fill this',
                suffixIcon: IconButton(
                  icon: Icon(Icons.pin_drop),
                  onPressed: _getCurrentLocation, // Use pin icon to get location
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _sqFeetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Square Feet (100 - 70000)'),
              // Add validation logic here
            ),
            TextField(
              controller: _bedroomCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Bedroom Count (Increment 1)'),
            ),
            TextField(
              controller: _floorCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Floor Count (Increment 1)'),
            ),
            TextField(
              controller: _bathroomCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Bathroom Count (Increment 0.5)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the creation of the asset
              },
              child: Text('Create Asset'),
            ),
          ],
        ),
      ),
    );
  }
}
