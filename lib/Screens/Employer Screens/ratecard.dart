import 'package:Helper_Hiring_System/Widgets/ratetable.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:google_fonts/google_fonts.dart';

class RateCard extends StatefulWidget {
  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
          "RATE CARD",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
            )
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  RateTable(name: "House Help", displayImage: "assets/images/househelp.png",value1: "125",value2: "210",value3: "325",value4: "460"),  
                  RateTable(name: "Cook", displayImage: "assets/images/cook.png",value1: "150",value2: "220",value3: "340",value4: "500"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[

                  RateTable(name: "Elderly Care", displayImage: "assets/images/elderlycare.png",value1: "135",value2: "210",value3: "335",value4: "480"),
                  RateTable(name: "BabySitting", displayImage: "assets/images/babysitting.png",value1: "175",value2: "270",value3: "400",value4: "600"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  RateTable(name: "Office Help", displayImage: "assets/images/officehelp.png",value1: "125",value2: "210",value3: "325",value4: "460"),
                  RateTable(name: "Patient Care", displayImage: "assets/images/patientcare.png",value1: "160",value2: "250",value3: "370",value4: "530"),
                ],
              ),

              Center(
                // padding: EdgeInsets.fromLTRB(5.0,0,0,0),
                child: Text("**Note: All rates mentioned are per day", style: TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ] 
          ),
        )
      ),
    );
  }
}