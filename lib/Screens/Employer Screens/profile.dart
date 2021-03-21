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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'dart:io';
import '../../auth.dart';
import '../../constants.dart';


class Profile extends StatefulWidget {
  final BaseAuth auth;
  Profile({this.auth});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  String imageUrl = "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
  
  String fileurl;
  String _name = '';
  String _contactno = '';
  String _city;
  String _state;
  String _email;

  String _autostate;
  String _autocity;
  String _autoemail;
  String _autoname = '';
  String _autocontactno = '';
  
  // String gender;

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
  TextEditingController _emailcontroller;
  TextEditingController _citycontroller;
  TextEditingController _statecontroller;
  
  @override
  initState(){
    _c = new TextEditingController();
    autofill();
    super.initState();
  }

  // Future<void> callAutofill() async{
  //   await autofill();
  // }

  @override
  void dispose() {
    _namecontroller.dispose();
    _contactnocontroller.dispose();
    _emailcontroller.dispose();
    _citycontroller.dispose();
    _statecontroller.dispose();
    super.dispose();
  }
  
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
        automaticallyImplyLeading: true,
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

                

                SizedBox(height: size.height * 0.04), 

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
                  controller: _emailcontroller,
                  readOnly: true,
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
                  controller: _citycontroller,
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
                    hintText: "City",
                    border: InputBorder.none,
                  ),
                  onSaved: (value) => _city = value,
                ),
                  // child: stateDropdown(context), 
                ),

                SizedBox(height: size.height * 0.03),
                  
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
        Navigator.pop(context);
        Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth: widget.auth,)));
      },
      
      // btnCancelOnPress: () {},
      btnOkIcon: Icons.check_circle,
      // btnCancelIcon: Icons.cancel,
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
        FirebaseFirestore.instance.collection('employer').doc(user).collection('profile').doc(user)
        .snapshots().listen((data)  {
          setState(() {
            imageUrl = data.data()['photo'];
            _autoname = data.data()['name'];
            _autocontactno = data.data()['contact no'];
            _autoemail = data.data()['email'];
            _autostate = data.data()['state'];
            _autocity = data.data()['city'];

            print('autofill Name: $_autoname');
            print('autofill Phone Number: $_autocontactno');
            print('autofill Email: $_autoemail');
            print('autofill State: $_autostate');
            print('autofill City: $_autocity');

            _namecontroller = TextEditingController(text: _autoname);
            _contactnocontroller = TextEditingController(text: _autocontactno);
            _emailcontroller = TextEditingController(text: _autoemail);
            _statecontroller = TextEditingController(text: _autostate);
            _citycontroller = TextEditingController(text: _autocity);
    
          });
        }
      );
    }
      catch(e){
        print("Error: " + e);
    }
  }
  

  Future<String> validateAndSubmit(BuildContext context) async{
    if(validateAndSave()){
      // print("File ka value is: "+file.path);
      // bool filepath = await file.exists();
      // print("File ka string value is: "+ (filepath.toString()));
      // if else for each dropdown
      
      print("Val and sub k andar ka phone no.: "+ _autocontactno);
      print("Val and sub k andar ka contact no.: "+ _contactno);
      if(_autocontactno == _contactno){
        
        setValue();        
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
          setValue();
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

  // Future<void> getData() async {
  //   final user = await widget.auth.currentUser();
  //   print(user);
    
  //   FirebaseFirestore.instance.collection('employer').where('email', isEqualTo: user)
  //     .snapshots().listen((data)  {
  //       _city = data.docs[0]['city'];
  //       _state = data.docs[0]['state'];
  //       print('City: $_city');
  //       print('State: $_state');
  //       setValue();
  //     }
  //   );
  // }
  
  Future<void> setValue() async {
    try{
      final user = await widget.auth.currentUser();
      print(user);

      await FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .update(
        {'name': _name,'contact no': _contactno, 'city': _city, 'email': user, 
         'state': _state});

      await FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('profile')
        .doc(user)
        .update(
        {'name': _name,'contact no': _contactno, 'city': _city, 'email': user, 'photo': imageUrl, 
         'state': _state});
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