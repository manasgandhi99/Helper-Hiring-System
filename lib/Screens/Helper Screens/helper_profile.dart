import 'dart:math';
import 'package:Helper_Hiring_System/Screens/Login/components/background.dart';
import 'package:Helper_Hiring_System/components/already_have_an_account_acheck.dart';
import 'package:Helper_Hiring_System/components/text_field_container.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'dart:io';
import '../../auth.dart';
import '../../constants.dart';


class HelperProfile extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  HelperProfile({this.auth, this.onSignedOut});

  @override
  _HelperProfileState createState() => _HelperProfileState();
}

class _HelperProfileState extends State<HelperProfile> {
  String _gender;
  String _maritalstatus;
  String imageUrl = "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
  String _category;
  String fileurl;
  String _newcategory;
  String _diffcategory;
  String _duration;
  String _yoe;

  String _address = '';
  String _expectedsalary = '';
  String _name = '';
  String _contactno = '';
  String _languages = '';
  String _religion = '';
  String _age = '';
  String _password = '';
  String _city = '';
  String _state = '';

  String _autoname = '';
  String _autocontactno = '';
  String _autoaddress = '';
  String _autocity = '';
  String _autostate = '';
  String _autoage = '';
  String _autoreligion = '';
  String _autoexpectedsalary = '';
  String _autolanguages = '';
  int len=0, sum=0;
  
 
  // String gender;

  var yoelist = new List<String>.generate(50, (i) => (i + 1).toString());
  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode ="+91";
  int enteredotp = 0;
  int randomNumber;
  String outputshoutput='';
  File file;

  FlutterOtp otp = FlutterOtp();

  TextEditingController _c;
  TextEditingController _namecontroller; 
  TextEditingController _contactnocontroller;
  TextEditingController _addresscontroller;
  TextEditingController _citycontroller;
  TextEditingController _statecontroller;
  TextEditingController _agecontroller;
  TextEditingController _religioncontroller; 
  TextEditingController _expectedsalarycontroller;
  TextEditingController _languagescontroller; 
  
  @override
  initState(){
    _c = new TextEditingController();
    autofill();
    getdata();
    super.initState();
  }

  Future<void> getdata() async {
    print("Get data k andar aaya ");
    await getinfo();
  }

  Future<void> getinfo() async {
    final user = await widget.auth.currentUser();
    await FirebaseFirestore.instance
    .collection('helper')
    .doc(user)
    .collection('feedback')
    .get()
    .then((QuerySnapshot querySnapshot) {
      len = querySnapshot.docs.length;
      print("Lenght mila: "+len.toString());
        querySnapshot.docs.forEach((doc) {
            sum = sum + doc["rating"];
            print("Sum ki value: "+sum.toString());
        });
        setState(() {
          sum=sum;
          len=len;
        });
    });
  }

  // Future<void> callAutofill() async{
  //   await autofill();
  // }

  // @override
  // void dispose() {
  //   _namecontroller.dispose();
  //   _contactnocontroller.dispose();
  //   _addresscontroller.dispose();
  //   _citycontroller.dispose();
  //   _statecontroller.dispose();
  //   _agecontroller.dispose();
  //   _religioncontroller.dispose();
  //   _expectedsalarycontroller.dispose();
  //   _languagescontroller.dispose();
  //   super.dispose();
  // }

