
import 'package:Helper_Hiring_System/Widgets/customcard.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Helper_Hiring_System/constants.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../../auth.dart';
import 'profile.dart';
// import 'dart:io';
// import '../constants.dart';

class NewHome extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut; 
  NewHome({Key k, this.auth, this.onSignedOut}):super(key: k);
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {

  // void initState() { 
  //   super.initState();
  //   script();
  //   print("script run");
  // }
  
  int i = 0;
  String _city;
  String _state;
  int _selectedIndex = 0;
  String imageUrl = "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
  // var data = informationList;
  
  @override
  void initState() { 
    super.initState();
    autofill();
  }

  Future<void> autofill() async{
    try{
        final user = await widget.auth.currentUser();
        print(user); 
        FirebaseFirestore.instance.collection('employer').doc(user).collection('profile').doc(user)
        .snapshots().listen((data)  {
          setState(() {
            imageUrl = data.data()['photo'];

            print('Image ka url mila: $imageUrl');
          });
        }
      );
    }
      catch(e){
        print("Error: " + e);
    }
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.amber[300],
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Hire Helper',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          )),

                      GestureDetector(
                        child:Container(
                          margin: EdgeInsets.fromLTRB(0,0,size.width*0.06,0),
                        //       width: 60,
                        //       height: 75,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         image: DecorationImage(
                        //           image: AssetImage(assetimage),
                        //           fit: BoxFit.cover,
                        //         ),
                        //     ),
                        //   ),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                              radius: 35,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder : (context) => Profile(auth: widget.auth, )));
                        },
                      ),      

                    ],
                  ),
                )
              ),
                 
            Container(
                decoration: BoxDecoration(
                    color: Color(0xFFfafafa),
                    border: Border.all(color: Color(0xFFfafafa)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: (MediaQuery.of(context).size.height * 3) / 4 -
                    kBottomNavigationBarHeight,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'Services Offered',
                            style: GoogleFonts.roboto(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        CustomCard(      
                          header: "House Help",
                          displayImage: "assets/images/maid.jpg",
                          auth: widget.auth,
                          category :'house_help'
                        ),
                        CustomCard(      
                          header: "Cook",
                          displayImage: "assets/images/maid.jpg",
                          auth: widget.auth,
                          category :'cook'
                        ),
                        // for (i; i < 2; i++)
                        //   CustomCard(data[i][0], data[i][1], data[i][2]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // CustomCard("Kitchen", "5 lights", 'assets/images/kitchen.png'),
                        // CustomCard(
                        //     "Bathroom", "1 light", 'assets/images/bathtube.png'),
                        CustomCard(      
                          header: "Elderly Care",
                          displayImage: "assets/images/maid.jpg",
                          auth: widget.auth,
                          category :'elderly_care'
                        ),
                        CustomCard(      
                          header: "BabySitting",
                          displayImage: "assets/images/maid.jpg",
                          auth: widget.auth,
                          category :'babysitting'
                        ),
                        // for (i; i < 4; i++)
                        //   CustomCard(data[i][0], data[i][1], data[i][2]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // CustomCard("Outdoor", "5 lights", 'assets/images/house.png'),
                        // CustomCard("Balcony", "2 lights", 'assets/images/balcony.png'),
                        CustomCard(      
                          header: "Office Help",
                          displayImage: "assets/images/maid.jpg",
                          auth: widget.auth,
                          category :'office_help'
                        ),
                        CustomCard(      
                          header: "Patient Care",
                          displayImage: "assets/images/maid.jpg",
                          auth: widget.auth,
                          category :'patient_care'
                        ),
                        // for (i; i < 6; i++)
                        //   CustomCard(data[i][0], data[i][1], data[i][2]),
                  ],
                )
              ],
            ))
          ],
        ),
      ]),
      Scaffold(
        appBar: AppBar(
          title: Text('History'),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Center(child: Text("This is History Page", style: TextStyle(fontSize: 32.0))),
        ),
      ),
    
      Scaffold(
        appBar: AppBar(
          title: Text('Rate Card'),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Center(child: Text("This is Rate Card Page", style: TextStyle(fontSize: 32.0))),
        ),
      ),
  ];
    
    return Scaffold(
      // Colors.amber[300]
      backgroundColor: Colors.amber[300],
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: kPrimaryLightColor,
        selectedItemColor: kPrimaryColor,
        backgroundColor: Colors.white,
        elevation: 20.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Rate Card',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  Future<void> getData() async {
    final user = await widget.auth.currentUser();
    print(user);
    
    FirebaseFirestore.instance.collection('employer').where('email', isEqualTo: user)
    .snapshots().listen((data)  {
      _city = data.docs[0]['city'];
      _state = data.docs[0]['state'];
      print('City: $_city');
      print('State: $_state');
    }
    );
  }

  Future<void> setData(String category) async {
    print("set data me city"+_city);
    try{
      final user = await widget.auth.currentUser();
      print(user);
      await FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('filter')
        .doc(category)
        .set(
        {'city': _city,'state': _state, 'religion': "",'duration': "", 'gender': "", 'budget': "", 'yearofexp': ""});
    }
    catch(e){
      print("Error: " + e);
    }
    
  }

  
  // Future<void> script() async {
  //   List name  = ['Abhishek','Sameer','Faisal','Sandeep','Manoj','Gauri','Shruti','Payal','Shivangi','Kamala'];
  //   // List states = ['Maharashtra','Goa'];
  //   // List cities = ['Parbhani','Panji'];
  //   // List categories = ['house_help','cook'];
  //   List durations = ['Less than 2','2-4','4-6', 'More than 6'];
  //   List marriage = ['Unmarried', 'Married'];
  //   List photos = ['https://media.gettyimages.com/photos/indian-men-portrait-picture-id861530218?s=612x612','https://media.gettyimages.com/photos/farmer-standing-portrait-picture-id503733688?s=612x612','https://static3.bigstockphoto.com/6/9/7/large1500/7963525.jpg'];
  //   List femalephotos = ['https://assetsds.cdnedge.bluemix.net/sites/default/files/styles/big_5/public/feature/images/sabira_0.jpg?itok=P9GfOo9m', 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bGFkeXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr75ollz6vjM5jX3zhXmOGE_65VaT7n3rVTw&usqp=CAU'];
  //   List religions = ['Hindu', 'Muslim', 'Christian', 'Sikh'];

  //     for(int i=1;i<=10;i++){
  //       await FirebaseFirestore.instance
  //       .collection('helper')
  //       .doc(name[i-1].toLowerCase() +"@gmail.com")
  //       .set(
  //       { 
  //         'name': name[i-1],
  //         'email': name[i-1].toLowerCase() +"@gmail.com", 
  //         'password': '123456',
  //         'contact no': '7977861078', 
  //         'state': 'Maharashtra', 
  //         'city': 'Parbhani', 
  //         'category': 'house_help',
  //         'aadhar':'https://firebasestorage.googleapis.com/v0/b/helper-hiring-backend.appspot.com/o/demo12%40gmail.com%2FIMG-20210224-WA0000.jpg?alt=media&token=b0c9855d-0397-44ae-b17b-a4cd0d8ffe7f',
  //       }); 
  //     }
    
  //     for(int i=1;i<=5;i++){
        
  //       Random random = new Random();
  //       // Random random = new Random();
  //       // int randomNumber = random.nextInt(2);
  //       await FirebaseFirestore.instance
  //       .collection('helper')
  //       .doc(name[i-1].toLowerCase() +"@gmail.com")
  //       .collection('profile')
  //       .doc(name[i-1].toLowerCase() +"@gmail.com")
  //       .set(
  //       { 
  //         'name': name[i-1],
  //         'address': 'Address'+ i.toString(),
  //         'age': (random.nextInt(20)+20).toString(),
  //         'duration': durations[random.nextInt(4)],
  //         'exp salary': (random.nextInt(3000)+6000).toString(),
  //         'gender': 'Male',
  //         'language': 'Hindi, Marathi',
  //         'marital status': marriage[random.nextInt(2)],
  //         'photo': photos[random.nextInt(3)],
  //         'religion': religions[random.nextInt(4)],
  //         'years of experience': (random.nextInt(15)+2).toString(),
  //         'email': name[i-1].toLowerCase() +"@gmail.com", 
  //         'password': '123456',
  //         'contact no': '7977861078', 
  //         'state': 'Maharashtra', 
  //         'city': 'Parbhani', 
  //         'category': 'house_help',
  //       }); 
  //     }

  //     for(int i=6;i<=10;i++){
        
  //       Random random = new Random();
  //       // int randomNumber = random.nextInt(2);
  //       await FirebaseFirestore.instance
  //       .collection('helper')
  //       .doc(name[i-1].toLowerCase() +"@gmail.com")
  //       .collection('profile')
  //       .doc(name[i-1].toLowerCase() +"@gmail.com")
  //       .set(
  //       { 
  //         'name': name[i-1],
  //         'address': 'Address'+ i.toString(),
  //         'age': (random.nextInt(20)+20).toString(),
  //         'duration': durations[random.nextInt(4)],
  //         'exp salary': (random.nextInt(3000)+6000).toString(),
  //         'gender': 'Female',
  //         'language': 'Hindi, Marathi',
  //         'marital status': marriage[random.nextInt(2)],
  //         'photo': femalephotos[random.nextInt(3)],
  //         'religion': religions[random.nextInt(4)],
  //         'years of experience': (random.nextInt(15)+2).toString(),
  //         'email': name[i-1].toLowerCase() +"@gmail.com", 
  //         'password': '123456',
  //         'contact no': '7977861078', 
  //         'state': 'Maharashtra', 
  //         'city': 'Parbhani', 
  //         'category': 'house_help',
  //       }); 
  //     }

  //     for(int i=6;i<=10;i++){

  //       Random random = new Random();
  //       int randomNumber = random.nextInt(2);
  //       await FirebaseFirestore.instance
  //       .collection('helper')
  //       .doc(name[i-1]+"@gmail.com")
  //       .set(
  //       {'name':name[i-1],'email': name[i-1]+"@gmail.com", 'password':'123456','contact no': '7977861078', 'state': states[randomNumber], 'city': cities[randomNumber], 'aadhar':'https://firebasestorage.googleapis.com/v0/b/helper-hiring-backend.appspot.com/o/demo12%40gmail.com%2FIMG-20210224-WA0000.jpg?alt=media&token=b0c9855d-0397-44ae-b17b-a4cd0d8ffe7f'}); 
  //     }
    
  // }
}