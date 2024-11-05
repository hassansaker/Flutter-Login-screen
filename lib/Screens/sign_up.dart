// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../Widgets/snackbar.dart';
import '../Screens/sign_in.dart';
import '../SQlite/data_base.dart';
import '../JSON/users.dart';
import '../Modeles/selectscreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = true;
  bool _ischeck = true;
  final email = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final db = DatabaseHelper();

  bool _isEmailValid(String email) {
    // Simple email validation regex
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  Future<void> signUp() async {
    // Check if the email and username if both already exists

    if (_isEmailValid(email.text)) {
      if (password.text.length >= 6) {
        Users? usrDetails = await db.getEmail(email.text);
        bool ress = await db.doesUserNameExist(usrName.text);
        //print("the cond1 ${ress} the cond2 ${usrDetails}");
        if (usrDetails != null) {
          if (ress == true) {
            buttonBar('Username is Already exists  try a different one',
                Colors.red, context);
          } else {
            buttonBar('Email is Already exists  try a different one',
                Colors.red, context);
          }
        } else {
          var res = await db.createUser(Users(
              email: email.text,
              usrName: usrName.text,
              password: password.text));
          if (res > 0) {
            if (!mounted) return;
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              return const Sign_In();
            }));
            buttonBar('congratulations your account has been created',
                Colors.green[500], context);
          }
        }
      } else {
        setState(() {
          _ischeck = false;
        });
      }
    } else {
      buttonBar('Incorrect Gmail format', Colors.red, context);
    }
  }

  // Proceed with user creation if the email is unique

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                obscureText: false,
                controller: usrName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person_2_outlined),
                  labelText: 'Username',
                  hintText: 'Enter Your Username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: email,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: password,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    errorText: _ischeck ? null : "Enter at least 6 character"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 73, 179, 105),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.blue[500],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () => signinwindow(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
