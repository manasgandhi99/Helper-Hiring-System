import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Signup/components/body.dart';
import '../../auth.dart';

class SignUpScreen extends StatelessWidget {
  final BaseAuth auth;
  SignUpScreen({this.auth});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(auth: auth),
    );
  }
}
