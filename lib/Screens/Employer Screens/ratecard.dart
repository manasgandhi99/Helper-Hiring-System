import 'package:Helper_Hiring_System/Widgets/ratetable.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:flip_card/flip_card.dart';

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
          title: Text('Rate Card'),
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
                  RateTable(name: "House Help", value1: "125",value2: "210",value3: "325",value4: "460"),
                
                  RateTable(name: "Cook", value1: "150",value2: "220",value3: "340",value4: "500"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[

                  RateTable(name: "Elderly Care", value1: "135",value2: "210",value3: "335",value4: "480"),

                  RateTable(name: "BabySitting", value1: "175",value2: "270",value3: "400",value4: "600"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[

                  RateTable(name: "Office Help", value1: "125",value2: "210",value3: "325",value4: "460"),

                  RateTable(name: "Patient Care", value1: "160",value2: "250",value3: "370",value4: "530"),
                ],
              ),
            ] 
          ),
        )
      ),
    );
  }
}