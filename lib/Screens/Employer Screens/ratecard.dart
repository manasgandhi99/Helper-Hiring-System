import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';

class RateCard extends StatefulWidget {
  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Card'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(child: Text("This is Rate Card Page", style: TextStyle(fontSize: 32.0))),
      ),
    );
  }
}