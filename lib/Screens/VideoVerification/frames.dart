import 'package:Helper_Hiring_System/Screens/Helper%20Screens/profile_creation.dart';
import 'package:Helper_Hiring_System/Screens/VideoVerification/pickvideo.dart';
import 'package:Helper_Hiring_System/auth.dart';
import 'package:Helper_Hiring_System/root_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:export_video_frame/export_video_frame.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ImageItem extends StatelessWidget {
  // displays images extracted from a video
  ImageItem({this.image}) : super(key: ObjectKey(image));
  final Image image;
  @override
  Widget build(BuildContext context) {
    return Container(child: image);
  }
}

class Framer extends StatefulWidget {
  Framer({Key key, this.auth, this.images, this.email, this.path, this.file, this.role}) : super(key: key);
  final BaseAuth auth;
  final List<Image> images;
  final String path;
  final String email;
  final String role;
  final File file;
  @override
  _FramerState createState() => _FramerState();
}

class _FramerState extends State<Framer> {
  // final picker = ImagePicker();
  // final user = FirebaseAuth.instance.currentUser;
  var _isClean = false;
  var flag = false;
  List<String> uploadedURLs = [];

// static Future<bool> saveImage(File file, String albumName,{String waterMark,Alignment alignment,double scale}) async {
//     Map<String,dynamic> para = {"filePath":file.path,"albumName":albumName};
//     if (waterMark != null) {
//       para.addAll({"waterMark":waterMark});
//       if (alignment != null) {
//         para.addAll({"alignment":{"x":alignment.x,"y":alignment.y}});
//       } else {
//         para.addAll({"alignment":{"x":1,"y":1}});
//       }
//       if (scale != null) {
//         para.addAll({"scale":scale});
//       } else {
//         para.addAll({"scale":1.0});
//       }
//     }
//     final bool result =
//         await _channel.invokeMethod('saveImage', para);
//     return result;
//   }

  // Future<List<String>> uploadFiles(List<File> _images) async {
  //   List<String> imagesUrls = [];
  //   print("Upload docs wala user\n");
  //   print(user);
  //   String id = user.uid;
  //   _images.forEach((_image) async {
  //     String imageRef = id + '/' + DateTime.now().toString();
  //     print(imageRef);
  //     Reference ref = FirebaseStorage.instance.ref(imageRef);
  //     UploadTask uploadTask = ref.putFile(_image);
  //     uploadTask.then((res) async {
  //       String URL = await res.ref.getDownloadURL();
  //       // print(URL);
  //       uploadedURLs.add(URL);
  //     });
  //   });
  //   return imagesUrls;
  // }
  void getResponse(List<String> imageList, BuildContext context) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = "https://66ddb923c70b.ngrok.io/home?doc=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2FFurrr.jpg?alt=media&token=1f8c10b3-6b71-4c99-939b-7fa290509fda&frame1=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2Fsam-bhai1.png?alt=media&token=97a170f5-93df-4367-9492-ab857dee1c47&frame2=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2Fsam-bhai2.png?alt=media&token=eb6281b6-e523-4c14-9f18-cfd759ff8e7e&frame3=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2Fsam-bhai3.png?alt=media&token=a2363af5-9d30-45f5-b93a-b16d54b4894e";  

        // Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
        // https://2eab1c6ed332.ngrok.io/home?doc=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2FFurrr.jpg?alt=media&token=1f8c10b3-6b71-4c99-939b-7fa290509fda&frame1=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2Fsam-bhai1.png?alt=media&token=97a170f5-93df-4367-9492-ab857dee1c47&frame2=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2Fsam-bhai2.png?alt=media&token=eb6281b6-e523-4c14-9f18-cfd759ff8e7e&frame3=https://firebasestorage.googleapis.com/v0/b/e-kyc-34a84.appspot.com/o/100560013326805107879%2Fsam-bhai3.png?alt=media&token=a2363af5-9d30-45f5-b93a-b16d54b4894e

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var value = jsonResponse['value'];
      print('Value: $value.');
      if(value==1){
        if(widget.role=='employer'){
          Navigator.pop(context);
          Navigator.push(context , MaterialPageRoute(builder: (context) => RootPage(auth :widget.auth)));
        }else{
          Navigator.pop(context);
          Navigator.push(context , MaterialPageRoute(builder: (context) => ProfileCreation(auth :widget.auth)));
        }
      }
      else{
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PickVideo(auth: widget.auth, email: widget.email ,file: widget.file, role: 'helper')));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // void uploadFrames(List <Image> imageList) async {
  //   // final user = await widget.auth.currentUser();
  //   // List <Image> finalImageList = [imageList[0], imageList[1], imageList[2]];
  //   for(int i=0; i<3; i++){
  //     File imageFile = imageList[0];
  //     String videoRef = widget.email + '/' + "frames" + '/' + imageList[0].toString();
  //     print("Video Reference: " + videoRef);
  //     await FirebaseStorage.instance.ref(videoRef).putFile(imageList[0]);
  //   }
  //   // videoRef = videoFile.path;
  //   // print("Video Reference after storing in firebase storage: " + videoRef);
  // }

  Future _getImages() async {
    print("Video path from get Images" + widget.path);
    var images = await ExportVideoFrame.exportImage(widget.path, 4, 0.5);
    print("export image done");
    for(int i=0; i<3; i++){
      // File imageFile = imageList[0];
      // String videoRef = widget.email + '/' + "frames" + '/' + images[i].toString();
      String videoRef = widget.email + '/' + "image" + "$i";
      print("Video Reference: " + videoRef);
      // await FirebaseStorage.instance.ref(videoRef).putFile(images[i]);
      String imageUrl = await (await FirebaseStorage.instance.ref(videoRef).putFile(images[i])).ref.getDownloadURL();
      uploadedURLs.add(imageUrl);
    }
    var result = images.map((file) => Image.file(file)).toList();
    print("Uploaded URLS");
    print(uploadedURLs);
    setState(() {
      print("setstate k andar aaya");
      widget.images.addAll(result);
      _isClean = true;
      //* Get Response call
      // getResponse(uploadedURLs, context);
    });
    // print(result[0]);
    // List<String> uploadedImages = await uploadFiles(images);
    // print(uploadedImages);
    // List <File> fileRes =
  }

  Future _cleanCache() async {
    var result = await ExportVideoFrame.cleanImageCache();
    print(result);
    setState(() {
      widget.images.clear();
      _isClean = false;
    });
  }

  Future _handleClickFirst() async {
    if (_isClean) {
      await _cleanCache();
    } else {
      await _getImages();
    }
  }

  @override
  void initState() {
    super.initState();
    _handleClickFirst();
  }

  @override
  Widget build(BuildContext context) {
    print("widget images length: ");
    // _handleClickFirst(context);
    print(widget.images.length);
    return Scaffold(
      body: Column(
        children: [
          widget.images.length > 2
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    heightFactor: MediaQuery.of(context).size.height / 64,
                    child: Text('Framing is done')),
                // RaisedButton(
                //   onPressed: 
                // ),

              ],
            )
            // flag ? 
            // Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [Text('1: Framing is done'), Text('2: Getting Response from Server. Please Wait...')],
            //     ) : 
            //     Center(
            //     heightFactor: MediaQuery.of(context).size.height / 64,
            //     child: Text('Framing is done'))
            : Center(
                heightFactor: MediaQuery.of(context).size.height / 64,
                // padding: EdgeInsets.all(100),
                child: Column(
                  children: [
                    Text('Please wait while we process your information'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ],
                )),
          // Expanded(
          //   flex: 1,
          //   child: GridView.extent(
          //       maxCrossAxisExtent: 400,
          //       childAspectRatio: 1.0,
          //       padding: const EdgeInsets.all(4),
          //       mainAxisSpacing: 4,
          //       crossAxisSpacing: 4,
          //       children: widget.images.length > 0
          //           ? widget.images
          //               .map((image) => ImageItem(image: image))
          //               .toList()
          //           : [Container()]),
          // ),
        ],
      ),
    );
  }
}
