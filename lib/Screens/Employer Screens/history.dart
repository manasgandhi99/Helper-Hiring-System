import 'package:Helper_Hiring_System/root_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth.dart';
import '../../constants.dart';
import 'histindetail.dart';
// import '../auth.dart';
// import 'new_home.dart';

class History extends StatefulWidget {
  final BaseAuth auth;
  final String category;
  History({Key key, this.auth, this.category}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  int lenData;
  int i;
  List<String> items1 = [];
  Map<int, List> helper_data = {};
  Map<int, List> helper_data_new = {};
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
    await getHistory();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("build ka helper data");
    print(helper_data_new);
    print("LEnght of data");
    print(lenData);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "HISTORY",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
            )
          ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
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
                  return Dismissible(
                    // Show a red background as the item is swiped away.
                    background: Container(color: Colors.red),
                    key: Key(helper_data_new[index][1]),
                    onDismissed: (direction) {
                      setState(() {
                        // items.removeAt(index);
                      });

                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(helper_data_new[index][1] +"is dismissed")));
                    },
                    child: Column(children: [
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
                                                helper_data_new[index][1],
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
                                        helper_data_new[index][11],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),

                                      SizedBox(height: 5),

                                      // Text(
                                      //   helper_data_new[index][3],
                                      //   maxLines: 1,
                                      //   style: TextStyle(
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.w500,
                                      //       color: Colors.grey),
                                      // ),

                                      // SizedBox(height: 5),

                                      Text(
                                        helper_data_new[index][13] + "," + helper_data_new[index][14],
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HistInDetail(auth: widget.auth, helper_data_new: helper_data_new[index])));
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
                    ]),
                  );
                }
              )
            )
          )
    );
  }

  Future<void> getHistory() async{
    print("Inside get history");
    final user = await widget.auth.currentUser();
    await FirebaseFirestore.instance.collection("employer").doc(user).collection("history")
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
          helper_data[i] = [doc['photo'], doc['name'], doc['age'], doc['gender'], 
                            doc['years of experience'], doc['address'], doc['duration'], 
                            doc['exp salary'], doc['religion'], doc['marital status'], 
                            doc['language'], doc['category'], doc['contact no'], doc['city'], doc['state']];
          i = i+1;
          print("event docs k andar ka helper data");
          print(helper_data);
          helper_data_new = helper_data;
          setState(() {
            if(helper_data_new.length == lenData){
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