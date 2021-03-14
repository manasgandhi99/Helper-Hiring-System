import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';

import '../auth.dart';


class HelperHome extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  HelperHome({this.auth,this.onSignedOut});

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
            onPressed: () {
              _signOut(context);
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder:(context) => RootPage(auth: widget.auth)));
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(child: Text('This is Helper Side', style: TextStyle(fontSize: 32.0))),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    try {
      // final BaseAuth auth = AuthProvider.of(context).auth;
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}