import 'package:Helper_Hiring_System/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart'; 

class HistInDetail extends StatefulWidget {
  final BaseAuth auth;
  final List helper_data_new;
  HistInDetail({Key key, this.auth, this.helper_data_new}) : super(key: key);

  @override
  _HistInDetailState createState() => _HistInDetailState();
}

class _HistInDetailState extends State<HistInDetail> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String category = "";
  String _city = "";
  String _state = "";
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

  @override
  Widget build(BuildContext context) {
    print("Build mai aa gaya with sum = "+sum.toString()+" and len = "+len.toString());
    _makingPhoneCall() async {
    String url = 'tel:'+ widget.helper_data_new[12]; 
    if (await canLaunch(url)) { 
      await launch(url); 
    } else { 
      throw 'Could not launch $url'; 
    } 
  }

    Size size = MediaQuery.of(context).size;
    // if(widget.helper_data_new[11][0]=='h'){
    //   category="House Help";
    // }
    // else if(widget.helper_data_new[11][0]=='o'){
    //   category="Office Help";
    // }
    // else if(widget.helper_data_new[11][0]=='p'){
    //   category="Patient Care";
    // }
    // else if(widget.helper_data_new[11][0]=='c'){
    //   category="Cook";
    // }
    // else if(widget.helper_data_new[11][0]=='e'){
    //   category="Elderly Care";
    // }
    // else if(widget.helper_data_new[11][0]=='b'){
    //   category="BabySitting";
    // }
    
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
                                widget.helper_data_new[11],
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
                                    (sum/len).toStringAsFixed(2),
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 16,
                                      letterSpacing: 1.25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.star, color: Colors.amber[700]),
                                  Text(
                                    " ("+(len).toString() + " reviews)",
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
                    onPressed: (){
                      _makingPhoneCall();
                    },
                    child: Text(
                      '+91 - ' + widget.helper_data_new[12],
                      style: TextStyle(color: Colors.white, fontSize: 18),
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

  Future<void> getinfo() async {
    print("inside get info");
    await FirebaseFirestore.instance
    .collection('helper')
    .doc(widget.helper_data_new[15])
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

  void _showRatingAppDialog() {
  final _ratingDialog = RatingDialog(
    accentColor: Colors.amber,
    title: 'Rate '+widget.helper_data_new[1],
    description: 'Rate '+widget.helper_data_new[1]+" and let others know how satisfied were you with his/her service.",
    icon: Image.asset("assets/images/helperApplogo.png",
      height: 100,),
    submitButton: 'Submit',
    onSubmitPressed: (response) async {
      print('rating: ${response}');
      final user = await widget.auth.currentUser();
      FirebaseFirestore.instance
      .collection('helper')
      .doc(widget.helper_data_new[15])
      .collection('feedback')
      .doc(user)
      .set({
        'rating':response
      });
      print("rating set");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HistInDetail(auth: widget.auth, helper_data_new: widget.helper_data_new)));
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
}
