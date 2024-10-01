import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LostPetForm extends StatefulWidget {
  @override
  _LostPetFormState createState() => _LostPetFormState();
}

class _LostPetFormState extends State<LostPetForm> {
  final _formKey = GlobalKey<FormState>();
  final List<File> _images = [];
  final _picker = ImagePicker();
  String? selectedGender;

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

              // Images Picker
              //Text('Images:', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: [
                  for (var image in _images)
                    Image.file(image,
                        height: 100, width: 100, fit: BoxFit.cover),
                  IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: _pickImages,
                  )
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  // Label
                  Container(
                    width: 80, // Adjust the width as needed
                    child: const Text(
                      'Name:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4675D1)),
                    ),
                  ),

                  // TextFormField
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter pet name',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color:
                              Colors.black.withOpacity(0.3), // Set opacity here
                        ),
                        border: const OutlineInputBorder(),
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                        isDense: true, // Makes the text field denser
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the pet\'s name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(children: [
                Container(
                  width: 80,
                  child: const Text(
                    'Age:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4675D1)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      hintText: 'Enter pet\'s age',
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
                        return 'Please enter the pet\'s age';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 16),

              Row(children: [
                Container(
                  width: 80,
                  child: const Text(
                    'Weight:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4675D1)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(
                      hintText: 'Enter pet\'s weight',
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
                        return 'Please enter the pet\'s weight';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 16),

              // Gender Dropdown
              Row(
                children: [
                  Container(
                    width: 80,
                    child: const Text(
                      'Gender:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4675D1)),
                    ),
                  ),
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
                          selectedGender =
                              newValue; // Update the selected value
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Select pet\'s gender',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        border: const OutlineInputBorder(),
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                        //isDense: true,
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
                      hintText: 'Lost at (Location)',
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
                        return 'Lost at (Location)';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 16),

              Row(children: [
                Container(
                  width: 80,
                  child: const Text(
                    'Reward:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4675D1)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: rewardController,
                    decoration: InputDecoration(
                      hintText: 'Reward',
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
                        return 'Reward';
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
                      hintText: 'Any additional details',
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
                    child: const Text('Post'),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Add space between buttons
              Container(
                width: 120,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Different color for clarity
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
