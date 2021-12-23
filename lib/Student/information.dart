import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:school_management/Config/button_config.dart';
import 'package:school_management/Config/color_config.dart';
import 'package:school_management/Front_Page/cover.dart';
import 'package:school_management/Provider/image_get.dart';
import 'package:school_management/Sign_In_Up/sign_in.dart';

class Student_Information extends StatefulWidget {
  String type, email;
  Student_Information(this.type, this.email);
  @override
  _Student_InformationState createState() => _Student_InformationState();
}

class _Student_InformationState extends State<Student_Information> {

  var fname = TextEditingController();
  var lname = TextEditingController();
  var roll = TextEditingController();
  var add = TextEditingController();
  var gName = TextEditingController();
  var gNum = TextEditingController();
  var clas = TextEditingController();

  Firestore firestore = Firestore.instance;

  Future<void> sendDataStudent()async{
    var imageStorage = FirebaseStorage.instance.ref().child(_image.path);
    var put = imageStorage.putFile(_image);
    String imgurl = await (await put.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await (imgurl);
    if (_image != null && fname.text != null && lname.text != null && clas.text !=null && roll.text != null
        && add.text != null && gNum.text != null && gName.text != null && gNum.text.length == 11) {
      firestore.collection(widget.type).document(user.uid).setData({
        'First_Name': fname.text,
        'Last_Name': lname.text,
        'E-Mail': widget.email,
        'Roll': roll.text,
        'Address': add.text,
        'Guardian_Name': gName.text,
        'Guardian_Number': gNum.text,
        'Class': clas.text,
        'Image': imgurl
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CoverPage()));
    }
    else if(_image == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Pick Your Image'),
        );
      });
    }
    else if(fname.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter your First Name'),
        );
      });
    }
    else if(lname.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Last Name'),
        );
      });
    }
    else if(clas.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Class'),
        );
      });
    }
    else if(roll.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Roll No'),
        );
      });
    }
    else if(add.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Present Address'),
        );
      });
    }
    else if(gName.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Guardian Name'),
        );
      });
    }
    else if(gNum.text == null || gNum.text.length !=11){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Guardian Contact Number'),
        );
      });
    }
    else if(clas.text == null){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Enter Your Class'),
        );
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
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: colors,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "${widget.type} Account",
              style: TextStyle(
                  fontSize: 26,
                  color: buttonColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                //First Name
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: TextFormField(
                    controller: fname,
                    style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                    autofillHints: [AutofillHints.name],
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter First Name',
                      fillColor: Color(0xFFffffff),
                      filled: true,
                      labelStyle: TextStyle(fontSize: 16),
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.account_circle),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: colors,
                            width: 2
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFFfffff),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 10, left: 20),
                      //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                    ),
                  ),
                ),

                //Last Name
                TextFormField(
                  controller: lname,
                  style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                  autofillHints: [AutofillHints.name],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter Last Name',
                    fillColor: Color(0xFFffffff),
                    filled: true,
                    labelStyle: TextStyle(fontSize: 16),
                    hintStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(Icons.account_circle),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: colors,
                          width: 2
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0xFFfffff),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                  ),
                ),

                //Class
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextFormField(
                    controller: clas,
                    style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Class',
                      hintText: 'Enter Your Class',
                      fillColor: Color(0xFFffffff),
                      filled: true,
                      labelStyle: TextStyle(fontSize: 16),
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.account_circle),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: colors,
                            width: 2
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFFfffff),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 10, left: 20),
                      //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                    ),
                  ),
                ),

                //Roll
                TextFormField(
                  controller: roll,
                  style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Roll',
                    hintText: 'Enter Your Roll',
                    fillColor: Color(0xFFffffff),
                    filled: true,
                    labelStyle: TextStyle(fontSize: 16),
                    hintStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(Icons.account_circle),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: colors,
                          width: 2
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0xFFfffff),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                  ),
                ),

                //Address
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextFormField(
                    controller: add,
                    style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter Your Address',
                      fillColor: Color(0xFFffffff),
                      filled: true,
                      labelStyle: TextStyle(fontSize: 16),
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.account_circle),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: colors,
                            width: 2
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFFfffff),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 10, left: 20),
                      //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                    ),
                  ),
                ),

                //Guardian Name
                TextFormField(
                  controller: gName,
                  style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                  autofillHints: [AutofillHints.name],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Guardian Name',
                    hintText: 'Enter Guardian Name',
                    fillColor: Color(0xFFffffff),
                    filled: true,
                    labelStyle: TextStyle(fontSize: 16),
                    hintStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(Icons.account_circle),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: colors,
                          width: 2
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0xFFfffff),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                  ),
                ),

                //Guardian Number
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: TextFormField(
                    controller: gNum,
                    style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                    autofillHints: [AutofillHints.name],
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Guardian Number',
                      hintText: 'Enter Guardian Number',
                      fillColor: Color(0xFFffffff),
                      filled: true,
                      labelStyle: TextStyle(fontSize: 16),
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.account_circle),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: colors,
                            width: 2
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xFFfffff),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 10, left: 20),
                      //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
                    ),
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width *0.7,
                  decoration: BoxDecoration(
                    color: Color(0xFFffffff),
                    border: Border.all(
                        width: 1,
                        color: colors
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image != null ? Stack(
                      children:[
                        Center(child: Image.file(_image,)),
                        Positioned(
                            right: -2,
                            top: -9,
                            child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 18,
                                ),
                                onPressed: () => setState(() {
                                  _image = null;
                                })))
                      ]) :
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Column(
                      children: [
                        Text('Select Your Image'),
                        SizedBox(height: 20,),
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
                                color: Color(0xFFe37c22),
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
                                  color: Color(0xFFe37c22)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ButtonConfig(
                    text: 'Save Information',
                    press: (){
                      sendDataStudent();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}