import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../../constants.dart';


class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "FILTER",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
            )
          ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: BackButton(
           color: kPrimaryColor
        ), 
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: size.height*0.025,),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter some value.";
                      }
                      return null;
                    },
                    // onChanged (){},
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.my_location,
                        color: kPrimaryColor,
                      ),
                      hintText: "State",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter some value.";
                      }
                      return null;
                    },
                    // onChanged (){},
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: kPrimaryColor,
                      ),
                      hintText: "City",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: Colors.red,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.red,
                    checkBoxCheckColor: Colors.green,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Religion",
                      style: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more options';
                      }
                      return null;
                    },
                    dataSource: [
                      {
                        "display": "Hindu",
                        "value": "Running",
                      },
                      {
                        "display": "Muslim",
                        "value": "Climbing",
                      },
                      {
                        "display": "Christian",
                        "value": "Walking",
                      },
                      {
                        "display": "Others",
                        "value": "Swimming",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Please choose one or more'),
                    initialValue: _myActivities,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _myActivities = value;
                      });
                    },
                  ), 
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: Colors.red,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.red,
                    checkBoxCheckColor: Colors.green,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Duration (Per Day)",
                      style: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more options';
                      }
                      return null;
                    },
                    dataSource: [
                      {
                        "display": "Less than 2 hours",
                        "value": "Running",
                      },
                      {
                        "display": "2 - 4 hours",
                        "value": "Climbing",
                      },
                      {
                        "display": "4 - 6 hours",
                        "value": "Walking",
                      },
                      {
                        "display": "More than 6 hours",
                        "value": "Swimming",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Please choose one or more'),
                    initialValue: _myActivities,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _myActivities = value;
                      });
                    },
                  ),

                  
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: Colors.red,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.red,
                    checkBoxCheckColor: Colors.green,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Gender",
                      style: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more options';
                      }
                      return null;
                    },
                    dataSource: [
                      {
                        "display": "Male",
                        "value": "Running",
                      },
                      {
                        "display": "Female",
                        "value": "Climbing",
                      },
                      {
                        "display": "Transgender",
                        "value": "Walking",
                      },

                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Please choose one or more'),
                    initialValue: _myActivities,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _myActivities = value;
                      });
                    },
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.all(8),
                //   child: RaisedButton(
                //     child: Text('Save'),
                //     onPressed: _saveForm,
                //   ),
                // ),
                Container(
                  color: kPrimaryColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      onPressed: _saveForm,
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(_myActivitiesResult),
                )
              ],
            ),
          ),
        ),
      ) 
    );
  }
}