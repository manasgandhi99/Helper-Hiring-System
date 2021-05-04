import 'package:Helper_Hiring_System/Screens/Helper%20Screens/ratecard.dart';
import 'package:Helper_Hiring_System/Screens/Helper%20Screens/helper_profile.dart';
import 'package:Helper_Hiring_System/Screens/Helper%20Screens/helper_notification.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth.dart';
import '../../constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class HelperHome extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  final String user;
  HelperHome({this.auth,this.onSignedOut, this.user});

  @override
  _HelperHomeState createState() => _HelperHomeState();
}

class _HelperHomeState extends State<HelperHome> {

  int _selectedIndex = 0;


  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saveDeviceToken();
    _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            // showDialog(
            //     context: context,
            //     builder: (context) => AlertDialog(
            //             content: ListTile(
            //             title: Text(message['notification']['title']),
            //             subtitle: Text(message['notification']['body']),
            //             ),
            //             actions: <Widget>[
            //             FlatButton(
            //                 child: Text('Ok'),
            //                 onPressed: () => Navigator.of(context).pop(),
            //             ),
            //         ],
            //     ),
            // );
            AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body:Center(
                  child: 
                    Text(
                      message['notification']['body'],
                      // style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              ),
            title: message['notification']['title'],
            desc:  message['notification']['body'],
            btnOkOnPress: () {
              // setState((){
                // Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> HelperHome(auth: widget.auth, onSignedOut: widget.onSignedOut,)));
              // });
            },
            )..show();
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            // TODO optional
        },
      );
  }

  _saveDeviceToken() async {
    // Get the current user
    final user = await widget.auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = FirebaseFirestore.instance
          .collection('helper')
          .doc(user)
          .collection('tokens')
          .doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        // 'platform': Platform.operatingSystem // optional
      });
    }
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = [
      HelperNotification(auth: widget.auth, user: widget.user,),
      RateCard(),
      HelperProfile(auth: widget.auth, onSignedOut: widget.onSignedOut),
    ];

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
    
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: kPrimaryLightColor,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 20.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Rate Card',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),

        body: _widgetOptions.elementAt(_selectedIndex),
        // Container(
        //   child: Center(child: Text('This is Helper Side', style: TextStyle(fontSize: 32.0))),
      ),
    );
  }

  // Widget home(){
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         "HOME",
  //         style: GoogleFonts.montserrat(
  //         fontSize: 20.0,
  //         fontWeight: FontWeight.bold,
  //         color: kPrimaryColor
  //         )
  //       ),
  //       elevation: 0.0,
  //       backgroundColor: Colors.transparent,
  //       automaticallyImplyLeading: false,
  //     ),
  //     body:  Center(
  //       child: Container(
  //         child: Text('Home Page', style: TextStyle(fontSize: 28)),
  //       )
  //     ),
  //   );
  // }
  
  // void _signOut(BuildContext context) async {
  //   try {
  //     // final BaseAuth auth = AuthProvider.of(context).auth;
  //     await widget.auth.signOut();
  //     widget.onSignedOut();
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}