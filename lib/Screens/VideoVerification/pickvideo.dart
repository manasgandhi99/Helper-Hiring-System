import 'dart:io';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import './frames.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PickVideo extends StatefulWidget {
  final BaseAuth auth;
  final String email;
  final String file;
  final String role;
  PickVideo({this.auth, this.email, this.file, this.role});
  @override
  _PickVideoState createState() => _PickVideoState();
}

class _PickVideoState extends State<PickVideo> {
  File _cameraVideo;
  String path;
  ImagePicker picker = ImagePicker();

  // VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 5),
    );
    path = pickedFile.path;
    _cameraVideo = File(pickedFile.path);
    print(pickedFile.path);
    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      });
  }

  // void uploadVideo(File videoFile) async {
  //   final user = await widget.auth.currentUser();
  //   String videoRef = user + '/' + "videos" + '/' +videoFile.path.split('/').last;
  //   print("Video Reference: " + videoRef);
  //   await FirebaseStorage.instance.ref(videoRef).putFile(videoFile);
  //   videoRef = videoFile.path;
  //   print("Video Reference after storing in firebase storage: " + videoRef);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "AADHAR CARD VERIFICATION ",
          style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor
            )
          ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      // appBar: AppBar(
      //   title: Text("Image / Video Picker"),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _cameraVideo != null?
                  _cameraVideoPlayerController.value.initialized
                      ? Column(
                        children: [
                          AspectRatio(
                              aspectRatio:
                                  _cameraVideoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_cameraVideoPlayerController),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              "Click on verify in order to verify yourself.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                      ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                color: kPrimaryColor,
                                onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Framer(auth: widget.auth,images: <Image>[], path: path, email: widget.email, role: widget.role, file: widget.file)),
                                );
                                  
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.verified_sharp, color: Colors.white,),
                                    SizedBox(width: size.width*0.03),
                                    Text(
                                      "Verify",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(size.width * 0.05 ,size.height*0.016, size.width * 0.05, size.height*0.04),
                            child: Image.asset(
                                  "assets/images/selfie.png",
                                  height: size.height * 0.40,
                            ),
                          ),
                          SizedBox(height: size.height * 0.035),
                          Text(
                            "After clicking on start video, you will get 5 seconds to record a video of your face.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                    ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "Make sure your face is clearly visible in the video.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                    ),
                          ),
                          SizedBox(height: size.height * 0.035),
                          // RaisedButton(
                          //   onPressed: () {
                          //     _pickVideoFromCamera();
                          //   },
                          //   child: Text("Pick Video From Camera"),
                          // ),
                          
                          
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                color: kPrimaryColor,
                                onPressed: () async{
                                  _pickVideoFromCamera();
                                  
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.videocam_sharp, color: Colors.white,),
                                    SizedBox(width: size.width*0.03),
                                    Text(
                                      "Start Video",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ):Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(size.width * 0.05 ,size.height*0.016, size.width * 0.05, size.height*0.04),
                            child: Image.asset(
                                  "assets/images/selfie.png",
                                  height: size.height * 0.40,
                            ),
                          ),
                          SizedBox(height: size.height * 0.035),
                          Text(
                            "After clicking on start video, you will get 5 seconds to record a video of your face.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                    ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "Make sure your face is clearly visible in the video.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                    ),
                          ),
                          SizedBox(height: size.height * 0.035),
                          // RaisedButton(
                          //   onPressed: () {
                          //     _pickVideoFromCamera();
                          //   },
                          //   child: Text("Pick Video From Camera"),
                          // ),
                          
                          
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                color: kPrimaryColor,
                                onPressed: () async{
                                  _pickVideoFromCamera();
                                  
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.videocam_sharp, color: Colors.white,),
                                    SizedBox(width: size.width*0.03),
                                    Text(
                                      "Start Video",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  
                // RaisedButton(
                //     child: Text("Verify yourself"),
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 Framer(images: <Image>[], path: path)),
                //       );
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// RaisedButton(
//             child: Text("Verify yourself"),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         Framer(images: <Image>[], path: videoRef)),
//               );
//             })

// void uploadVideo(File videoFile) async {
//   final user = FirebaseAuth.instance.currentUser;
//   String email = user.email;
//   videoRef = email + '/' + videoFile.path.split('/').last;
//   // print(videoRef);
//   await FirebaseStorage.instance.ref(videoRef).putFile(videoFile);
//   videoRef = videoFile.path;
// }
