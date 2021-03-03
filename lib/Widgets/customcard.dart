import 'package:Helper_Hiring_System/Screens/result.dart';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String header;
  final String displayImage;
  // final Image image;
  final BaseAuth auth;
  final String category;
  // final Function press;
  CustomCard({Key key, this.header, this.displayImage, this.auth, this.category}) : super(key: key);

  String _city="";
  String _state="";
  List items = ['demo', 'demo', 'demo', 'demo', 'demo'];
  List<String> items1 = [];
  Map<int, List> helper_data = {0:["demo","demo1"]};
  Map<int, List> helper_data_new = {0: ["https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png", "demo6", "27", "male", "6"], 1: ["https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png", "demo6", "27", "male", "6"]};
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  child: Image.asset(displayImage,  height: MediaQuery.of(context).size.height / 10,width: MediaQuery.of(context).size.width / 5, )),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                child: Text(header,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              )
            ],
          )),
      onTap: () async{
        await getData();
        // await getinfo();
        // Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Result(auth:auth, category: category)));
      },
    );
  }
  
  Future<void> getData() async {
    final user = await auth.currentUser();
    print(user);
    
    FirebaseFirestore.instance.collection('employer').where('email', isEqualTo: user)
    .snapshots().listen((data)  {
      _city = data.docs[0]['city'];
      _state = data.docs[0]['state'];
      print('City: $_city');
      print('State: $_state');
      setData(category,_city,_state);
    }
    
    );
  }

  Future<void> setData(String category, String _city, String _state) async {
    print("set data me city"+_city);
    try{
      final user = await auth.currentUser();
      print(user);
      await FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('filter')
        .doc(category)
        .set(
        {'city': _city,'state': _state, 'religion': "",'duration': "", 'gender': "", 'budget': "", 'yearofexp': "", 'category': category});
    }
    catch(e){
      print("Error: " + e);
    }
    
  }
}
  
//   Future<void> getinfo() async {
//     final user = await auth.currentUser();
//     print(user);

//     FirebaseFirestore.instance
//         .collection('employer')
//         .doc(user)
//         .collection('filter')
//         .where('category', isEqualTo: category)
//         .snapshots()
//         .listen((data) async{
//       _city = data.docs[0]['city'];
//       _state = data.docs[0]['state'];
//       print('Result page ka City: $_city');
//       print('Result page ka State: $_state');
//       helper_data_new = await gethelper(_city, _state);
//     });
//     // setState(() {
//     //   print("set state ka items");
//     //   print(helper_data_new);
//     //   print("Heloooooo");
//     // });
//   }

//   Future<Map<int, List>> gethelper(String infoCity, String infoState) async {
//     // final user = await widget.auth.currentUser();
//     // print(user);
//     // await batch.commit();
//     int i = 0;
//     FirebaseFirestore.instance
//         .collection('helper')
//         .where('city', isEqualTo: infoCity)
//         .where('state', isEqualTo: infoState)
//         .where('category', isEqualTo: category)
//         .snapshots()
//         .listen((data) {
//       // print("Data yaha print hua: ");
//       // print("Length:" + data.docs.length.toString());
//       // for(int i=0;i<data.docs.length;i++){
//       //   _city = data.docs[i]['city'];
//       //   _state = data.docs[i]['state'];
//       //   print('Email: $_city');
//       //   print('State: $_state');
//       //   // print("Doc: ${data.docs[i]}");
//       //  }
//       //  print("Email[0] mila: ${data.docs[0]['email']}");
//       //  print("Doc[0] mila: ${data.docs[0]}");
//       data.docs.forEach((result) async {
//         print("Data.docs k andar aaya!!");
//         print(result.data());

//         FirebaseFirestore.instance
//             .collection('helper')
//             .doc(result['email'])
//             .collection('profile')
//             .where('city', isEqualTo: infoCity)
//             .snapshots()
//             .listen((event) {
//           print("Event.docs k andar aaya!!");
//           // print("event ka data"+ event.docs[0]);
//           // print("event ka alag data: "+ event.docs[0].toString() + " "+ event.docs.first.toString());
//           // event.docs.forEach((element) {
//           //   print(element.data);
//           // });
//           items1.clear();
//           items1.add(event.docs[0]['photo']);
//           items1.add(event.docs[0]['name']);
//           items1.add(event.docs[0]['age']);
//           items1.add(event.docs[0]['gender']);
//           items1.add(event.docs[0]['years of experience']);
//           print("Items: ");
//           print(items1);
//           helper_data[i] = items1;
//           i = i+1;
//           print("andar ka helper data");
//           print(helper_data);
//           // setState(() {
//           //   items = items;
//           //   print("set state ka items");
//           //   print(items);
//           //   print("Heloooooo");
//           // });
//         });
//       });
//     });
//     return helper_data;
//   }

// }