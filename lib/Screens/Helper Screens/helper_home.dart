import 'package:Helper_Hiring_System/Screens/Helper%20Screens/ratecard.dart';
import 'package:Helper_Hiring_System/Screens/Helper%20Screens/helper_profile.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth.dart';
import '../../constants.dart';


class HelperHome extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  HelperHome({this.auth,this.onSignedOut});

  @override
  _HelperHomeState createState() => _HelperHomeState();
}

class _HelperHomeState extends State<HelperHome> {

  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = [
      home(),
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

  Widget home(){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOME",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
          )
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body:  Center(
        child: Container(
          child: Text('Home Page', style: TextStyle(fontSize: 28)),
        )
      ),
    );
  }
  
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