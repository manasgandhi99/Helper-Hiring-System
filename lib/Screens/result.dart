import 'package:Helper_Hiring_System/Screens/indetail.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Result extends StatefulWidget {
  final BaseAuth auth;
  final String category;
  // final Map<int, List> helper_data;
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
  bool flag = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    await getinfo();
  }

  // get city and state from selected category from filter collection
  // get all docs from helper collection and compare both city and state if true append email in a list
  // use that list to print all the required details on the card.
  Future<void> getinfo() async {
    final user = await widget.auth.currentUser();
    print(user);

    FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('filter')
        .where('category', isEqualTo: "house_help")
        .snapshots()
        .listen((data) async{
      _city = data.docs[0]['city'];
      _state = data.docs[0]['state'];
      print('Result page ka City: $_city');
      print('Result page ka State: $_state');
      await gethelper(_city, _state);
    });
  }

  Future<void> gethelper(String infoCity, String infoState) async {
    // final user = await widget.auth.currentUser();
    // print(user);
    // await batch.commit();
    int i = 0;
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
          data.docs.forEach((result) async {
            print("Data.docs k andar aaya!!");
            print(result.data());

            FirebaseFirestore.instance
                .collection('helper')
                .doc(result['email'])
                .collection('profile')
                .where('city', isEqualTo: infoCity)
                .snapshots()
                .listen((event) {
              print("Event.docs k andar aaya!!");
              print("i ka value: ");
              print(i);
              helper_data[i] = [event.docs[0]['photo'], event.docs[0]['name'], event.docs[0]['age'], event.docs[0]['gender'], event.docs[0]['years of experience']];
              i = i+1;
              print("event docs k andar ka helper data");
              print(helper_data);
              helper_data_new = helper_data;
              setState(() {
                // helper_data_new = helper_data;
                // print("set state ka items");
                // print(helper_data_new);
                if(helper_data_new.length == lenData){
                  isLoading = false;
                }
                else{
                  isLoading = true;
                }
                // print("Heloooooo");
              });
            });
          });
        });
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Flag new" + flag.toString());
    print("build ka helper data");
    print(helper_data_new);
    print("LEnght of data");
    print(lenData);
      return Scaffold(
        appBar: AppBar(
          title: Text("Result"),
          actions: [
             FlatButton(
                  onPressed: () => {},
                  padding: EdgeInsets.only(top: size.height*0.006),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.filter_list,color: Colors.white,),
                      Text("Filter",style: TextStyle(color: Colors.white,),)
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
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> InDetail()));
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
      // var brightness = MediaQuery
      //     .of(context)
      //     .platformBrightness == Brightness.light;
      
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
        );
      //   backgroundColor: brightness ? Colors.white.withOpacity(
      //       0.70) : Colors.black.withOpacity(
      //       0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      // );
    }
}
