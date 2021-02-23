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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Helper_Hiring_System/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Helper_Hiring_System/helper_home.dart';


class Body extends StatefulWidget {
  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>(); 
  String _email = '';
  String _password = '';

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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: size.height * 0.03),

              SvgPicture.asset(
                "assets/icons/login.svg",
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
                onSaved: (value) => _email = value,
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
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                onSaved: (value) => _password = value,
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
                      if(useruid != "User doesn't Exist!!" && useruid != "Error in Validation!!"){
                        print("andar aaya");
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        //Return bool
                        bool boolValue = prefs.getBool("pref"+_email);
                        print("Variable for user: "+"pref"+_email);
                        print('BoolValue'+ boolValue.toString());
                        if(boolValue){
                          Navigator.pop(context);
                          Navigator.push(context , MaterialPageRoute(builder: (context) => Home()));
                        }
                        else{
                          Navigator.pop(context);
                          Navigator.push(context , MaterialPageRoute(builder: (context) => HelperHome()));
                        }
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
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
      
        print("Logged In user => " + user.uid);
        return user.uid;
      }
      catch(e){
        print("Error => $e");
        return "User doesn't Exist!!";
      }
    }
    else{
      return "Error in Validation!!";
    }
    
  }
}


