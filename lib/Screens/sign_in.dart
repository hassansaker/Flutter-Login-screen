// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:login/Widgets/snackbar.dart';
import '../Screens/welcome.dart';
import '../JSON/users.dart';
import '../SQlite/data_base.dart';
import '../Modeles/selectscreen.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Sign_In> {
  bool passwordVisible = true;
  bool isLoginTrue = false;
  String? usname = "";
  final email = TextEditingController();
  final password = TextEditingController();
  final db = DatabaseHelper();

  login() async {
    //Users? usrDetails = await db.getEmail(email.text);
    //var name=await db.getUser(usrName)
    if (email.text == "" || password.text == "") {
      buttonBar(
          'one of the field is empty enter something', Colors.red, context);
    } else {
      var res = await db
          .authenticate(Users(email: email.text, password: password.text));
      if (res == true) {
        //If result is correct then go to profile or home
        usname = await db.getUserNameByEmail(email.text);
        if (!mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Profile(email: email.text, username: usname.toString());
        }));
      } else {
        //Otherwise show the error message
        buttonBar('user name or password not corrected try again', Colors.red,
            context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Sign in'),
        backgroundColor: const Color(0xFF4C8D5F),
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
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      )),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 73, 179, 105),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline),
                ),
                onTap: () => passwordreset(context),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Sign Up?',
                      style: TextStyle(
                          color: Colors.blue[500],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () => signupwindow(context),
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
