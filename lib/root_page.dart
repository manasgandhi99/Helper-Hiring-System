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
  // final BaseAuth auth = BaseAuth();
  // String _userId;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final BaseAuth auth = AuthProvider.of(context).auth;
  //   auth.currentUser().then((String userId) {
  //     setState(() {
  //       authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((useremail) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final user = await widget.auth.currentUser();
      // print(user);
      
      // FirebaseFirestore.instance.collection('employer').where('email', isEqualTo: user)
      // .snapshots().listen((data)  {
      //   _city = data.docs[0]['city'];
      //   _state = data.docs[0]['state'];
      //   print('City: $_city');
      //   print('State: $_state');
      // }
      // );
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

      // if(role==""){
      //   setState(() {
      //     role = "no role";
      //   });
      // }

      // SharedPreferences.getInstance().then((prefs) {
      setState(() {
        authStatus = useremail == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
      // });
    });
  }

  void _signedIn() {
    print("_signedIn k andar aaya!!!!");
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  // void _signedUp() {
  //   setState(() {
  //     authStatus = AuthStatus.signedUp;
  //   });
  // }

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
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen(
        //   auth: widget.auth,
        //   onSignedIn: _signedIn,
        // )));
        print('Welcome Screen');
        return WelcomeScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;

      case AuthStatus.signedIn:
        if(role==""){
          return Scaffold(
            body: Center(child:CircularProgressIndicator(backgroundColor: kPrimaryColor,)),
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
          );
        }

        break;
      // case AuthStatus.signedUp:
      //   return RoleSelection(
      //     onSignedUp: _signedUp,
      //   );
      default:
        return _buildWaitingScreen();
    }
   
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

}
