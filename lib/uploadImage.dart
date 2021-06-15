import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadImage{
  String uploadURL = "https://skyva-app.herokuapp.com/user/img";
  Dio dio = Dio();

  uploadImageFile(File imageFile) async{
    String fileName = imageFile.path;
    print("UPLOADING IMAGE: $fileName");

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path,
          filename: fileName,
          contentType: new MediaType('image', 'png')),
      'type': 'image/png',
      'email': 'abcd@gmail.com'
    });

    Response response = await dio.post(uploadURL, data: formData);
    print("RESPONSE: ${response.statusCode}");
  }
}






// uploadImage(File imageFile) async {
//   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//   var length = await imageFile.length();
//
//   var uri = Uri.parse(uploadURL);
//
//   var request = new http.MultipartRequest("POST", uri);
//   var multipartFile = new http.MultipartFile('file', stream, length,
//       filename: basename(imageFile.path));
//   //contentType: new MediaType('image', 'png'));
//
//   request.files.add(multipartFile);
//   var response = await request.send();
//   print("RESPONSE CODE: ${response.statusCode}");
//   // response.stream.transform(utf8.decoder).listen((value) {
//   //   print(value);
//   // });
// }