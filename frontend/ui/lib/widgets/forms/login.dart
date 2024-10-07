
import 'package:flutter/material.dart';
import 'package:ui/constants.dart';
import 'package:ui/widgets/forms/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ui/main.dart';
import 'package:ui/constants.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;


  // Form fields controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Login function
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('${APIURL}/authorization/login/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          // Login successful
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );

          // You can navigate to the home page or another page after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationBarApp()), // Replace with your Home Page
          );
        } else {
          // Login failed
          if (!mounted) return;
          final errorData = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorData['detail'] ?? 'Login failed')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
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
                'Welcome!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4675D1),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Log In',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4675D1)),
              ),
              SizedBox(height: 20),

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
                    //obscureText: true, // Obscure password input
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
                    child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white,)
                      : const Text('Log In'),
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
                    MaterialPageRoute(builder: (context) => SignupForm()), // Navigate to SignupPage
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign up here',
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
