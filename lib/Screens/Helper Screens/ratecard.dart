import 'package:Helper_Hiring_System/constants.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class RateCard extends StatefulWidget {
  RateCard({Key key}) : super(key: key);

  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Front'),
                  ),
                  back: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Back'),
                  ),
                ),
                FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Front'),
                  ),
                  back: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Back'),
                  ),
                ), 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Front'),
                  ),
                  back: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Back'),
                  ),
                ),
                FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Front'),
                  ),
                  back: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Back'),
                  ),
                ), 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      color: kPrimaryLightColor, 
                      child: Text('Front'),
                  ),
                  back: Container(
                      child: Text('Back'),
                  ),
                ),
                FlipCard(
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                      child: Text('Front'),
                  ),
                  back: Container(
                      child: Text('Back'),
                  ),
                ), 
              ],
            ),
          ] 
        ),
      )
    );
  }
}