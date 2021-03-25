import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
import 'package:Helper_Hiring_System/Screens/Signup/signup_screen.dart';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:flutter/material.dart';
// import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
// import 'package:Helper_Hiring_System/Screens/Signup/signup_screen.dart';
import 'package:Helper_Hiring_System/Screens/Welcome/components/background.dart';
import 'package:Helper_Hiring_System/components/rounded_button.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  Body({this.auth,this.onSignedIn});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO HIREHELPER",
              style: GoogleFonts.montserrat(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
              )
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/helperApp2.png",
              height: size.height * 0.40,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(auth: auth,onSignedIn: onSignedIn,);
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(auth: auth);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
