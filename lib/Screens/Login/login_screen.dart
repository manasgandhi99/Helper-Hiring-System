import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onSignedIn;
  LoginScreen({this.onSignedIn});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
