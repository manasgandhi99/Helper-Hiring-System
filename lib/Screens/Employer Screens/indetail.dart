import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:awesome_dialog/awesome_dialog.dart';

class InDetail extends StatefulWidget {
  final List helper_data_new;
  InDetail({Key key, this.helper_data_new}) : super(key: key);

  @override
  _InDetailState createState() => _InDetailState();
}

class _InDetailState extends State<InDetail> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String category = "";

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _makingPhoneCall() async {
    String url = 'tel:'+ widget.helper_data_new[12]; 
    if (await canLaunch(url)) { 
      await launch(url); 
    } else { 
      throw 'Could not launch $url'; 
    } 
  }

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
                    Container(
                      child: Center(
                          child:Text("Feedback"),
                      ),
                    )
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
                    labelText: 'Expected Salary',
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