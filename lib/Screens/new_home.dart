import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/customcard.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth.dart';
import 'dart:io';
// import '../constants.dart';

class NewHome extends StatefulWidget {
  final BaseAuth auth;
  NewHome({this.auth});
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int i = 0;
  String _city;
  String _state;
  // var data = informationList;
  final String assetimage = 'assets/images/user1.png';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      ),
      body: Column(children: [
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

                        Container(
                            margin: EdgeInsets.fromLTRB(0,0,size.width*0.06,0),
                            width: 60,
                            height: 75,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(assetimage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                )),
                 // Blue Part
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
                        // CustomCard(data[0][0], "4 lights", 'assets/bed.png'),
                        // CustomCard(
                        //     "Living Room", "2 lights", 'assets/room.png'),
                        GestureDetector(
                          child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 3.1,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[100],
                                      spreadRadius: 10,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                      child: Image.asset("assets/images/maid.jpg",  height: MediaQuery.of(context).size.height / 10,width: MediaQuery.of(context).size.width / 5, )),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                                    child: Text("House Help",
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  )
                                ],
                              )),
                          onTap: ()async{
                            await getData();
                            setData('house_help');
                          },
                        ),
                        CustomCard("Cook", "assets/images/maid.jpg"),
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
                        CustomCard("Elderly Care", "assets/images/maid.jpg"),
                        CustomCard("Babysitting", "assets/images/maid.jpg"),
                        // for (i; i < 4; i++)
                        //   CustomCard(data[i][0], data[i][1], data[i][2]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // CustomCard("Outdoor", "5 lights", 'assets/images/house.png'),
                        // CustomCard("Balcony", "2 lights", 'assets/images/balcony.png'),
                        CustomCard("Office Help", "assets/images/maid.jpg"),
                        CustomCard("Patient Care", "assets/images/maid.jpg"),
                        // for (i; i < 6; i++)
                        //   CustomCard(data[i][0], data[i][1], data[i][2]),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ]),
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
}