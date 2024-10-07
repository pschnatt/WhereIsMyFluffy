import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/pages/location_picker_page.dart';
import 'package:ui/pages/user_profile_page.dart';

class LostPetForm extends StatefulWidget {
  @override
  _LostPetFormState createState() => _LostPetFormState();
}

class _LostPetFormState extends State<LostPetForm> {
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

  // Navigate to UserProfilePage and await the selected location
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
                'Pet lost?',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4675D1)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Let others help you find your fluffy!',
                style: TextStyle(fontSize: 14, color: Color(0xFF4675D1)),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      'Choose pet:',
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
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        items: <String>['Male', 'Female', 'Unknown']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Select your pet',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.3),
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select the pet\'s gender';
                          }
                          return null;
                        },
                      ),
                    ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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

              // Other form fields...

              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 120,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4675D1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: const Text('Post'),
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
