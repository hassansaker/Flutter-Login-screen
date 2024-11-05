import 'package:flutter/material.dart';
import 'package:login/Screens/sign_in.dart';
import 'package:login/Widgets/snackbar.dart';

class Profile extends StatelessWidget {
  final String email;
  final String username;
  const Profile({super.key, required this.email, required this.username});

  @override
  Widget build(BuildContext context) {
    // Sample user data
    String userName = username;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              ElevatedButton(
                onPressed: () {
                  // Add functionality to edit profile
                  buttonBar('Coming Soon', Colors.green[500], context);
                },
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return const Sign_In();
                  }));
                  buttonBar('Logout clicked', Colors.green[500], context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
