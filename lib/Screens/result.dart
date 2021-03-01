import 'package:Helper_Hiring_System/constants.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Result"),
        ),
        body: Center(child: SwipeList()));
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {



  // get city and state from selected category from filter collection
  // get all docs from helper collection and compare both city and state if true append email in a list
  // use that list to print all the required details on the card.
  List items = getDummyList();
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child:Card(
                    elevation: 6,
                    color: kPrimaryLightColor,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6,6,6,6),
                      child: Row(
                        children: <Widget>[
                      
                          // Container(
                          //   width: 100,
                          //   height: 100,
                            
                          //   decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   border: Border.all(
                          //     color: Colors.black,
                          //     width: 5,
                          //   ),
                          //   image: DecorationImage(
                          //     image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                          //     fit: BoxFit.cover,
                          //   ),
                          //   ),
                          // ),
                          SizedBox(
                            width: size.width*0.035,
                          ), 
                          Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // shape: BoxShape.circle,
                            borderRadius: new BorderRadius.all(new Radius.circular(20)),
                            border: new Border.all(
                              color: Colors.black,
                              width: 4.0,
                            ),
                          ),
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.fill,
                              placeholder: "photo",
                              image: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',)),
                        ),


                          SizedBox(
                            width: size.width*0.08,
                          ),

                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                MergeSemantics(
                                  child: Row(
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.crop_square,
                                      //   color: Colors.red,
                                      //   size: 18,
                                      // ),
                                      Flexible(
                                        child: Text(
                                          'Name',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Age',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Gender',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  // '₹ 10,000',
                                  "Years of Experience",
                                  style: TextStyle(
                                      fontSize: 13,
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
                
                  SizedBox(height:size.height*0.006),
              ]);
        },
    )
    );
  }

  static List getDummyList() {
    List list = List.generate(8, (i) {
      return "Item ${i + 1}";
    });
    print(list);
    return list;
  }
}
