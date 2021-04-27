import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:Helper_Hiring_System/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:rating_dialog/rating_dialog.dart';

class InDetail extends StatefulWidget {
  final BaseAuth auth;
  final List helper_data_new;
  InDetail({Key key, this.auth, this.helper_data_new}) : super(key: key);

  @override
  _InDetailState createState() => _InDetailState();
}

class _InDetailState extends State<InDetail> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String category = "";
  String _name = "";
  String _photo = "";
  String _city = "";
  String _state = "";
  String _contactno = "";
  List <String> userToken = [];
  String employername = "";
  int sum = 0;
  int len = 0;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    print("Get data k andar aaya ");
    await getinfo();
  }

  Future<void> getinfo() async {
    await FirebaseFirestore.instance
    .collection('helper')
    .doc(widget.helper_data_new[13])
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

  @override
  Widget build(BuildContext context) {
    print("Build mai aa gaya with sum = "+sum.toString()+" and len = "+len.toString());
    Size size = MediaQuery.of(context).size;
    if(widget.helper_data_new[11][0]=='h'){
      category="House Help";
    }
    else if(widget.helper_data_new[11][0]=='o'){
      category="Office Help";
    }
    else if(widget.helper_data_new[11][0]=='p'){
      category="Patient Care";
    }
    else if(widget.helper_data_new[11][0]=='c'){
      category="Cook";
    }
    else if(widget.helper_data_new[11][0]=='e'){
      category="Elderly Care";
    }
    else if(widget.helper_data_new[11][0]=='b'){
      category="BabySitting";
    }
    
    return Scaffold(
       appBar: AppBar(
         title: Text("Helper Details"),
       ),
       backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(height:size.height*0.02),

                // Container(
                // width: size.width*0.95,
                // // color: Colors.blue[100],
                // padding: EdgeInsets.fromLTRB(size.width*0.03,size.width*0.02,size.width*0.03,size.width*0.02),
                // decoration: BoxDecoration(
                //   color: kPrimaryLightColor,0
                  
                //   border: Border.all(
                //     color: Colors.black,
                //     width: 2,
                //   ),
                //   borderRadius: BorderRadius.circular(30),
                // ),
                // child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          CircleAvatar
                          (
                            backgroundColor: Colors.black,
                            radius: 55.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget.helper_data_new[0]),
                                radius: 45,
                              ),
                            ),
                          ),
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                              padding: EdgeInsets.all(10.0),
                              child:Text(
                              widget.helper_data_new[1],
                                style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black,                          
                                ),
                                softWrap: true,
                              ),),
                              
                              Text(
                                category,
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 17.0,
                                  letterSpacing: 1.25,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  len==0?Text(
                                    "0",
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                      color: Colors.black,
                                    ),
                                  ) :
                                  Text(
                                    (sum/len).toString(),
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.star, color: Colors.amber[700]),
                                  Text(
                                    " ("+(len).toString()+" reviews)",
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                // ),
               
                
              SizedBox(height:size.height*0.01),

              TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: kPrimaryColor,
                indicatorColor: kPrimaryColor,
                tabs: [
                  Tab(
                    text: 'Profile', 
                    icon: Icon(Icons.person_pin_rounded)
                  ),
                  Tab(
                    text: 'Feedback',
                    icon: Icon(Icons.feedback_rounded)
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    profileDetail(size),
                    feedbackDetail(size),
                    // Container(
                    //   child: Center(
                    //       child:Text("Feedback"),
                    //   ),
                    // )
                  ],
                  controller: _tabController,
                ),
              ),

            SizedBox(height:size.height*0.01),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () async{
                      print("Tab Number: ");
                      print(_tabController.index.toString());
                      sethistorydata();
                      await getemployerdata();
                      await getemployername();
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        title: '+91 ' + widget.helper_data_new[12],
                        desc:
                             'Would you like to call now ?',
                        btnOkOnPress: () {
                          _makingPhoneCall();
                        },
                        
                        btnCancelOnPress: () {},
                        btnOkIcon: Icons.check_circle,
                        btnCancelIcon: Icons.cancel,
                        onDissmissCallback: () {
                          debugPrint('Dialog Dismiss from callback');
                        })
                      ..show();
                    },
                    child: Text(
                      "Get Contact Number",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

            SizedBox(height:size.height*0.01),
          ]),

        )
      )
    );
  }

  void _showRatingAppDialog() {
  final _ratingDialog = RatingDialog(
    accentColor: Colors.amber,
    title: 'Rate '+widget.helper_data_new[1],
    description: 'Rate helper '+widget.helper_data_new[1]+" and let others know how satisfied were you with his/her service.",
    icon: Image.asset("assets/images/helperApplogo.png",
      height: 100,),
    submitButton: 'Submit',
    onSubmitPressed: (response) async {
      print('rating: ${response}');
      final user = await widget.auth.currentUser();
      FirebaseFirestore.instance
      .collection('helper')
      .doc(widget.helper_data_new[13])
      .collection('feedback')
      .doc(user)
      .set({
        'rating':response
      });
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail(auth: widget.auth, helper_data_new: widget.helper_data_new)));
      // if (response.rating < 3.0) {
      //   print('response.rating: ${response.rating}');
      // } else {
      //   Container();
      // }
    },
  );

  showDialog(
    context: context,
    barrierDismissible: true, 
    builder: (context) => _ratingDialog,
  );
}

  Future<void> getemployername() async{
    final user = await widget.auth.currentUser();
    await FirebaseFirestore.instance
    .collection('employer')
    .doc(user)
    .collection('profile')
    .doc(user)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()['name']}');
        employername = documentSnapshot.data()['name'];
        callOnFcmApiSendPushNotifications();
      } else {
        print('Document does not exist on the database');
      }
    });

  }

  Future<void> callOnFcmApiSendPushNotifications() async {
    print("Insisde call in fcm api function");
    final user = await widget.auth.currentUser();
    await FirebaseFirestore.instance
    .collection('helper')
    .doc(widget.helper_data_new[13])
    .collection('tokens')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["token"]);
            userToken.add(doc["token"]);
        });
    });

    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids" : userToken,
      "collapse_key" : "type_a",
      "notification" : {
        "title": 'New Job Opportunity!!',
        "body" : employername + ' has tried to extract your number!',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': firebaseTokenAPIFCM // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
    } else {
      print(' CFM error');
      // on failure do sth
    }
}

   _makingPhoneCall() async {
    String url = 'tel:'+ widget.helper_data_new[12]; 
    if (await canLaunch(url)) { 
      await launch(url); 
    } else { 
      throw 'Could not launch $url'; 
    } 
  }

  Future<void> sethistorydata() async{
      try{
        final user = await widget.auth.currentUser();
        print(user);

        // await FirebaseFirestore.instance.collection('employer').where('email', isEqualTo: user)
        // .snapshots().listen((data)  {
        //   _city = data.docs[0]['city'];
        //   _state = data.docs[0]['state'];
        //   print('City: $_city');
        //   print('State: $_state');
        // }
        
        // );

        await FirebaseFirestore.instance.collection('employer').doc(user).collection('history').doc(widget.helper_data_new[13])
        .set(
          {'name': widget.helper_data_new[1],'contact no': widget.helper_data_new[12], 'address': widget.helper_data_new[5],'age': widget.helper_data_new[2], 'category': category, 'city': widget.helper_data_new[14], 'duration': widget.helper_data_new[6], 
          'exp salary': widget.helper_data_new[7], 'gender': widget.helper_data_new[3], 'language': widget.helper_data_new[10], 'marital status': widget.helper_data_new[9], 'photo': widget.helper_data_new[0], 
          'religion': widget.helper_data_new[8], 'state': widget.helper_data_new[15], 'years of experience': widget.helper_data_new[4]}
        );
      }
      catch(e){
        print("Error :" + e.toString());
      }
  }

  Future<void> getemployerdata() async{
    try{
      final user = await widget.auth.currentUser();
      print(user);

      await FirebaseFirestore.instance.collection('employer').doc(user).collection('profile').where('email', isEqualTo: user)
      .snapshots().listen((data)  {
        _photo = data.docs[0]['photo'];
        _name = data.docs[0]['name'];
        _contactno = data.docs[0]['contact no'];
        
        print('Photu: $_photo');
        print('Name: $_name');
        print('Contact No: $_contactno');

        setemployerdata();
      }
      );
      
    }
    catch(e){
      print("Error :" + e.toString());
    }
  }

  Future<void> setemployerdata() async{
    try{
      final user = await widget.auth.currentUser();
      print(user);

      await FirebaseFirestore.instance.collection('helper').doc(widget.helper_data_new[13]).collection('notification').doc(user)
      .set(
        {'name': _name,'contact no': _contactno, 'photo': _photo, 'city': widget.helper_data_new[14], 'state': widget.helper_data_new[15]}
      );
    }
    catch(e){
      print("Error :" + e.toString());
    }
  }

  Widget feedbackDetail(Size size) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
          padding: EdgeInsets.fromLTRB(size.width * 0.05 ,size.height*0, size.width * 0.05, size.height*0),
          child: Image.asset(
                "assets/images/feedback.png",
                height: size.height * 0.3,
          ),
        ),

        SizedBox(height: size.height * 0.008),

        Text(
          "Kindly Submit your Feedback.",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
                  ),
        ),

        SizedBox(height: size.height * 0.035),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.amber[700],
              onPressed: () {
                _showRatingAppDialog();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feedback, color: Colors.white,),
                  SizedBox(width: size.width*0.03),
                  Text(
                    "Give Feedback",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ],
      ),
    );
  }

  Widget profileDetail(Size size) {
     
    return SingleChildScrollView(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Container(
            
            margin: EdgeInsets.all(11.0),
            width: size.width*0.8,
            padding: EdgeInsets.fromLTRB(size.width*0.03,size.width*0.02,size.width*0.03,size.width*0.02),
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              // borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                SizedBox(height: size.height*0.02),

                TextFormField(
                      initialValue: widget.helper_data_new[5],
                      readOnly: true,
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        
                    ),
                  ),
              
                SizedBox(height: size.height*0.02),

                TextFormField(
                  
                  initialValue: widget.helper_data_new[6]+ " hours",
                  readOnly: true,
                  enableInteractiveSelection: false,

                  decoration: InputDecoration(
                    labelText: 'Duration (Per day)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: "Rs. "+widget.helper_data_new[7]+"/-",
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Expected Salary (Per Day)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: widget.helper_data_new[8],
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Religion',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: widget.helper_data_new[9],
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Marital Status',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: widget.helper_data_new[10],
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Language',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: widget.helper_data_new[2],
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: widget.helper_data_new[3],
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.02),

                TextFormField(
                  initialValue: widget.helper_data_new[4],
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    labelText: 'Years Of Experience',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    
                  ),
                ),

                SizedBox(height: size.height*0.01),

              ],
            )
          ),
        ],
      ),
    );
  }
}
