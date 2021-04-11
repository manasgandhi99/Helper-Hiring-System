import 'package:Helper_Hiring_System/Screens/Employer%20Screens/result.dart';
import 'package:Helper_Hiring_System/components/text_field_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../../auth.dart';
import '../../constants.dart';


class Filter extends StatefulWidget {
  final BaseAuth auth;
  final String category;
  Filter({Key key, this.auth, this.category}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  List _gender,_duration,_religion, _autoreligion, _autoduration, _autogender;
  String _genderResult, _durationResult, _religionResult, _budget, _autocity, _autostate, _yoe, _city, _state, _pref = "Salary";
  final formKey = new GlobalKey<FormState>();
  TextEditingController _statecontroller; 
  TextEditingController _citycontroller; 

  @override
  void initState() {
    _autoreligion = [];
    _autoduration = [];
    _autogender = [];
    // _gender = ['Male', 'Female', 'Transgender'];
    _genderResult = '';
    // _duration = ['Less than 2', '2-4', '4-6', 'More than 6'];
    _durationResult = '';
    // _religion = ['Hindu', 'Muslim', 'Christian', 'Others'];
    _religionResult = '';
    // _budget = "Low to High";
    // _yoe = "High to Low";
    autofill();
    super.initState();
  }

  @override
  void dispose() {
    _citycontroller.dispose();
    _statecontroller.dispose();
    super.dispose();
  }

  Future<void> autofill() async{
    try{
        final user = await widget.auth.currentUser();
        print(user); 
        FirebaseFirestore.instance.collection('employer').doc(user).collection('filter')
        .where('category', isEqualTo: widget.category)
        .snapshots().listen((data)  {
          setState(() {
            _autocity = data.docs[0]['city'];
            _autostate = data.docs[0]['state'];
            _religion = data.docs[0]['religion'];
            _duration = data.docs[0]['duration'];
            _gender = data.docs[0]['gender'];
            _budget = data.docs[0]['budget'];
            _yoe = data.docs[0]['yearofexp'];
            _pref = data.docs[0]['pref'];
            print('autofill City: $_autocity');
            print('autofill State: $_autostate');
            print('autofill Religion: $_religion');
            print('autofill Duration: $_duration');
            print('autofill Gender: $_gender');
            print('autofill budget: $_budget');
            print('autofill yoe: $_yoe');
            print('autofill pref: $_pref');
            // print(_religion.runtimeType);
            _citycontroller = TextEditingController(text: _autocity);
            _statecontroller = TextEditingController(text: _autostate);
          });
        }
      );
    }
      catch(e){
        print("Error: " + e);
    }
  }

  Future<void> getresults() async{
    try{
      // final user = await widget.auth.currentUser();
      FirebaseFirestore.instance
      .collection('helper')
      .where('city', isEqualTo: _citycontroller.text)
      .where('state', isEqualTo: _statecontroller.text)
      .where('category', isEqualTo: widget.category)
      .snapshots()
      .listen((data) {
        data.docs.forEach((result)async{
          FirebaseFirestore.instance
          .collection('helper')
          .doc(result['email'])
          .collection('profile')
          .where('religion', whereIn : _religion)
          .where('gender', whereIn: _gender)
          .where('duration', whereIn: _duration);
        });
      });
    }
    catch(e){
      print("Error in getting results: " + e);
    }
  }

  Future<void> setfilter(BuildContext context) async{
    try{
        final user = await widget.auth.currentUser();
        print(user); 
        FirebaseFirestore.instance
        .collection('employer')
        .doc(user)
        .collection('filter')
        .doc(widget.category)
        .update({
          'city': _city,
          'state': _state,
          'religion': _religion,
          'duration': _duration,
          'gender': _gender,
          'budget': _budget,
          'yearofexp': _yoe,
          'pref': _pref,
        });
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Result(auth: widget.auth, category: widget.category)));
    }
    catch(e){
        print("Error: " + e);
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
                    controller: _statecontroller,
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
                    onSaved: (value) => _state = value,
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
                    controller: _citycontroller,
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
                    onSaved: (value) => _city = value,
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20,10,20,5),
                  child: MultiSelectFormField(
                    fillColor: kPrimaryLightColor,
                    autovalidate: false,
                    chipBackGroundColor: kPrimaryColor,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: kPrimaryColor,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Religion",
                      style: TextStyle(fontSize: 16),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.length == 0) {
                    //     return 'Please select one or more options';
                    //   }
                    //   return null;
                    // },
                    dataSource: [
                      {
                        "display": "Hindu",
                        "value": "Hindu",
                      },
                      {
                        "display": "Muslim",
                        "value": "Muslim",
                      },
                      {
                        "display": "Christian",
                        "value": "Christian",
                      },
                      {
                        "display": "Others",
                        "value": "Others",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    // hintWidget: Text('Please choose one or more'),
                    
                    initialValue: _religion,
                    onSaved: (value) {
                      // print(value);
                      if (value == null || value.length == 0){
                          value = ['Hindu', 'Muslim', 'Christian', 'Others'];
                      }
                      setState(() {
                        print("SET STATE KA RELIGIONNNNNNN"); 
                        print(_religion);
                        _religion = value;
                      });
                    },
                  ), 
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20,10,20,5),
                  child: MultiSelectFormField(
                    fillColor: kPrimaryLightColor,
                    autovalidate: false,
                    chipBackGroundColor: kPrimaryColor,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: kPrimaryColor,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Duration (Per Day)",
                      style: TextStyle(fontSize: 16),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.length == 0) {
                    //     return 'Please select one or more options';
                    //   }
                    //   return null;
                    // },
                    dataSource: [
                      {
                        "display": "Less than 2 hours",
                        "value": "Less than 2",
                      },
                      {
                        "display": "2 - 4 hours",
                        "value": "2-4",
                      },
                      {
                        "display": "4 - 6 hours",
                        "value": "4-6",
                      },
                      {
                        "display": "More than 6 hours",
                        "value": "More than 6",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    // hintWidget: Text('Please choose one or more'),
                    initialValue: _duration,
                    onSaved: (value) {
                      if (value == null || value.length == 0){
                          value = ['Less than 2', '2-4', '4-6', 'More than 6'];
                      }
                      setState(() {
                        _duration = value;
                      });
                    },
                  ),

                  
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20,10,20,5),
                  child: MultiSelectFormField(
                    fillColor: kPrimaryLightColor,
                    autovalidate: false,
                    chipBackGroundColor: kPrimaryColor,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: kPrimaryColor,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text(
                      "Gender",
                      style: TextStyle(fontSize: 16),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.length == 0) {
                    //     return 'Please select one or more options';
                    //   }
                    //   return null;
                    // },
                    dataSource: [
                      {
                        "display": "Male",
                        "value": "Male",
                      },
                      {
                        "display": "Female",
                        "value": "Female",
                      },
                      {
                        "display": "Transgender",
                        "value": "Transgender",
                      },

                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    // hintWidget: Text('Please choose one or more'),
                    initialValue: _gender,
                    onSaved: (value) {
                      if (value == null || value.length == 0){
                          // if(_gender.isEmpty){
                          value = ['Male', 'Female', 'Transgender'];
                          // }
                      }
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),

                
               
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    width: size.width * 0.93,
                    height: size.height * 0.112,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expected Salary",style: TextStyle(fontSize: 16),),
                        Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        
                          children: <Widget>[
                            Radio(
                              activeColor: kPrimaryColor,
                              value: "Low to High",  
                              groupValue: _budget,  
                              onChanged: (String value) {  
                                setState(() {  
                                  _budget = value;  
                                });  
                              },  
                            ),
                            Text(
                              'Low to High',
                            ),

                            Radio(
                              activeColor: kPrimaryColor,
                              value: "High to Low",  
                              groupValue: _budget,  
                              onChanged: (String value) {  
                                setState(() {  
                                  _budget = value;  
                                });  
                              },  
                            ),
                            Text(
                              'High to Low',
                            ), 
                           
                          ],  
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    width: size.width * 0.93,
                    height: size.height * 0.112,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Years of Experience",style: TextStyle(fontSize: 16),),
                        Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Radio(
                              activeColor: kPrimaryColor,
                              value: "Low to High",  
                              groupValue: _yoe,  
                              onChanged: (String value) {  
                                setState(() {  
                                  _yoe = value;  
                                });  
                              },  
                            ),
                            Text(
                              'Low to High',
                            ),

                            Radio(
                              activeColor: kPrimaryColor,
                              value: "High to Low",  
                              groupValue: _yoe,  
                              onChanged: (String value) {  
                                setState(() {  
                                  _yoe = value;  
                                });  
                              },  
                            ),
                            Text(
                              'High to Low',
                            ), 
                            
                          ],  
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    width: size.width * 0.93,
                    height: size.height * 0.112,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select your main preference",style: TextStyle(fontSize: 16),),
                        Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        
                          children: <Widget>[
                            Radio(
                              activeColor: kPrimaryColor,
                              value: "Experience",  
                              groupValue: _pref,  
                              onChanged: (String value) {  
                                setState(() {  
                                  _pref = value;  
                                });  
                              },  
                            ),
                            Text(
                              "Experience",
                            ),

                            Radio(
                              activeColor: kPrimaryColor,
                              value: "Expected Salary",  
                              groupValue: _pref,  
                              onChanged: (String value) {  
                                setState(() {  
                                  _pref = value;  
                                });  
                              },  
                            ),
                            Text(
                              'Expected Salary',
                            ), 
                            
                          ],  
                        ),
                      ],
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
                  // color: kPrimaryColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      color: kPrimaryColor,
                      onPressed: (){
                        var form = formKey.currentState;
                        if (form.validate()) {
                          setState(() {
                            if(_gender.isEmpty){
                              _gender = ['Male', 'Female', 'Transgender'];
                            }
                            if(_religion.isEmpty){
                              _religion = ['Hindu', 'Muslim', 'Christian', 'Others'];
                            }
                            if(_duration.isEmpty){
                              _duration = ['Less than 2', '2-4', '4-6', 'More than 6'];
                            }
                          });
                          
                          form.save();
                          // setState(() {
                          //   _genderResult = _gender;
                          //   _durationResult = _duration.toString();
                          //   _religionResult = _religion.toString();
                          // });
                          setfilter(context);
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.all(16),
                //   child: Column(
                //     children: <Widget>[
                //       Text(_religionResult),
                //       Text(_durationResult),
                //       Text(_genderResult),
                //       Text(_budget),
                //       Text(_yoe),
                //     ],
                //   )
                // )
              ],
            ),
          ),
        ),
      ) 
    );
  }

  

}
