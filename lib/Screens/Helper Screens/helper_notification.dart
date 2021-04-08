import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth.dart';
import '../../constants.dart';

class HelperNotification extends StatefulWidget {
  final BaseAuth auth;
  // final String category;
  HelperNotification({Key key, this.auth}) : super(key: key);

  @override
  _HelperNotificationState createState() => _HelperNotificationState();
}

class _HelperNotificationState extends State<HelperNotification> {
  
  int lenData;
  int i;
  List<String> items1 = [];
  Map<int, List> employer_data = {};
  Map<int, List> employer_data_new = {};
  bool flag = false;
  bool isLoading = true;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getdata();
    }

  Future<void> getdata() async {
    print("Get data k andar aaya ");
    await getNotifs();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("build ka helper data");
    print(employer_data_new);
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
      body: flag ? 
      Center(
        child: Text("No Contacts in History",style: TextStyle(fontSize: 20),),
      ):
      isLoading ? 
      progressIndicator():
      Center(
        child: Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                itemCount: employer_data_new.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    // Show a red background as the item is swiped away.
                    background: Container(color: Colors.red),
                    key: Key(employer_data_new[index][1]),
                    onDismissed: (direction) {
                      setState(() {
                        // items.removeAt(index);
                      });

                      final snackBar = SnackBar(
                        content: Text(employer_data_new[index][1] +" was removed!"),
                        action: SnackBarAction(
                          disabledTextColor: Colors.amber[300],
                          label: 'OK',
                          textColor: Colors.amber[300],
                          onPressed: () {},
                        ),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
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
                                      backgroundImage: NetworkImage(employer_data_new[index][0]),
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
                                                employer_data_new[index][1],
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
                                        employer_data_new[index][2] + ", " + employer_data_new[index][3],
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
                                              _makingPhoneCall(employer_data_new[index][4]);
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
              )
            )
          )
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

  Future<void> getNotifs() async{
    print("Inside get notifs");
    final user = await widget.auth.currentUser();
    await FirebaseFirestore.instance.collection("helper").doc(user).collection("notification")
    .get()
    .then((QuerySnapshot data) {
        lenData = data.docs.length;
        if(lenData == 0) {
          setState(() {
          flag=true;  
          });
        }

        print("Flag: "+flag.toString());
        i = 0;
        data.docs.forEach((doc) {
          print("i ka value: ");
          print(i);
          employer_data[i] = [doc['photo'], doc['name'], doc['city'], doc['state'],doc['contact no']];
          i = i+1;
          print("event docs k andar ka helper data");
          print(employer_data);
          employer_data_new = employer_data;
          setState(() {
            if(employer_data_new.length == lenData){
              isLoading = false;
            }
            else{
              isLoading = true;
            }
          });
        });
    });
  }

  Widget progressIndicator() {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
      );
  }
}