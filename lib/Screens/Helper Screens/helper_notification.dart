import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth.dart';
import '../../constants.dart';

class HelperNotification extends StatefulWidget {
  final BaseAuth auth;
  final String user;
  // final String category;
  HelperNotification({Key key, this.auth, this.user}) : super(key: key);

  @override
  _HelperNotificationState createState() => _HelperNotificationState();
}

class _HelperNotificationState extends State<HelperNotification> {
  
  int lenData;
  int i;
  List<String> items1 = [];
  // Map<int, List> employer_data = {};
  // Map<int, List> employer_data_new = {};
  bool flag = false;
  bool isLoading = true;
  // String user;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // getdata();
      
    }

  // Future<void> getdata() async {
  //   print("Get data k andar aaya ");
  //   user = await widget.auth.currentUser();
  // }

  @override
  Widget build(BuildContext context) {
    // getdata();
    Size size = MediaQuery.of(context).size;
    print("build ka helper data");
    print(widget.user);
    print("LEnght of data");
    print(lenData);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOME",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
          )
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: 
      // flag ? 
      //  :
      // isLoading ? 
      // progressIndicator():

      Center(
        child: StreamBuilder (
          stream: FirebaseFirestore.instance
                  .collection("helper")
                  .doc(widget.user)
                  .collection("notification")
                  .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              print("Connection state: has no data");            
              return Column(children: [
                  // text("Orders", fontSize: 25.0),
                  SizedBox(
                    height:size.height*0.2,
                  ),
                  Center(child: CircularProgressIndicator()),
                ],
              );

        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          print("Connection state: waiting");
          return Column(children: [
                // text("Orders", fontSize: 25.0),
                SizedBox(
                  height:size.height*0.2,
                ),
                Center(child: CircularProgressIndicator()),
            ],
          );
        }          
        
        else{
          
            print("Connection state: hasdata");
              if(snapshot.data.docs.length == 0){
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(size.width * 0.05 ,size.height*0, size.width * 0.05, size.height*0),
                      child: Image.asset(
                            "assets/images/notif.png",
                            height: size.height * 0.65,
                      ),
                    ),

                    // SizedBox(height: size.height * 0.005),

                    Text(
                      "No Notifications!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                              ),
                    ),

                    SizedBox(height: size.height * 0.02),


                  ],
                );
              } 
              else{
                print("Number of notification: " + snapshot.data.docs.length.toString());
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // Show a red background as the item is swiped away.
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: Key(snapshot.data.docs[index]['name']),
                      onDismissed: (direction) async{
                        // setState(() {
                        //   // items.removeAt(index);
                        // });

                        final snackBar = SnackBar(
                          content: Text(snapshot.data.docs[index]['name'] +" was removed!"),
                          action: SnackBarAction(
                            disabledTextColor: Colors.amber[300],
                            label: 'OK',
                            textColor: Colors.amber[300],
                            onPressed: () {},
                          ),
                        );

                        Scaffold.of(context).showSnackBar(snackBar);

                        final user = await widget.auth.currentUser();
                        print("employer email: " + user);
                        FirebaseFirestore.instance
                            .collection('helper')
                            .doc(user)
                            .collection('notification')
                            .doc(snapshot.data.docs[index].id.toString())
                            .delete()
                            .then((value) => print("User Deleted"))
                            .catchError((error) => print("Failed to delete user: $error"));

                          setState(() {
                            print('user deleted set state called');
                          });

                        // setState(() {
                        //   // employer_data_new.removeWhere((key, value) => key == employer_data_new[index]);
                        //   employer_data_new.remove(index);
                        //   if(employer_data_new.length!=0){
                        //     employer_data_new.forEach((key,value){
                        //     if(key>index){
                        //       var value = employer_data_new[key];
                        //       int x = key;
                        //       employer_data_new.remove(key);
                        //       employer_data_new[x-1] = value;
                        //     }
                        //   });
                        //   }
                        //   print("Naya wala ");
                        //   print(employer_data_new);
                        //   print("Lendata");
                        //   print(lenData);
                        //   lenData = lenData - 1;
                        //   if(lenData == 0){
                        //     print("Ismai aaya");
                        //     flag = true;
                        //     isLoading = false;
                        //   }
                        // });
                      },
                      child: Column(
                        children: [
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
                                    radius: 50.0,
                                    child: CircleAvatar(
                                      radius: 45.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot.data.docs[index]['photo']),
                                        radius: 40,
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
                                                  snapshot.data.docs[index]['name'],
                                                  overflow:TextOverflow.ellipsis,
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

                                        // Text(
                                        //   employer_data_new[index][11],
                                        //   maxLines: 1,
                                        //   style: TextStyle(
                                        //       fontSize: 15,
                                        //       fontWeight: FontWeight.w500,
                                        //       color: Colors.grey),
                                        // ),

                                        // SizedBox(height: 5),

                                        // Text(
                                        //   employer_data_new[index][3],
                                        //   maxLines: 1,
                                        //   style: TextStyle(
                                        //       fontSize: 15,
                                        //       fontWeight: FontWeight.w500,
                                        //       color: Colors.grey),
                                        // ),

                                        // SizedBox(height: 5),

                                        Text(
                                          snapshot.data.docs[index]['city'] + ", " + snapshot.data.docs[index]['state'],
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
                                                _makingPhoneCall(snapshot.data.docs[index]['contact no']);
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> HistInDetail(auth: widget.auth, employer_data_new: employer_data_new[index])));
                                              },
                                              child: Text(
                                                "Call Now",
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
                        
                      ]),
                    );
                  }
                );
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: snapshot.data.docs.length,
                //   itemBuilder: (context, index){
                //     return ListTile(
                //       title: text(bullet + snapshot.data.docs[index]["description"].toString()));
                //       });
              }
            }
          }
        ),
      ) ,
      // Center(
      //   child: Container(
      //       padding: EdgeInsets.all(15),

      //       child: 
      //       )
      //     )
    );
  }

   _makingPhoneCall(String contactno) async {
    String url = 'tel:'+ contactno; 
    if (await canLaunch(url)) { 
      await launch(url); 
    } else { 
      throw 'Could not launch $url'; 
    } 
  }

  // Future<void> getNotifs() async{
  //   print("Inside get notifs");
  //   final user = await widget.auth.currentUser();
  //   await FirebaseFirestore.instance.collection("helper").doc(user).collection("notification")
  //   .get()
  //   .then((QuerySnapshot data) {
  //       lenData = data.docs.length;
  //       if(lenData == 0) {
  //         setState(() {
  //         flag=true;  
  //         });
  //       }

  //       print("Flag: "+flag.toString());
  //       i = 0;
  //       data.docs.forEach((doc) {
  //         print("i ka value: ");
  //         print(i);
  //         employer_data[i] = [doc['photo'], doc['name'], doc['city'], doc['state'],doc['contact no'], doc.id.toString()];
  //         i = i+1;
  //         print("event docs k andar ka helper data");
  //         print(employer_data);
  //         employer_data_new = employer_data;
  //         setState(() {
  //           if(employer_data_new.length == lenData){
  //             isLoading = false;
  //           }
  //           else{
  //             isLoading = true;
  //           }
  //         });
  //       });
  //   });
  // }

  Widget progressIndicator() {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
      );
  }
}