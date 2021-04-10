import 'dart:collection';

import 'package:Helper_Hiring_System/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth.dart';
import 'filter.dart';
import 'package:Helper_Hiring_System/Screens/Employer Screens/indetail.dart';
import 'package:google_fonts/google_fonts.dart';


class Result extends StatefulWidget {
  final BaseAuth auth;
  final String category;
  Result({Key key, this.auth, this.category}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  int lenData;
  String _city = "";
  String _state = "";
  List<String> items1 = [];
  Map<int, List> helper_data = {};
  //Map<int, List> helper_data_new = {0: ["https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png", "demo10", "29", "female", "8"]};
  Map<int, List> helper_data_new = {};
  Map<int, List> helper_data_naya_new = {};
  bool flag = false;
  bool isLoading = true, budgetorder = false, yearofexporder = true;
  String categoryName = "", _budget = "", _yearofexp = "";
  List _gender =[], _religion = [], _duration = [];

  @override
  void initState() {
    super.initState();
    print("Init k andar get data call hua");
    getdata();
    print("Init k andar get data call ho gaya");
  }

  Future<void> getdata() async {
    print("Get data k andar aaya ");
    await getinfo();
  }

  // get city and state from selected category from filter collection
  // get all docs from helper collection and compare both city and state if true append email in a list
  // use that list to print all the required details on the card.
  Future<void> getinfo() async {
    final user = await widget.auth.currentUser();
    print("Get info ka user: ");
    print(user);

    FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('filter')
        .where('category', isEqualTo: widget.category)
        .snapshots()
        .listen((data) async{
      _city = data.docs[0]['city'];
      _state = data.docs[0]['state'];
      _gender = data.docs[0]['gender'];
      _duration = data.docs[0]['duration'];
      _religion = data.docs[0]['religion'];
      _budget = data.docs[0]['budget'];
      _yearofexp = data.docs[0]['yearofexp'];
      // fetch all data and listsss
      print('Result page ka City: $_city');
      print('Result page ka State: $_state');
      print('Result page ka gender: $_gender');
      print('Result page ka duration: $_duration');
      print('Result page ka religion: $_religion');
      print('Result page ka budget: $_budget');
      print('Result page ka year of exp: $_yearofexp');
      if(_budget=="High to Low"){
        budgetorder = true;
      }
      if(_yearofexp == "Low to High"){
        yearofexporder = false;
      }
      await gethelper(_city, _state, _gender, _duration, _religion, _budget, _yearofexp);
    });
  }

  Future<void> gethelper(String infoCity, String infoState, List infogender, List infoduration, List inforeligion, String infobudget, String infoyearofexp) async {
    // final user = await widget.auth.currentUser();
    // print(user);
    // await batch.commit();
    
    FirebaseFirestore.instance
        .collection('helper')
        .where('city', isEqualTo: infoCity)
        .where('state', isEqualTo: infoState)
        .where('category', isEqualTo: widget.category)
        .snapshots()
        .listen((data) {
    
          lenData = data.docs.length;
          if(lenData == 0) {
            setState(() {
            flag=true;  
            });
          }

          print("Flag: "+flag.toString());
          print(lenData);

          int i = 0,j=0;
          data.docs.forEach((result) async {
            print("Data.docs k andar aaya!!");
            print(result.data());

            FirebaseFirestore.instance
                .collection('helper')
                .doc(result['email'])
                .collection('profile')
                .where('category', isEqualTo: widget.category)
                // .where('gender', whereIn: infogender)
                // .where('duration', whereIn: infoduration)
                // just add where in clause rest all will remain same
                .snapshots()
                .listen((event) {
                  if(inforeligion.contains(event.docs[0]['religion'])){
                        if(infogender.contains(event.docs[0]['gender'])){
                          if(infoduration.contains(event.docs[0]['duration'])){
                            print("Event.docs k andar aaya!!");
                            print("i ka value: ");
                            print(i);
                            helper_data[i] = [event.docs[0]['photo'], event.docs[0]['name'], event.docs[0]['age'], event.docs[0]['gender'], 
                                              event.docs[0]['years of experience'], event.docs[0]['address'], event.docs[0]['duration'], 
                                              event.docs[0]['exp salary'], event.docs[0]['religion'], event.docs[0]['marital status'], 
                                              event.docs[0]['language'], event.docs[0]['category'], event.docs[0]['contact no'], event.docs[0]['email'],
                                              event.docs[0]['city'], event.docs[0]['state']];
                            i = i+1;
                            print("event docs k andar ka helper data");
                            print(helper_data);
                            helper_data_naya_new = helper_data;
                            // setState(() {
                            //   // helper_data_new = helper_data;
                            //   // print("set state ka items");
                            //   // print(helper_data_new);
                            //   if(helper_data_new.length == lenData){
                            //     isLoading = false;
                            //   }
                            //   else{
                            //     isLoading = true;
                            //   }
                            //   // print("Heloooooo");
                            // });
                      }
                    }
                  }
                        j=j+1;
                        setState((){
                          helper_data_naya_new = helper_data;
                            // print("set state ka items");
                            // print(helper_data_new);
                            if(j == lenData){
                              isLoading = false;
                            }
                            else{
                              isLoading = true;
                            }
                            // print("Heloooooo");
                      });      
                });
          });
          // setState((){
          //   isLoading = false;
          // });
        });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.category[0]=='h'){
      categoryName ="House Help";
    }
    else if(widget.category[0]=='o'){
      categoryName ="Office Help";
    }
    else if(widget.category[0]=='p'){
      categoryName ="Patient Care";
    }
    else if(widget.category[0]=='c'){
      categoryName ="Cook";
    }
    else if(widget.category[0]=='e'){
      categoryName ="Elderly Care";
    }
    else if(widget.category[0]=='b'){
      categoryName ="BabySitting";
    }
    Size size = MediaQuery.of(context).size;
    print("Flag new" + flag.toString());
    print("build ka helper data");
    print(helper_data_naya_new);
    helper_data_new = helper_data_naya_new ;
    // if(_yearofexp != "High to Low"){
    //   helper_data_new = Map.fromEntries(
    //   helper_data_naya_new.entries.toList()
    //   ..sort((e1, e2) => e1.value[4].compareTo(e2.value[4])));
    //   print("sorted map:");
    //   print(helper_data_new);
    // }
    // else{
    //   print("else k andar");
    //   helper_data_new = SplayTreeMap.from(
    //   helper_data_naya_new , (key1,key2) => helper_data_naya_new[key1][4].compareTo(helper_data_naya_new[key2][4]));
    //   print(helper_data_new);
    // }
    // var sortedMap = Map.fromEntries(
    // helper_data_new.entries.toList()
    // ..sort((e1, e2) => e1.value[7].compareTo(e2.value[7])));
    print("LEnght of data");
    print(lenData);
      return Scaffold(
        appBar: AppBar(
          title:  Text(
            "Results for "+ categoryName,
            style: GoogleFonts.montserrat(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor
              )
            ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          leading: BackButton(
            color: kPrimaryColor
          ), 
          // title: Text("Results for "+ categoryName ,style: TextStyle(fontSize: 17.0),),
          actions: [
             FlatButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Filter(auth:widget.auth, category: widget.category))),
                  },
                  padding: EdgeInsets.only(top: size.height*0.006),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.filter_list,color: kPrimaryColor,),
                      Text("Filter",style: TextStyle(color: kPrimaryColor,),)
                    ],
                  ),
                ),
          ],
        ),

        body: flag ? 
          Center(
            child: Text("No Matches Found",style: TextStyle(fontSize: 20),),
          ):
          isLoading ? 
          progressIndicator():
          Center(
            child: Container(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                    itemCount: helper_data_new.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Card(
                            elevation: 6,
                            color: kPrimaryLightColor,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                              child: Row(
                                children: <Widget>[

                                  SizedBox(
                                    width: size.width * 0.035,
                                  ),

                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 60.0,
                                    child: CircleAvatar(
                                      radius: 55.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(helper_data_new[index][0]),
                                        radius: 50,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: size.width * 0.08,
                                  ),

                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        MergeSemantics(
                                          child: Row(
                                            children: <Widget>[
                                        
                                              Flexible(
                                                child: Text(
                                                  "Name: " + helper_data_new[index][1],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        Text(
                                          "Age: " + helper_data_new[index][2],
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),

                                        SizedBox(height: 5),

                                        Text(
                                          "Gender: " + helper_data_new[index][3],
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),

                                        SizedBox(height: 5),

                                        Text(
                                          "Years of Exp: " + helper_data_new[index][4],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),

                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 2),
                                          width: size.width * 0.2,
                                          
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(55),
                                            child: FlatButton(
                                              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                                              color: kPrimaryColor,
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail(auth: widget.auth, helper_data_new: helper_data_new[index])));
                                              },
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(color: Colors.white, fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                      ]);
                    }
                  )
                )
              )
            );
    }

    
    Widget progressIndicator() {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
      );
    }
}
