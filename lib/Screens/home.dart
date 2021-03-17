import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'new_home.dart';

class Home extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  Home({this.auth,this.onSignedOut});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text('New Home', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () {
              // _signOut(context);
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder:(context) => RootPage(auth: widget.auth)));
              // Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder:(context) => NewHome(auth: widget.auth, onSignedOut: widget.onSignedOut)));
            } 
          ),
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () {
              _signOut(context);
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder:(context) => RootPage(auth: widget.auth)));
              // Navigator.pop(context);
            //  _signOut(context);
            } 
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(child: Text('This is Employer Side', style: TextStyle(fontSize: 32.0))),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } 
    catch (e) {
      print("Error in Signout!!");
      print(e);
    }
  }
}