import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'uploadImage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Saving and Retrieving Images'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  final picker = ImagePicker();
  String email = 'abcd@gmail.com';


  Future getImage(bool fromGallery) async {
    final pickedFile;
    if(fromGallery){
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    else{
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        UploadImage uploadImage = UploadImage();
        uploadImage.uploadImageFile(image!);
      }
      else {
        print('No image chosen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving and Retrieving Images'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: image == null
                    ? Text('No image selected')
                    : Image.file(image!),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network('https://skyva-app.herokuapp.com/user/img/$email'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () {
                print('Picking image from gallery');
                getImage(true);
              },
              child: Text('Pick image from gallery'),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                print('Picking image from camera');
                getImage(false);
              },
              child: Text('Click new image from camera'),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
