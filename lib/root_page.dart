import 'package:Helper_Hiring_System/Screens/Welcome/welcome_screen.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Employer Screens/home.dart';
import 'Screens/Employer Screens/new_home.dart';
import 'Screens/Helper Screens/helper_home.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
  // signedUp
}

class _RootPageState extends State<RootPage> {
  String role = "";
  AuthStatus authStatus = AuthStatus.notSignedIn;
  String user ="";
 
  @override
  void initState() {
    super.initState();
    print("Inside init state function");
    widget.auth.currentUser().then((useremail) {
      user = useremail;
      FirebaseFirestore.instance.collection('employer').where('email', isEqualTo: useremail)
      .snapshots().listen((data)  {
        setState((){
          role = data.docs[0]['role'];
          print('Emp Role: $role');
        });
      });

      FirebaseFirestore.instance.collection('helper').where('email', isEqualTo: useremail)
      .snapshots().listen((data)  {
        setState((){
          role = data.docs[0]['role'];
          print('Help Role: $role');
        });
      });

      print("Inside widget.auth.currentUser function");
      print("useremail: " + useremail.toString());
      setState(() {
        authStatus = useremail == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    print("_signedIn k andar aaya!!!!");
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build k andar aaya !!!! Authstatus: " + authStatus.toString());

    switch (authStatus) {

      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
        break;

      case AuthStatus.notSignedIn:
        print('Welcome Screen');
        return WelcomeScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;

      case AuthStatus.signedIn:
        if(role==""){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
          );
        }

        else if(role == "employer"){
          print('NewHome Screen');
          return NewHome(
            auth: widget.auth,
            onSignedOut: _signedOut,
          );
        }

        else {
          print('Helper Home Screen');
          return HelperHome(
            auth: widget.auth,
            onSignedOut: _signedOut,
            user: user,
          );
        }

        break;
     
      default:
        return _buildWaitingScreen();
    }
   
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ),
    );
  }

}
