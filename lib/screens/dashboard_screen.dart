import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_request.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('service_requests').snapshots(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // No data state
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No service requests available.'));
          }

          // Map Firestore documents to ServiceRequest objects
          final requests = snapshot.data!.docs
              .map((doc) => ServiceRequest.fromDocument(doc))
              .toList();

          // Display the requests in a grid view
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Service: ${request.serviceType.toString().split('.').last}'),
                      SizedBox(height: 8.0),
                      Text('Description: ${request.description ?? 'N/A'}'), // Handle null description
                      SizedBox(height: 8.0),
                      Text('Date: ${request.requestDate?.toLocal().toString() ?? 'N/A'}'), // Handle null date
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
