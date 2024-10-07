import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:ui/pages/location_picker_page.dart';

class FoundPetForm extends StatefulWidget {
  const FoundPetForm({super.key});

  @override
  State<FoundPetForm> createState() => _FoundPetFormState();
}

class _FoundPetFormState extends State<FoundPetForm> {
  final _formKey = GlobalKey<FormState>();
  final List<File> _images = [];
  final _picker = ImagePicker();
  String? selectedGender;
  String? selectedLocation; // To store the selected location


  // Form fields controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // Pick images from gallery
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
      });
    }
  }
  Future<void> _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerPage()),
    );
    if (result != null) {
      setState(() {
        selectedLocation = result; // Update the location
      });
    }
  }


  // Submit form function
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle the form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Posting your lost pet...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Where did you find it?',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4675D1)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Help owners find their fluffy!',
                style: TextStyle(fontSize: 14, color: Color(0xFF4675D1)),
              ),
              const SizedBox(height: 16),

              // Images Picker
              //Text('Images:', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      'Location:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4675D1)),
                    ),
                  ),
                  
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedLocation ??
                                'Pick a location', // Display picked location or default text
                            style: TextStyle(
                              color: selectedLocation != null
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _pickLocation, // Navigate to pick location
                          icon: const Icon(Icons.location_on),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(children: [
                Container(
                  width: 80,
                  child: const Text(
                    'Location:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4675D1)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: 'Found at (Location)',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color:
                            Colors.black.withOpacity(0.3), // Set opacity here
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Found at (Location)';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 16),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items to the start
                children: [
                  const Text(
                    'Details:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1), // Set color to your hex value
                    ),
                  ),
                  const SizedBox(
                      height:
                          4), // Add a small space between label and text field
                  TextFormField(
                    controller: detailsController,
                    decoration: InputDecoration(
                      hintText: 'Tell the owner how did you find it',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color:
                            Colors.black.withOpacity(0.3), // Set opacity here
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 5.0, 0, 50.0),
                      isDense: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: 16), // Add spacing below the details section

              // Submit Button Container
              Align(
                alignment: Alignment.bottomRight, // Align to bottom right
                child: Container(
                  width: 120, // Set the width of the button
                  height: 35, // Set the height of the button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF4675D1), // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        // Process data (e.g., send to a server or save locally)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Submitting your lost pet info!')),
                        );
                      }
                    },
                    child: const Text('Send'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
