import 'package:flutter/material.dart';
import '../Screens/sign_in.dart';
import '../Screens/forgetPassword.dart';
import '../Screens/sign_up.dart';

void passwordreset(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return ForgetPassword();
  }));
}

void signupwindow(BuildContext ctx) {
  Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
    return const SignUp();
  }));
}

void signinwindow(BuildContext ctx) {
  Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
    return const Sign_In();
  }));
}

void welcome(BuildContext ctx) {
  Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
    return const SignUp();
  }));
}
