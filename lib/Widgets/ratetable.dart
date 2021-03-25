import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class RateTable extends StatelessWidget {
  final String name;
  final String displayImage;
  final String value1;
  final String value2;
  final String value3;
  final String value4;
  RateTable({Key k, this.name, this.displayImage, this.value1, this.value2, this.value3, this.value4}):super(key: k);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(  
      margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0, bottom: 8.0),
      // color: Color(0x00000000),
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        // onFlipDone: (status) {
        //   print(status);
        // },
        front: Container(
          height: size.height * 0.23,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            color: Colors.amber[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * 0.23 * 0.55,
                width: size.width * 0.4 * 0.65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(displayImage),
                    fit: BoxFit.fill,
                  ),
                ),
                // child: 
              ),

              SizedBox(height: size.height*0.02),
              
              Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0)),
            ],
          ),
        ),
        back: Container(
          height: size.height * 0.23,
          width: size.width * 0.4,
          // padding: EdgeInsets.fromLTRB(0, 2.0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.amber[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text('Back', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0)),
              // Text('Click here to flip front',
              //     style: Theme.of(context).textTheme.body1),
              SizedBox(height: size.height * 0.01),

              Center(
                child: Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0)),
              ),

              SizedBox(height: size.height * 0.013),

              Table(
                defaultColumnWidth: FixedColumnWidth(80.0),
                // defaultVerticalAlignment: TableCellVerticalAlignment.top,  
                // border: TableBorder.all(  
                //     color: Colors.black,  
                //     style: BorderStyle.solid,  
                //     width: 1),  
                children: [
                  TableRow(
                    children: [
                      
                      Text('   Time', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.0)),
                      Text('   Rate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.0)),
                      // SizedBox(height: size.height * 0.02),
                      
                      // Text('4-6 hrs    Rs. 300',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
                      // Text('  >6 hrs   Rs. 500',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
                    ]
                  ),
                ]
              ),
              SizedBox(height: size.height * 0.015),
              Table(
                defaultColumnWidth: FixedColumnWidth(80.0),
                // defaultVerticalAlignment: TableCellVerticalAlignment.top,  
                // border: TableBorder.all(  
                //     color: Colors.black,  
                //     style: BorderStyle.solid,  
                //     width: 1),  
                children: [
                  TableRow(
                    children: [
                      
                      Text('    <2 hrs', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      Text('  Rs '+ value1, style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // SizedBox(height: size.height * 0.02),
                      
                      // Text('4-6 hrs    Rs. 300',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // Text('  >6 hrs   Rs. 500',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    ]
                  ),
                ]
              ),
              SizedBox(height: size.height * 0.008),
              Table(
                defaultColumnWidth: FixedColumnWidth(80.0),
                // defaultVerticalAlignment: TableCellVerticalAlignment.top,  
                // border: TableBorder.all(  
                //     color: Colors.black,  
                //     style: BorderStyle.solid,  
                //     width: 1),  
                children: [
                  TableRow(
                    children: [
                      
                      Text('   2-4 hrs', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      Text('  Rs '+ value2, style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // SizedBox(height: size.height * 0.02),
                      
                      // Text('4-6 hrs    Rs. 300',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // Text('  >6 hrs   Rs. 500',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    ]
                  ),
                ]
              ),
              SizedBox(height: size.height * 0.008),
              Table(
                defaultColumnWidth: FixedColumnWidth(80.0),
                // defaultVerticalAlignment: TableCellVerticalAlignment.top,  
                // border: TableBorder.all(  
                //     color: Colors.black,  
                //     style: BorderStyle.solid,  
                //     width: 1),  
                children: [
                  TableRow(
                    children: [
                      
                      Text('   4-6 hrs', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      Text('  Rs ' + value3, style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // SizedBox(height: size.height * 0.02),
                      
                      // Text('4-6 hrs    Rs. 300',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // Text('  >6 hrs   Rs. 500',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    ]
                  ),
                ]
              ),
              SizedBox(height: size.height * 0.008),
              Table(
                defaultColumnWidth: FixedColumnWidth(80.0),
                // defaultVerticalAlignment: TableCellVerticalAlignment.top,  
                // border: TableBorder.all(  
                //     color: Colors.black,  
                //     style: BorderStyle.solid,  
                //     width: 1),  
                children: [
                  TableRow(
                    children: [
                      
                      Text('    >6 hrs', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      Text('  Rs ' + value4, style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // SizedBox(height: size.height * 0.02),
                      
                      // Text('4-6 hrs    Rs. 300',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                      // Text('  >6 hrs   Rs. 500',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    ]
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}