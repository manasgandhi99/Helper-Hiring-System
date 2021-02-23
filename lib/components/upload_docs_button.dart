import 'package:flutter/material.dart';
import 'package:Helper_Hiring_System/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class UploadDocButton extends StatefulWidget {
  final String text;
  final Color color;
  const UploadDocButton({
    Key key,
    this.text,
    this.color = kPrimaryLightColor,
  }) : super(key: key);


  @override
  _UploadDocButtonState createState() => _UploadDocButtonState();
}

class _UploadDocButtonState extends State<UploadDocButton> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: widget.color,
          onPressed: _upload,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Icon(Icons.file_upload, color: kPrimaryColor,),
              ),
              SizedBox(width:size.width*0.035),
              Text(
              widget.text,style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          )
        ),
      ),
    );
  }

  void _upload() async{
    setState(() async{
      FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if(result != null) {
        List<File> files = result.paths.map((path) => File(path)).toList();
        for(int i=0;i<files.length;i++){
          print(files[i].path);
        }
      } else {
        // User canceled the picker
      }
      
    });
    
  }
}
