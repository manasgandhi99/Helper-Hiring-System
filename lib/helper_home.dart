import 'package:flutter/material.dart';
import 'auth.dart';
import 'auth_provider.dart';

class HelperHome extends StatefulWidget {
  final VoidCallback onSignedOut; 
  HelperHome({this.onSignedOut});

  @override
  _HelperHomeState createState() => _HelperHomeState();
}

class _HelperHomeState extends State<HelperHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: Container(
        child: Center(child: Text('This is Helper Side', style: TextStyle(fontSize: 32.0))),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}