import 'package:Helper_Hiring_System/Screens/result.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String header;
  final String displayImage;
  // final Image image;
  CustomCard(this.header, this.displayImage);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 3.1,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 10,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Image.asset(displayImage,  height: MediaQuery.of(context).size.height / 10,width: MediaQuery.of(context).size.width / 5, )),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                child: Text(header,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              )
            ],
          )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Result()));
      },
    );
  }
}