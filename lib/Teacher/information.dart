import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management/Sign_In_Up/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../coverpage.dart';

class Teacher_Information extends StatefulWidget {
  String type, email;
  Teacher_Information(this.type, this.email);
  @override
  _Teacher_InformationState createState() => _Teacher_InformationState();
}

class _Teacher_InformationState extends State<Teacher_Information> {

  String t_name,_add,_t_id,_t_contact;
  Firestore firestore = Firestore.instance;

  Future<void> sendDataTeacher()async {
    var imageStorage = FirebaseStorage.instance.ref().child(_image.path);
    var put = imageStorage.putFile(_image);
    String imgurl = await (await put.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await (imgurl);
    if (_image != null && t_name != null && _add != null && _t_id != null
        && _t_contact != null && _t_contact.length ==11) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CoverPage()));

      firestore.collection(widget.type).document(user.uid).setData({
        'Name': t_name,
        'Address': _add,
        'ID_No': _t_id,
        'Contact_No': _t_contact,
        'E-Mail': widget.email,
        'Image': imgurl
      });
    }
  }

  File _image;
  Future cameraImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future galleryImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFe8f00a),
        appBar: AppBar(
          backgroundColor: Color(0xFFe8f00a),
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Center(
            child: Text('Teacher Account',style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image(image: AssetImage("assets/images/teacher_info.png"),
                //   height: MediaQuery.of(context).size.height*0.15,),
                // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                // Text(
                //   "Create your account",
                //   style: TextStyle(
                //       fontSize: 16,
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  //width: MediaQuery.of(context).size.width * 0.3,
                  child: _image == null ? Text("") : Image.file(_image),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        cameraImage();
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
                        //color: Color(0xFFe37c22),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        galleryImage();
                      },
                      child: Icon(Icons.photo_library_outlined,
                        //    color: Color(0xFFe37c22)
                        color: Colors.black,
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: "Your Name *"),
                    onChanged: (input){
                      setState(() {
                        t_name=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: "Present Address *"),
                    onChanged: (input){
                      setState(() {
                        _add=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Your ID No. *"),
                    onChanged: (input){
                      setState(() {
                        _t_id=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25, right: 25),
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     decoration:
                //     InputDecoration(hintText: "Cover Class Time"),
                //     onChanged: (input){
                //       setState(() {
                //         _time=input;
                //       });
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.015,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Your Contact No. *"),
                    onChanged: (input){
                      setState(() {
                        _t_contact=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25, right: 25),
                //   child: TextFormField(
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: InputDecoration(hintText: "Cover Class Day"),
                //     onChanged: (input){
                //       setState(() {
                //         _day=input;
                //       });
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                FlatButton(
                    color: Color(0xFF4d4d44),
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: () {
                      sendDataTeacher();
                      // if (_image != null && t_name != null && _add != null && _t_id !=null
                      //     && _t_contact != null){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CoverPage()));
                      // }
                      if(_image == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Pick Your Image'),
                      );
                      });
                      }
                      else if(t_name == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Name'),
                      );
                      });
                      }
                      else if(_add == null){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Please Enter Your Address'),
                          );
                        });
                      }
                      else if(_t_id == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your ID'),
                      );
                      });
                      }
                      else if(_t_contact == null || _t_contact.length != 11){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Contact Number'),
                      );
                      });
                      }
                    },
                    child: Text(
                      "Save Information",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
