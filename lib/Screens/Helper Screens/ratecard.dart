import 'package:flutter/material.dart';

class RateCard extends StatefulWidget {
  RateCard({Key key}) : super(key: key);

  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(    
          child: Text('Rate Card'),
      ),
    );
  }
}