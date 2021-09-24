import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management/Sign_In_Up/sign_in.dart';
import 'package:school_management/coverpage.dart';

class Student_Information extends StatefulWidget {
  String type, email;
  Student_Information(this.type, this.email);
  @override
  _Student_InformationState createState() => _Student_InformationState();
}

class _Student_InformationState extends State<Student_Information> {

  String _fname,_lname,_roll,_add,_g_name,_g_num,_class;
  Firestore firestore = Firestore.instance;

  Future<void> sendDataStudent()async{
    var imageStorage = FirebaseStorage.instance.ref().child(_image.path);
    var put = imageStorage.putFile(_image);
    String imgurl = await (await put.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await (imgurl);
    if (_image != null && _fname != null && _lname != null && _class !=null && _roll != null
        && _add != null && _g_name != null && _g_num != null && _g_num.length == 11) {
      firestore.collection(widget.type).document(user.uid).setData({
        'First_Name': _fname,
        'Last_Name': _lname,
        'E-Mail': widget.email,
        'Roll': _roll,
        'Address': _add,
        'Guardian_Name': _g_name,
        'Guardian_Number': _g_num,
        'Class': _class,
        'Image': imgurl
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CoverPage()));
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
        backgroundColor: Color(0xFFe9f518),
        appBar: AppBar(
          backgroundColor: Color(0xFFe9f518),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "${widget.type} Account",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                  child: TextField(
                    decoration: InputDecoration(hintText: "First Name *"),
                    onChanged: (input){
                      setState(() {
                        _fname=input;
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
                    decoration: InputDecoration(hintText: "Last Name *"),
                    onChanged: (input){
                      setState(() {
                        _lname=input;
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
                    decoration: InputDecoration(
                        hintText: "Class *"),
                    onChanged: (input){
                      setState(() {
                        _class=input;
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
                    decoration: InputDecoration(hintText: "Roll No. *"),
                    onChanged: (input){
                      setState(() {
                        _roll=input;
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
                    keyboardType: TextInputType.text,
                    decoration:
                    InputDecoration(hintText: "Present Address *"),
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Guardian Name *"),
                    onChanged: (input){
                      setState(() {
                        _g_name=input;
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
                    keyboardType: TextInputType.phone,
                    decoration:
                    InputDecoration(hintText: "Guardian Contact No. *"),
                    onChanged: (input){
                      setState(() {
                        _g_num=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                FlatButton(
                    color: Colors.black,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    onPressed: () {
                      sendDataStudent();
                      if(_image == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Pick Your Image'),
                      );
                      });
                      }
                      else if(_fname == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter your First Name'),
                      );
                      });
                      }
                      else if(_lname == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Last Name'),
                      );
                      });
                      }
                      else if(_class == null){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Please Enter Your Class'),
                          );
                        });
                      }
                      else if(_roll == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Roll No'),
                      );
                      });
                      }
                      else if(_add == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Present Address'),
                      );
                      });
                      }
                      else if(_g_name == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Guardian Name'),
                      );
                      });
                      }
                      else if(_g_num == null || _g_num.length !=11){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Guardian Contact Number'),
                      );
                      });
                      }
                      else if(_class == null){
                      showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                      title: Text('Please Enter Your Class'),
                      );
                      });
                      }
                      // if (_image != null && _fname != null && _lname != null && _class !=null && _roll != null
                      //     && _add != null && _g_name != null && _g_num != null && _g_num.length == 11){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CoverPage()));
                      // }

                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_SignIn()));
                    },
                    child: Text("Save Information",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
