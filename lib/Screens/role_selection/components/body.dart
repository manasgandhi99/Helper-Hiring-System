import 'package:Helper_Hiring_System/auth.dart';
import 'package:flutter/material.dart';
// import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
// import 'package:Helper_Hiring_System/Screens/Signup/signup_screen.dart';
import 'package:Helper_Hiring_System/Screens/Welcome/components/background.dart';
// import 'package:Helper_Hiring_System/components/rounded_button.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../../root_page.dart';
import 'package:Helper_Hiring_System/Screens/Helper Screens/profile_creation.dart';

class Body extends StatefulWidget {
  
  // final VoidCallback onSignedUp;
  final BaseAuth auth;
  final String name;
  final String email;
  final String contactno;
  final String state;
  final String city;
  final String password;
  final File file;
  Body({this.auth,this.name, this.email, this.contactno, this.state, this.city, this.password, this.file});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String fileurl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              
              padding: EdgeInsets.fromLTRB(size.width * 0.05 ,size.height*0.04, size.width * 0.05, size.height*0.04),
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
                
                height: size.height * 0.40,
              ),
            ),
            
            SizedBox(height: size.height * 0.05),

            Container(
              padding: EdgeInsets.all(size.width*0.06),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  Text(
                    "WHAT ARE YOU HERE FOR?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)
                  ),

                  SizedBox(height: size.height * 0.03),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryColor,
                        onPressed: ()async{
                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                        // prefs.setBool("pref"+ widget.email, true);
                        setData('house_help');
                        setData('office_help');
                        setData('babysitting');
                        setData('patient_care');
                        setData('cook');
                        setData('elderly_care');
                        print("Employer Store Function Call!!!!!!!!!!!!!!!!!");
                        String useruid = await userCreation(context);
                        print("apna Userid: "+ useruid);
                        if(useruid != "Error while Registering User!!"){
                          fileurl = await uploadFiles(widget.file);
                          store();
                          Navigator.pop(context);
                          Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth :widget.auth)));
                        }
                        else{
                          print('ERROR');
                          // Navigator.pop(context);
                          // Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth :widget.auth)));
                        }
                        
                        },
                        child: Text(
                          "I want a Helper",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryLightColor,
                        onPressed: ()async{
                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                        // prefs.setBool("pref"+widget.email, false);
                          // fileurl = await uploadFiles(widget.file);
                          print("Helper Store Function Call!!!!!!!!!!!!!!!!!");
                          String useruid = await userCreation(context);
                          print("apna Userid: "+ useruid);
                          if(useruid != "Error while Registering User!!"){
                            fileurl = await uploadFiles(widget.file);
                            helperstore();
                            Navigator.pop(context);
                            Navigator.push(context , MaterialPageRoute(builder: (context) => ProfileCreation(auth :widget.auth)));
                          }
                          else{
                            print('ERROR');
                            
                          }
                        },
                        child: Text(
                          "I want a Job",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            

          ],

        ),
      ),
    );
  }

  showErrorDialog(BuildContext context,String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(color: kPrimaryColor),),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.pop(context);
        Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth :widget.auth)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> setData(String category) async {
    print("set data me city"+widget.city);
    try{
      final user = await widget.auth.currentUser();
      print(user);
      await FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('filter')
        .doc(category)
        .set(
        {'city': widget.city,'state': widget.state, 'religion': ["Hindu","Muslim","Christian","Others"],'duration': ["Less than 2","2-4","4-6","More than 6"], 'gender': ["Male","Female","Transgender"], 'budget': "Low to High", 'yearofexp': "High to Low", 'category':category, 'pref':'Salary'});
    }
    catch(e){
      print("Error: " + e);
    }
    
  }

  Future<String> userCreation(BuildContext context) async{
    print("Inside user creation function");
     try{
        User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email, password: widget.password)).user;
        
        print("Registered user => " + user.uid);
        return user.uid;
      }
      catch(e){
        print("Error => $e");
        if(e.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account."){
          showErrorDialog(context,"Signup Error","The email address is already in use by another account.");
        }
        else{
          showErrorDialog(context,"Signup Error",e.toString());
        }
        return "Error while Registering User!!";
      }
  }

  Future<void> store() async {
    print("Inside store function");
    try{
      await FirebaseFirestore.instance
        .collection('employer')
        .doc(widget.email)
        .set(
        {'name': widget.name,'email': widget.email, 'role':'employer','password':widget.password,'contact no': widget.contactno, 'state':widget.state, 'city':widget.city, 'aadhar':fileurl});

      await FirebaseFirestore.instance
        .collection('employer')
        .doc(widget.email)
        .collection('profile')
        .doc(widget.email)
        .set(
        {'name': widget.name,'email': widget.email,'contact no': widget.contactno, 'state':widget.state, 'city':widget.city, 'photo': "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png" });
    }
    catch(e){
      print("Error: " + e);
    }
    
  }

  Future<void> helperstore() async {
    print("Inside helper store function");
    try{
      await FirebaseFirestore.instance
        .collection('helper')
        .doc(widget.email)
        .set(
        {'name': widget.name,'email': widget.email, 'role':'helper', 'password':widget.password,'contact no': widget.contactno, 'state':widget.state, 'city':widget.city, 'aadhar':fileurl});
    }
    catch(e){
      print("Error: " + e);
    }
    
  }

  Future<String> uploadFiles(File _image) async {
    String imageUrl;
    print("Upload docs wala user\n");
    print(widget.email);
    String imageRef = widget.email + '/' + _image.path.split('/').last;
    print(imageRef);
    // await FirebaseStorage.instance.ref(imageRef).putFile(_image);

    imageUrl = await (await FirebaseStorage.instance.ref(imageRef).putFile(_image)).ref.getDownloadURL();
    print(imageUrl);
    return imageUrl;
  }
  
}
