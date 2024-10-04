import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPetForm extends StatefulWidget {
  const AddPetForm({super.key});

  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _formKey = GlobalKey<FormState>();
  final List<File> _images = [];
  final _picker = ImagePicker();
  String? selectedGender;

  // Form fields controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController breedController = TextEditingController(); // New Breed Controller
  TextEditingController colorController = TextEditingController(); // New Color Controller
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
        const SnackBar(content: Text('Posting your pet info...')),
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
                'Add a New Pet',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4675D1)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Let others know about your fluffy!',
                style: TextStyle(fontSize: 14, color: Color(0xFF4675D1)),
              ),
              const SizedBox(height: 16),

              // Images Picker
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

              // Name Field
              _buildTextField('Name:', nameController, 'Enter pet name', 'Please enter the pet\'s name'),

              // Age Field
              _buildTextField('Age:', ageController, 'Enter pet\'s age', 'Please enter the pet\'s age'),

              // Weight Field
              _buildTextField('Weight:', weightController, 'Enter pet\'s weight', 'Please enter the pet\'s weight'),

              // Breed Field
              _buildTextField('Breed:', breedController, 'Enter pet\'s breed', 'Please enter the pet\'s breed'),

              // Color Field
              _buildTextField('Color:', colorController, 'Enter pet\'s color', 'Please enter the pet\'s color'),

              // Gender Dropdown
              Padding(
                padding: const EdgeInsets.only(top: 16.0), // Add padding
                child: Row(
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
                            selectedGender = newValue;
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

              // Details Field
              Padding(
                padding: const EdgeInsets.only(top: 16.0), // Add padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4675D1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: detailsController,
                      decoration: InputDecoration(
                        hintText: 'Any additional details',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        border: const OutlineInputBorder(),
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 0, 50.0),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Submit Button Container
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, TextEditingController controller, String hintText, String validationMessage) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // Add padding
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4675D1)),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.3),
                ),
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                isDense: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationMessage;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
