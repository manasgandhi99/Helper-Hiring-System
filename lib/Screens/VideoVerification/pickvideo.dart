import 'dart:io';
import 'package:Helper_Hiring_System/auth.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Image / Video Picker"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (_cameraVideo != null)
                  _cameraVideoPlayerController.value.initialized
                      ? AspectRatio(
                          aspectRatio:
                              _cameraVideoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_cameraVideoPlayerController),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text("Pick Video From Camera"),
                ),
                RaisedButton(
                    child: Text("Verify yourself"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Framer(auth: widget.auth, images: <Image>[], path: path, email: widget.email, file: widget.file, role: widget.role)),
                      );
                    })
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
