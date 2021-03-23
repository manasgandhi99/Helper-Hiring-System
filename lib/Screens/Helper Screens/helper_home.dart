import 'package:Helper_Hiring_System/Screens/Helper%20Screens/ratecard.dart';
import 'package:Helper_Hiring_System/Screens/Helper%20Screens/helper_profile.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
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
      HelperProfile(auth: widget.auth,),
    ];

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(

          title: Text('Helper Home'),
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
      body:  Center(
        child: Container(
          child: Text('This is my Home Page', style: TextStyle(fontSize: 28)),
        )
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