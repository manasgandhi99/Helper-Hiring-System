import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';


class InDetail extends StatefulWidget {
  InDetail({Key key}) : super(key: key);

  @override
  _InDetailState createState() => _InDetailState();
}

class _InDetailState extends State<InDetail> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
         title: Text("Profile Page"),
       ),
       backgroundColor: kPrimaryLightColor,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(height:size.height*0.02),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage("https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                            'Shantabai',
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Patient Care',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 17.0,
                              letterSpacing: 1.25,
                              color: kPrimaryColor,
                            ),
                          ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
               
                
                SizedBox(height:size.height*0.02),

              TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: kPrimaryColor,
                tabs: [
                  Tab(
                    text: 'Profile', 
                    icon: Icon(Icons.person_pin_rounded)
                  ),
                  Tab(
                    text: 'Feedback',
                    icon: Icon(Icons.feedback_rounded)
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(child: Center(child: Text('Profile'))),
                    Container(child: Center(child: Text('Feedback')))
                  ],
                  controller: _tabController,
                ),
              ),
              
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: (){},
                    child: Text(
                      "Contact Number",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ]),

        )
      )
    );
  }
}