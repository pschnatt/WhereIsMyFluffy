import 'package:flutter/material.dart';

class LocationPickerPage extends StatelessWidget {
  const LocationPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Location'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate picking a location and returning it
            String selectedLocation = "123 Main St, City";
            Navigator.pop(context, selectedLocation); // Return data to previous screen
          },
          child: const Text('Select Location'),
        ),
      ),
    );
  }
}