  void _signOut(BuildContext context) async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } 
    catch (e) {
      print("Error in Signout!!");
      print(e);
    }
  }
  
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    if(_category=="House Help") {
      _newcategory = "house_help";
    }
    else if(_category=="Office Help"){ 
      _newcategory = "office_help";
    }
    else if(_category=="Patient Care") {
      _newcategory = "patient_care";
    }
    else if(_category=="BabySitting") {
      _newcategory = "babysitting";
    }
    else if(_category=="Elderly Care") {
      _newcategory = "elderly_care";
    }
    else if(_category=="Cook") {
      _newcategory = "cook";
    }
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "PROFILE",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
          )
        ),
        // Text(
        // "Profile",
        // style: TextStyle(fontSize: 20.0,),
        // ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
            FlatButton(
                onPressed: () => {
                  // Navigator.pop(context),
                  _signOut(context),
                },
                padding: EdgeInsets.only(top: size.height*0.006),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.logout,color: kPrimaryColor,),
                    Text(
                      "Logout",
                      style: GoogleFonts.montserrat(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor
                      )
                    ),
                  ],
                ),
              ),
        ],
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
              child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: size.height * 0.03), 

                // Text(
                // "PROFILE",
                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                // ),

                // SizedBox(height: size.height * 0.03), 

                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child:CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: size.width * 0.17,
                          child: CircleAvatar(
                            radius: size.width * 0.16,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: size.width * 0.15,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                          ),
                        ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(230, 80, 120, 0),
                          height: size.width * 0.1,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            heightFactor: size.width * 0.5,
                            widthFactor: size.width * 0.05,
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: kPrimaryColor,
                              size: ScreenUtil().setSp(size.width * 0.06),
                            ),
                          ),
                        ),
                        onTap: () {
                          print("HELLO");
                          _upload();
                        },
                      ), 
                    ),
                  ],
                ),
              
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    len==0?Text(
                      "Rating: 0",
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 16,
                        letterSpacing: 1.25,
                        color: Colors.black,
                      ),
                    ) :
                    Text(
                      "Rating: "+(sum/len).toString(),
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 16,
                        letterSpacing: 1.25,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber[700]),
                    Text(
                      " ("+(len).toString()+" reviews)",
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 16,
                        letterSpacing: 1.25,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),
                TextFieldContainer(
                  child:TextFormField(
                  controller: _namecontroller,
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
                  controller: _contactnocontroller,
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
                  controller: _addresscontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    else{
                      if(value.length < 5){
                        return "Minimum length must be 5";
                      }
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_on_sharp,
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
                  controller: _citycontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    else{
                      if(value.length < 2){
                        return "Minimum length must be 2";
                      }
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_city,
                      color: kPrimaryColor,
                    ),
                    hintText: "City",
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _city = value,
                ),
                ),

                TextFieldContainer(
                  child:TextFormField(
                  controller: _statecontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    else{
                      if(value.length < 2){
                        return "Minimum length must be 2";
                      }
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.my_location_sharp,
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
                  controller: _agecontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    else{
                      if(value.length < 2){
                        return "Minimum length must be 2";
                      }
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.perm_contact_calendar_sharp,
                      color: kPrimaryColor,
                    ),
                    hintText: "Age",
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _age = value,
                ),
                ),
                
                TextFieldContainer(
                  child:TextFormField(
                  controller: _religioncontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.group_rounded,
                      color: kPrimaryColor,
                    ),
                    hintText: "Religion",
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _religion = value,
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
                        DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _gender,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,
                            // validator: (value) => value == null ? 'field required' : null,
                            items: <String>[
                              'Male',
                              'Female',
                              'Others',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            hint:Row(
                              children: <Widget>[
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      color: Colors.grey[12],
                                      fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: size.width*0.445),
                              ]
                            ),
                            
                            onChanged: (String value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        )
                        
                      ],
                    ),
                  ),
                ),

                TextFieldContainer(
                  child: Container(
                    child:Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_search_rounded,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: size.width*0.04),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _maritalstatus,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,
                            items: <String>[
                              'Married',
                              'Unmarried',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            hint:Row(
                              children: <Widget>[
                                Text(
                                  "Marital Status",
                                  style: TextStyle(
                                      color: Colors.grey[12],
                                      fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: size.width*0.3),
                              ]
                            ),
                            onChanged: (String value) {
                              setState(() { 
                                _maritalstatus = value;
                              });
                            },
                          ),
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _category,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,
                            items: <String>[
                              'House Help',
                              'BabySitting',
                              'Patient Care',
                              'Office Help',
                              'Elderly Care',
                              'Cook',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            hint:Row(
                              children: <Widget>[
                                Text(
                                  "Category of Work",
                                  style: TextStyle(
                                      color: Colors.grey[12],
                                      fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: size.width*0.23),
                              ]
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _category = value;
                              });
                            },
                          ),
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
                          Icons.assignment_ind,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: size.width*0.04),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _yoe,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,
                            items: yoelist.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            hint:Row(
                                  children: <Widget>[
                                    Text(
                                      "Years of Experience",
                                      style: TextStyle(
                                          color: Colors.grey[12],
                                          fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: size.width*0.18),
                                  ]
                                ),
                            onChanged: (String value) {
                              setState(() {
                                _yoe = value;
                              });
                            },
                          ), 
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
                          Icons.timer_sharp,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: size.width*0.04),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _duration,
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
                                child: Text(value,style:TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            hint:Row(
                                  children: <Widget>[
                                    Text(
                                      "Duration (hours per day)",
                                      style: TextStyle(
                                          color: Colors.grey[12],
                                          fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: size.width*0.088),
                                  ]
                                ),
                            onChanged: (String value) {
                              setState(() {
                                _duration = value;
                              });
                            },
                          ), 
                        ), 
                      ],
                    ),
                  ),
                ),

                TextFieldContainer(
                  child:TextFormField(
                  controller: _expectedsalarycontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    else{
                      if(value.length < 3){
                        return "Minimum 3 characters atleast";
                      }
                    }
                    return null;
                  },
                  
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText: "Expected Salary (Per Day)",
                    icon: Icon(
                      Icons.money,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _expectedsalary = value,
                ),
                ),

                TextFieldContainer(
                  child:TextFormField(
                  controller: _languagescontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some value";
                    }
                    return null;
                  },
                  
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText: "Languages",
                    icon: Icon(
                      Icons.language,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _languages = value,
                ),
                ),
                  
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,

                      onPressed: () async{
                        _c.clear();
                        // phoneNo();
                        String useruid = await validateAndSubmit(context);
                        print("Profile dikhane wala Userid: "+ useruid);
                        if(useruid != "Error in Validation!!" && useruid != "OTP Verification failed!!" && useruid != "Upload Aadhar field empty!!"){
                          // Navigator.pop(context);
                          showdialog(context);
                          }
                          else{
                            print('OTP verification failed!!');
                          }
                      },
                      child: Text(
                        "SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

              ],
            ),
          ),
        ),
      ),
    );
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
                      Icons.lock,
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
              child: Text('Check OTP', style: TextStyle(color: kPrimaryColor),),
              style: ButtonStyle(),
              onPressed: () {
                print('_c.text: '+_c.text);
                setState(() {
                  if(_c.text == ""){
                    enteredotp = 20;
                  }
                  else{
                    enteredotp = int.parse(_c.text);
                  }
                });
                print('Entered OTP is: '+ enteredotp.toString());
                print('Random Number is: '+ randomNumber.toString());
                if(enteredotp==randomNumber) {
                    print('Success');
                    outputshoutput = 'Success';
                    print('Success ho gaya aur outputshoutput: '+outputshoutput);
                    _c.clear();
                    Navigator.pop(context,outputshoutput);
                    
                } else {
                    print('Failed');
                    outputshoutput = 'Failure';
                    print('Fail ho gaya aur outputshoutput: '+outputshoutput);
                    _c.clear();
                    Navigator.pop(context,outputshoutput);
                }
              },
            ),
          ],
        );
      },
    );
  }

  showdialog(BuildContext context){
    return AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      title: 'Congratulations',
      desc:'Your Profile is updated Successfully!',
      btnOkOnPress: () {
        // Navigator.pop(context);
        // Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth: widget.auth,)));
      },
      
      btnOkIcon: Icons.check_circle,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      onDissmissCallback: () {
        debugPrint('Dialog Dismiss from callback');
      })
    ..show();
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

  Future<void> autofill() async{
    try{
        final user = await widget.auth.currentUser();
        print(user); 
        FirebaseFirestore.instance.collection('helper').doc(user).collection('profile').doc(user)
        .snapshots().listen((data)  {
          setState(() {
            imageUrl = data.data()['photo'];
            _autoname = data.data()['name'];
            _autocontactno = data.data()['contact no'];
            _autoaddress = data.data()['address'];
            _autocity = data.data()['city'];
            _autostate = data.data()['state'];
            _autoage = data.data()['age'];
            _autoreligion = data.data()['religion'];
            _gender = data.data()['gender'];
            _maritalstatus = data.data()['marital status'];
            _diffcategory = data.data()['category'];
            _yoe = data.data()['years of experience'];
            _duration = data.data()['duration'];
            _autoexpectedsalary = data.data()['exp salary'];
            _autolanguages = data.data()['language'];

            if(_diffcategory=="house_help") {
              _category = "House Help";
            }
            else if(_diffcategory=="office_help"){ 
              _category = "Office Help";
            }
            else if(_diffcategory=="patient_care") {
              _category = "Patient Care";
            }
            else if(_diffcategory=="babysitting") {
              _category = "BabySitting";
            }
            else if(_diffcategory=="elderly_care") {
              _category = "Elderly Care";
            }
            else if(_diffcategory=="cook") {
              _category = "Cook";
            }

            print('Image ka url mila: $imageUrl');
            print('autofill Name: $_autoname');
            print('autofill Phone Number: $_autocontactno');
            print('autofill Address: $_autoaddress');
            print('autofill City: $_autocity');
            print('autofill State: $_autostate');
            print('autofill Age: $_autoage');
            print('autofill Religion: $_autoreligion');
            print('autofill Gender: $_gender');
            print('autofill Marital Status: $_maritalstatus');
            print('autofill Category: $_category');
            print('autofill Years of Experience: $_yoe');
            print('autofill Duration: $_duration');
            print('autofill Expected salary: $_autoexpectedsalary');
            print('autofill Languages: $_autolanguages');

            _namecontroller = TextEditingController(text: _autoname);
            _contactnocontroller = TextEditingController(text: _autocontactno);
            _addresscontroller = TextEditingController(text: _autoaddress);
            _citycontroller = TextEditingController(text: _autocity);
            _statecontroller = TextEditingController(text: _autostate);
            _agecontroller = TextEditingController(text: _autoage);
            _religioncontroller = TextEditingController(text: _autoreligion);
            _expectedsalarycontroller = TextEditingController(text: _autoexpectedsalary);
            _languagescontroller = TextEditingController(text: _autolanguages);
            
          });
        }
      );
    }
      catch(e){
        print("Error: " + e);
    }
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


  Future<String> validateAndSubmit(BuildContext context) async{
    if(validateAndSave()){      
      print("Val and sub k andar ka phone no.: "+ _autocontactno);
      print("Val and sub k andar ka contact no.: "+ _contactno);
      if(_autocontactno == _contactno){
        
        getData();        
        return "Success";
      }
      else{
        
        Random random = new Random();
        randomNumber = random.nextInt(maxNumber)+minNumber;
        otp.sendOtp(_contactno, "Your OTP is: "+ randomNumber.toString(), minNumber, maxNumber, countryCode);
        print("OTP Sent");
        String outputshoutput = await _showMyDialog(context);
        print("Outputshoutput: "+ outputshoutput);
        if(outputshoutput == "Success"){
          getData();
          return "Success";
        }
        else{
          showErrorDialog(context,"OTP Error","Please enter a valid OTP.");
          return "OTP Verification failed!!";
        }
      }
    }
    else{
      return "Error in Validation!!";
    }

  }

  Future<void> getData() async {
    final user = await widget.auth.currentUser();
    print(user);
    
    FirebaseFirestore.instance.collection('helper').where('email', isEqualTo: user)
      .snapshots().listen((data)  {
        // _city = data.docs[0]['city'];
        // _state = data.docs[0]['state'];
        _password = data.docs[0]['password'];
        // print('City: $_city');
        // print('State: $_state');
        setValue();
      }
    );
  }
  
  Future<void> setValue() async {
    try{
      final user = await widget.auth.currentUser();
      print(user);
      
      await FirebaseFirestore.instance
        .collection('helper')
        .doc(user)
        .update(
        {'category': _newcategory});

      await FirebaseFirestore.instance
        .collection('helper')
        .doc(user)
        .collection('profile')
        .doc(user)
        .update(
        {'name': _name,'contact no': _contactno, 'address': _address,'age': _age, 'category': _newcategory, 'city': _city, 'duration': _duration, 
         'email': user, 'exp salary': _expectedsalary, 'gender': _gender, 'language': _languages, 'marital status': _maritalstatus, 'photo': imageUrl, 
         'religion': _religion, 'state': _state, 'years of experience': _yoe, 'password': _password});
    }
    catch(e){
      print("Error: " + e);
    }
    
  }

  _upload() async{
      FilePickerResult result = await FilePicker.platform.pickFiles();
      if(result != null) {
          file = File(result.files.single.path);
          print("File path from upload func: "+file.path);
          fileurl = await uploadFiles(file);
      }
      setState((){
      });
  }

  Future<String> uploadFiles(File _image) async {
    print("Upload docs wala user\n");
    final user = await widget.auth.currentUser();
    print(user);
    String imageRef = user + '/' + _image.path.split('/').last;
    print(imageRef);
    imageUrl = await (await FirebaseStorage.instance.ref(imageRef).putFile(_image)).ref.getDownloadURL();
    print(imageUrl);
    return imageUrl;
  }
}