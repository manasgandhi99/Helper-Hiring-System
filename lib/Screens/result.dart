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
  String _city = "";
  String _state = "";
  int lenData;
  // List items = ['demo', 'demo', 'demo', 'demo', 'demo'];
  List<String> items1 = [];
  Map<int, List> helper_data = {};
  //Map<int, List> helper_data_new = {0: ["https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png", "demo10", "29", "female", "8"]};
  Map<int, List> helper_data_new = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    await getinfo();
    // gethelper();
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
      // print("lenght of data");
      // print(lenData);
    });
    // setState(() {
    //   print("set state ka items");
    //   print(helper_data_new);
    //   print("Heloooooo");
    // });
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
      // print("Data yaha print hua: ");
      // print("Length:" + data.docs.length.toString());
      // for(int i=0;i<data.docs.length;i++){
      //   _city = data.docs[i]['city'];
      //   _state = data.docs[i]['state'];
      //   print('Email: $_city');
      //   print('State: $_state');
      //   // print("Doc: ${data.docs[i]}");
      //  }
      //  print("Email[0] mila: ${data.docs[0]['email']}");
      //  print("Doc[0] mila: ${data.docs[0]}");
      lenData = data.docs.length;
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
          // print("event ka data"+ event.docs[0]);
          // print("event ka alag data: "+ event.docs[0].toString() + " "+ event.docs.first.toString());
          // event.docs.forEach((element) {
          //   print(element.data);
          // });

          // *************************
          // helper data changing items due to items1 is changing after every iteration
          // items1.clear();
          // print("items clear k baad ka helper data");
          // print(helper_data);
          // items1.add(event.docs[0]['photo']);
          // items1.add(event.docs[0]['name']);
          // items1.add(event.docs[0]['age']);
          // items1.add(event.docs[0]['gender']);
          // items1.add(event.docs[0]['years of experience']);
          // print("Items: ");
          // print(items1);
          // *************************

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
      // return data.docs.length;
    });
    
  }

  // List items = getDummyList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // getdata();
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
                  // color: Colors.white,
                  padding: EdgeInsets.only(top: size.height*0.006),
                  child: Column( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.filter_list,color: Colors.white,),
                      Text("Filter",style: TextStyle(color: Colors.white,),)
                    ],
                  ),
                ),
          ],
        ),
        body: isLoading ? 
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
                                        )
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
  


  // static List getDummyList() {
  //   List list = List.generate(8, (i) {
  //     return "Item ${i + 1}";
  //   });
  //   print(list);
  //   return list;
  // }
}
