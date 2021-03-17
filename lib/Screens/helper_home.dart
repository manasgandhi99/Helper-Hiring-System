// import 'dart:html';
// import 'dart:ui';
import 'package:Helper_Hiring_System/components/already_have_an_account_acheck.dart';
import 'package:Helper_Hiring_System/components/text_field_container.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../auth.dart';
import '../constants.dart';

class HelperHome extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  HelperHome({this.auth,this.onSignedOut});

  @override
  _HelperHomeState createState() => _HelperHomeState();
}

class _HelperHomeState extends State<HelperHome> {
  String _chosenValue;
  String _address = '';
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
  // File file;

  TextEditingController _c;
  @override
  initState(){
    _c = new TextEditingController();
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
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
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                // validator: (value){
                //   if(value.isEmpty){
                //     return "Please enter some value";
                //   }
                //   else{
                //     Pattern pattern =
                //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                //     RegExp regex = new RegExp(pattern);
                //     if (!regex.hasMatch(value))
                //       return 'Enter Valid Email';
                //   }
                //   return null;
                // },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: kPrimaryColor,
                  ),
                  hintText: "Address",
                  border: InputBorder.none,
                ),
                onSaved: (value) => _address = value,
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
                  hintText: "Religion",
                  border: InputBorder.none,
                ),
                onSaved: (value) => _state = value,
              ),
                // child: stateDropdown(context), 
              ),
              
              TextFieldContainer(
                child: Container(
                  child:Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_outline_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: size.width*0.04),
                      DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _chosenValue,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          'Male',
                          'Female',
                          'Others',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color: Colors.grey),),
                          );
                        }).toList(),
                        hint:Text(
                              "Gender",
                              style: TextStyle(
                                  color: Colors.grey[12],
                                  fontSize: 16,
                              ),
                            ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              TextFieldContainer(
                child: Container(
                  child:Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_outline_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: size.width*0.04),
                      DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _chosenValue,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          'Married',
                          'Unmarried',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color: Colors.grey),),
                          );
                        }).toList(),
                        hint:Text(
                              "Marital Status",
                              style: TextStyle(
                                  color: Colors.grey[12],
                                  fontSize: 16,
                              ),
                            ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              TextFieldContainer(
                child: Container(
                  child:Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_outline_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: size.width*0.04),
                      DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _chosenValue,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          'House Help',
                          'Babysitting',
                          'Patient Care',
                          'Office Help',
                          'Elderly Care',
                          'Cook',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color: Colors.grey),),
                          );
                        }).toList(),
                        hint:Text(
                              "Category",
                              style: TextStyle(
                                  color: Colors.grey[12],
                                  fontSize: 16,
                              ),
                            ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        },
                      ),
                    ],
                  ),
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
                  hintText: "Years Of Experience",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                onSaved: (value) => _password = value,
              ),
              ),

              TextFieldContainer(
                child: Container(
                  child:Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_outline_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: size.width*0.04),
                      DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _chosenValue,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          'Less than 2',
                          '2-4',
                          '4-6',
                          'More than 6',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color: Colors.grey),),
                          );
                        }).toList(),
                        hint:Text(
                              "Duration (hrs per day)",
                              style: TextStyle(
                                  color: Colors.grey[12],
                                  fontSize: 16,
                              ),
                            ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        },
                      ),
                    ],
                  ),
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
                  hintText: "Expected Salary",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                onSaved: (value) => _password = value,
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
                  hintText: "Language",
                  icon: Icon(
                    Icons.lock,
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
                    onPressed: (){},
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



              // Container(
              //     child:DropdownButton<String>(
              //     focusColor:Colors.white,
              //     value: _chosenValue,
              //     //elevation: 5,
              //     style: TextStyle(color: Colors.white),
              //     iconEnabledColor:Colors.black,
              //     items: <String>[
              //       'Male',
              //       'Female',
              //       'Others',
              //     ].map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value,style:TextStyle(color:Colors.black),),
              //       );
              //     }).toList(),
              //     hint:Text(
              //       "Please choose a gender",
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w500),
              //     ),
              //     onChanged: (String value) {
              //       setState(() {
              //         _chosenValue = value;
              //       });
              //     },
              //   ),
              // ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,

                    onPressed: () async{
                      // _c.clear();
                      // String useruid = await validateAndSubmit(context);
                      // print("Signup wala Userid: "+ useruid);
                      // if(useruid != "Error in Validation!!" && useruid != "OTP Verification failed!!" && useruid != "Upload Aadhar field empty!!"){
                      //   Navigator.pop(context);
                      //   Navigator.push(context , MaterialPageRoute(builder: (context) => RoleSelection(auth:widget.auth ,name: _name, email: _email, contactno: _contactno,state:  _state, city: _cityarea,password: _password, file:file)));
                      //   }
                      //   else{
                      //     print('OTP verification failed!!');
                      //   }
                    },
                    child: Text(
                      "POST",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return LoginScreen();
                  //     },
                  //   ),
                  // );
                },
              ),

              SizedBox(height: size.height * 0.03),

            ],
          ),
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