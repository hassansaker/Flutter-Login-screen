// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:login/Widgets/snackbar.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var _email = "";
  final _emailController = TextEditingController();

  void _updateText(String val) {
    setState(() {
      _email = val;
    });
  }

  bool _isEmailValid(String email) {
    // Simple email validation regex
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  void reset() {
    if (_isEmailValid(_email)) {
      buttonBar('Thank you check you Email we sent you a recover password',
          Colors.green[500], context,
          time: 4);
      Navigator.of(context).pop();
    } else {
      // Show an error message if the email is invalid
      buttonBar('Please enter a valid email address', Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Enter your email to reset your password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                onChanged: (val) {
                  _updateText(val);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B8D5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
