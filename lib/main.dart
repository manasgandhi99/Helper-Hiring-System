import 'package:Helper_Hiring_System/auth.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Welcome/welcome_screen.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HireHelper',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: RootPage(auth: Auth()),
      );
    
  }
}
