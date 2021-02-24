import 'package:Helper_Hiring_System/auth.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  WelcomeScreen({this.auth,this.onSignedIn});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(auth: auth, onSignedIn: onSignedIn),
    );
  }
}
