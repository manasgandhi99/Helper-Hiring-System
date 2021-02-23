import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/Screens/Login/login_screen.dart';
import 'package:Helper_Hiring_System/Screens/Signup/components/background.dart';
// import 'package:Helper_Hiring_System/Screens/Signup/components/or_divider.dart';
import 'package:Helper_Hiring_System/components/already_have_an_account_acheck.dart';
// import 'package:Helper_Hiring_System/components/rounded_button.dart';
// import 'package:Helper_Hiring_System/components/rounded_input_field.dart';
// import 'package:Helper_Hiring_System/components/rounded_password_field.dart';
// import 'package:Helper_Hiring_System/components/upload_docs_button.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:Helper_Hiring_System/components/text_field_container.dart';
import 'package:Helper_Hiring_System/role_selection/role_selection.dart';
// import 'address_search.dart';
// import 'loc_apicall.dart';
// import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'dart:math';
// import 'package:file_picker/file_picker.dart';

// import 'dart:convert';


// import 'package:flutter_svg/svg.dart';
FlutterOtp otp = FlutterOtp();
class Body extends StatefulWidget {
  
  @override
  _Bodystate createState() => _Bodystate();
}

class _Bodystate extends State<Body> {
  TextEditingController _c;
  @override
  initState(){
    _c = new TextEditingController();
    super.initState();
  }
  // final _controller = TextEditingController();
  TextEditingController _controller = TextEditingController();
  // String _city = '';
  String _email = '';
  String _password = '';
  String _name = '';
  String _contactno = '';
  String _state = '';
  String _cityarea = '';
  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode ="+91";
  int enteredotp = 0;
  int randomNumber;
  String outputshoutput='';
  // List<File> files;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: size.height * 0.03),

              TextFieldContainer(
                child:TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter some value";
                  }
                  else{
                    if(value.length < 3){
                      return "Minimum length must be 3";
                    }
                  }
                  return null;
                },
                
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "Name",
                  border: InputBorder.none,
                ),
                onSaved: (value) => _name = value,
              ),
              ),

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
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);
                    if(value.length!=10){
                      return "Mobile Number must be of 10 digits";
                    }
                    else{
                      if(!regExp.hasMatch(value)){
                        return "Please enter valid Mobile Number";
                      }
                    }
                  }
                  return null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.contact_phone,
                    color: kPrimaryColor,
                  ),
                  hintText: "Contact Number",
                  border: InputBorder.none,
                ),
                onSaved: (value) => _contactno = value,
              ),
              ),
              
              TextFieldContainer(
                child:TextFormField(
                controller: _controller,
                // onTap: () async {
                //   // should show search screen here
                //   final sessionToken = Uuid().v4();
                //   print('Session token: '+ sessionToken);
                //   final Suggestion result = await showSearch(
                //     context: context,
                //     delegate: AddressSearch(sessionToken),
                //   );
                //   print('Show search k andar aake gaya');
                //   print('Result print karre: '+ result.description);
                //   // This will change the text displayed in the TextField
                //   if (result != null) {
                //     print('place details k liye aaya');
                //     final placeDetails = await PlaceApiProvider(sessionToken)
                //       .getPlaceDetailFromId(result.placeId);
                //     print('place details print kiya: '+ placeDetails.toString());
                //   setState(() {
                //     _controller.text = result.description;
                //     _city = placeDetails.city;
                   
                //   });
                //   print('City: '+ _city);
                //   }
                // },
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter some value";
                  }
                  return null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_city,
                    color: kPrimaryColor,
                  ),
                  hintText: "City/Area",
                  border: InputBorder.none,
                  ),
                  onSaved: (value) => _cityarea = value,
                ),
              ),
              
              TextFieldContainer(
                child:TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter some value";
                  }
                  return null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.my_location,
                    color: kPrimaryColor,
                  ),
                  hintText: "State",
                  border: InputBorder.none,
                ),
                onSaved: (value) => _state = value,
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
                width: size.width * 0.50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: kPrimaryLightColor,
                    onPressed: _upload,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Icon(Icons.file_upload, color: kPrimaryColor),
                        ),
                        SizedBox(width:size.width*0.035),
                        Text(
                        "Upload Aadhar",style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    )
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
                    color: kPrimaryColor,

                    onPressed: () async{
                      String useruid = await validateAndSubmit(context);
                      print("apna Userid: "+ useruid);
                      if(useruid != "Error while Registering User!!" && useruid != "Error in Validation!!" && useruid != "OTP Verification failed!!"){
                        Navigator.pop(context);
                        Navigator.push(context , MaterialPageRoute(builder: (context) => RoleSelection(name: _name, email: _email, contactno: _contactno,state:  _state, city: _cityarea,password: _password)));
                    }
                    else{
                      print('OTP verification failed!!');
                    }
                    },
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: size.height * 0.03),

            ],
          ),
        )
      ),
    );
  }

  _upload() async{
      FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
      setState(() {
        if(result != null) {
          List<File> files = result.paths.map((path) => File(path)).toList();
          for(int i=0;i<files.length;i++){
            print(files[i].path);
          }
        } else {
          // User canceled the picker
        }
      });
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

  Future<String> _showMyDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('OTP Verification'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _c,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.one_k_plus,
                      color: kPrimaryColor,
                    ),
                    hintText: "Enter OTP",
                    border: InputBorder.none,
                  ),
                // onChanged: (value) => enteredotp = int.parse(value),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Check OTP'),
              style: ButtonStyle(),
              onPressed: () {
                print('_c.text: '+_c.text);
                setState(() {
                  enteredotp = int.parse(_c.text);
                });
                print('Entered OTP is: '+ enteredotp.toString());
                print('Random Number is: '+ randomNumber.toString());
                if(enteredotp==randomNumber) {
                    print('Success');
                    outputshoutput = 'Success';
                    print('Success ho gaya aur outputshoutput: '+outputshoutput);
                    Navigator.pop(context,outputshoutput);
                    
                } else {
                    print('Failed');
                    outputshoutput = 'Failure';
                    print('Fail ho gaya aur outputshoutput: '+outputshoutput);
                    Navigator.pop(context,outputshoutput);
                }
              },
            ),
          ],
        );
      },
    );
  }

  showErrorDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context,null);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("OTP Error"),
      content: Text("Please Enter Valid OTP"),
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

  Future<String> validateAndSubmit(BuildContext context) async{
    if(validateAndSave()){
      Random random = new Random();
      randomNumber = random.nextInt(maxNumber)+minNumber;
      otp.sendOtp(_contactno, "Your OTP is: "+ randomNumber.toString(), minNumber, maxNumber, countryCode);
      print("OTP Sent");
      String outputshoutput = await _showMyDialog(context);
      print("Outputshoutput: "+ outputshoutput);
      if(outputshoutput == "Success"){

        try{
          User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print("Registered user => " + user.uid);
          return user.uid;
        }
        catch(e){
          print("Error => $e");
          return "Error while Registering User!!";
        }
      }
      else{
        showErrorDialog(context);
        return "OTP Verification failed!!";
      }
    }
    else{
      return "Error in Validation!!";
    }

  }

  
}



