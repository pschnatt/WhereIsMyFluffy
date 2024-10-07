import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  // Submit form function
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle the form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Creating your account...')),
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
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4675D1),
                ),
              ),

              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: nameController,
                    obscureText: true, // Obscure password input
                    decoration: InputDecoration(
                      hintText: 'John Doe',
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
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: emailController,
                    obscureText: true, // Obscure password input
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
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
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true, // Obscure password input
                    decoration: InputDecoration(
                      hintText: '******',
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
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4675D1),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: passwordConfirmController,
                    obscureText: true, // Obscure password input
                    decoration: InputDecoration(
                      hintText: '******',
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
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

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
                    child: Text('Sign Up'),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Sign up link
              GestureDetector(
                onTap: () {
                  // Navigate to the signup page when the text is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to SignupPage
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Log in here',
                        style: TextStyle(
                          color: Color(0xFF4675D1),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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