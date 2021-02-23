import 'package:Helper_Hiring_System/role_selection/role_selection.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:Helper_Hiring_System/home.dart';
import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
import 'package:Helper_Hiring_System/auth_provider.dart';

class RootPage extends StatefulWidget {
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
  AuthStatus authStatus = AuthStatus.notDetermined;
  // final BaseAuth auth ;
  // String _userId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.currentUser().then((String userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        print(authStatus);
      });
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   auth.currentUser().then((user) {
  //     setState(() {
  //       if (user != null) {
  //         _userId = user;
  //       }
  //       authStatus =
  //           user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
  //       if (user?.uid == null) {
  //         globals.isLoggedIn = false;
  //       } else {
  //         globals.isLoggedIn = true;
  //         checkHistoryStatus(user.email);
  //       }
  //     });
  //   });
  // }

  void _signedIn() {
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
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginScreen(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Home(
          onSignedOut: _signedOut,
        );
      // case AuthStatus.signedUp:
      //   return RoleSelection(
      //     onSignedUp: _signedUp,
      //   );
    }
    return null;
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