import 'package:Helper_Hiring_System/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/helper_home.dart';
import 'Screens/home.dart';

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
  bool role = false;
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
      SharedPreferences.getInstance().then((prefs) {
        setState(() {
        role = prefs.getBool("pref" + useremail);
        authStatus = useremail == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
      });
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
        return WelcomeScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;

      case AuthStatus.signedIn:
        if(role){
          return Home(
            auth: widget.auth,
            onSignedOut: _signedOut,
          );
        }
        else{
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
