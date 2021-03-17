import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
// import '../auth.dart';
// import 'new_home.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(child: Text("This is History Page", style: TextStyle(fontSize: 32.0))),
      ),
    );
  }

}