import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Get_Class with ChangeNotifier {

  File image;
  TextEditingController notice = TextEditingController();
  var ab = 'Shamol Kumar Das';

  Future cameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  Future galleryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }


  Future<void> sendData() async {
    var imageStorage = FirebaseStorage.instance.ref().child(image.path);
    var put = imageStorage.putFile(image);
    String imgurl = await (await put.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await (imgurl);
    Firestore.instance.collection('Notice').document().setData({
      'Image': imgurl,
      'Message': notice.text,
      'Time': DateTime.now(),
    });
    notifyListeners();
  }
  notifyListeners();

}
