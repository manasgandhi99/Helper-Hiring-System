import 'package:Helper_Hiring_System/auth.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  LoginScreen({this.auth,this.onSignedIn});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(auth: auth,onSignedIn: onSignedIn,),
    );
  }
}
