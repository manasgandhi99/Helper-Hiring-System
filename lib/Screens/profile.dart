import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'new_home.dart';

class Profile extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  Profile({this.auth,this.onSignedOut});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employer Profile'),
        actions: <Widget>[
          // FlatButton(
          //   child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
          //   onPressed: () {
          //     _signOut(context);
          //     // Navigator.pop(context);
          //     // Navigator.push(context, MaterialPageRoute(builder:(context) => RootPage(auth: widget.auth)));
          //     // Navigator.pop(context);
          //   //  _signOut(context);
          //   } 
          // )
        ],
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Center(child: Text("Employer's Profile Page", style: TextStyle(fontSize: 32.0))),
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