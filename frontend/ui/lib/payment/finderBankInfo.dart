import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(FinderBillingInfoPage());
}

class FinderBillingInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finder Bank Information Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FinderBillingInfoForm(),
    );
  }
}

class FinderBillingInfoForm extends StatefulWidget {
  @override
  _FinderBillingInfoFormState createState() => _FinderBillingInfoFormState();
}

class _FinderBillingInfoFormState extends State<FinderBillingInfoForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  TextEditingController bankAccNumberController = TextEditingController();
  TextEditingController bankAccTypeController = TextEditingController();
  TextEditingController bankAccNameController = TextEditingController();

  // Submit form function
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle the form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submiting finder\'s bank account info...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Row(
                children: [
                  Image.asset(
                    '/home/ptk/kmitl/year3/software_architecture/myfluffyFE/myfluffy/assets/logo.png',  // Add your image path here
                    fit: BoxFit.contain,
                    height: 100, // Set your desired height
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Finder\'s Bank Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4675D1),
                ),
              ),
              SizedBox(height: 20),


              //Bank Account Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Account No:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: bankAccNumberController,
                    decoration: InputDecoration(
                      hintText: '098-2873-289-00',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter bank account number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              //Bank Account Type
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Account Type:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: bankAccTypeController,
                    decoration: InputDecoration(
                      hintText: 'Krungthai',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter bank account type';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              //Bank Account Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Account Name:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: bankAccNameController,
                    decoration: InputDecoration(
                      hintText: 'Jony Depp',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 10.0),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter bank account name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Center-aligned Login Button
              Center(
                child: Container(
                  width: 150, // Set the width of the button
                  height: 45, // Set the height of the button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4675D1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: Text('Confirm'),
                  ),
                ),
              ),
              SizedBox(height: 16),

              
            ],
          ),
        ),
      ),
    );
  }
}
