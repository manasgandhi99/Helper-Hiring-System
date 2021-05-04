// import 'package:Helper_Hiring_System/role_selection.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Login/components/background.dart';
import 'package:Helper_Hiring_System/Screens/Signup/signup_screen.dart';
import 'package:Helper_Hiring_System/components/already_have_an_account_acheck.dart';
// import 'package:Helper_Hiring_System/components/rounded_button.dart';
// import 'package:Helper_Hiring_System/components/rounded_input_field.dart';
// import 'package:Helper_Hiring_System/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:Helper_Hiring_System/components/text_field_container.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Helper_Hiring_System/auth.dart';
import '../../../root_page.dart';

class Body extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  Body({this.auth,this.onSignedIn});


  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>(); 
  String email = '';
  String password = '';
  bool boolValue = false;
  String useruid = "";
  int count=0;
  bool _passwordVisible;

  @override
  initState(){
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),

              SizedBox(height: size.height * 0.03),

              Image.asset(
                "assets/images/my-password.png",
                height: size.height * 0.35,
              ),

              SizedBox(height: size.height * 0.03),
      
              TextFieldContainer(
                child:TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter some value";
                  }
                  else{
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value))
                      return 'Enter Valid Email';
                  }
                  return null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: kPrimaryColor,
                  ),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
                onSaved: (value) => email = value,
              ),
              ),

              
              TextFieldContainer(
                child:TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter some value";
                  }
                  else{
                    if(value.length < 6){
                      return "Minimum 6 characters atleast";
                    }
                  }
                  return null;
                },
                obscureText: !_passwordVisible,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                    // Based on passwordVisible state choose the icon
                      _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                          _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: InputBorder.none,
                ),
                onSaved: (value) => password = value,
              ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () async{
                      String useruid = await validateAndSubmit();
                      print("apna Userid: "+ useruid);
                      // print("count: " + count.toString());
                      if(useruid != "User doesn't Exist!!" && useruid != "Error in Validation!!"){
                        print("andar aaya");
                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                        // //Return bool
                        // boolValue = prefs.getBool("pref" + email);
                        // print("Variable for user: "+"pref" + email);
                        // print('BoolValue'+ boolValue.toString());
                        // widget.onSignedIn();
                        // if(boolValue){ 
                        Navigator.pop(context);
                        Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth :widget.auth)));
                      }
                    },
                    child: Text(
                      "SIGNIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showErrorDialog(BuildContext context,String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(color: kPrimaryColor),),
      onPressed: () {
        Navigator.pop(context,null);
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

  bool validateAndSave(){
    final isValid = _formKey.currentState.validate(); 
    if (isValid) { 
      _formKey.currentState.save(); 
      return true;
    } 
    else{
      return false;
    }
  }

   Future<String> validateAndSubmit() async{
    if(validateAndSave()){
      try{
        print("Email: ");
        String user = await widget.auth.signInWithEmailAndPassword(email, password);
        
        print("Logged In user => " + user);
        
        // setState((){
        //   count=1;
        //   useruid = user;
        //   print("set state ka count: " + count.toString());
        // });
        return user;
      }
      catch(e){
        print("Error => $e");
        print("Email: " + email + " Password: " + password );
        showErrorDialog(context,"SignIn Error","Please enter the correct email and password.");
        return "User doesn't Exist!!";
      }
    }
    else{
      // showErrorDialog(context,"Validation Error",);
      return "Error in Validation!!";
    }
    
  }
}


