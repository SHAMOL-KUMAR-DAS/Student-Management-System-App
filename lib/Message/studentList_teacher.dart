import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management/Message/all_users_teacher.dart';
import 'package:school_management/Message/studentList_student.dart';
import 'package:school_management/Message/teacher_student.dart';
import 'package:school_management/Message/teacher_teacher.dart';

import 'chat_page.dart';

class StudentList_Teacher extends StatefulWidget {
  String type, image;
  StudentList_Teacher(this.type, this.image);
  @override
  _StudentList_TeacherState createState() => _StudentList_TeacherState();
}

class _StudentList_TeacherState extends State<StudentList_Teacher> {
  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFe37c22),
      appBar: AppBar(
        backgroundColor: Color(0xFFe37c22),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 10),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(widget.image),
            )),
        title: Center(
            child: Text(
              'Messaging',
              style: TextStyle(fontSize: 25),
            )),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>All_Users_Teacher(widget.type, widget.image)));
                  },
                  child: Text('All'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.black26,
                  onPressed: (){

                  },
                  child: Text('Student'),
                ),
              ),
              Expanded(
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Teacher(widget.type, widget.image, '')));
                    },

                    child: Text('Teacher'),
                  ))
            ],
          ),
          StreamBuilder(
              stream: Firestore.instance
                  .collection('Student')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data.documents.map((document) {
                        // if(user.email != document['E-Mail'] ?? "") {
                        //print(document['E-Mail'] ?? "");
                        //print('Shamol Kumar ${fname}');
                        // if (user.email == document['E-Mail']) {
                        //   return Container(
                        //     height: 0,
                        //     width: 0,
                        //   );
                        // } else {
                          //print(document['E-Mail']);
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.red,
                            child: ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  String userid = document.documentID;
                                  //print(user.uid);
                                  //if(document[''])
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chatting(
                                              user.uid,
                                              document['First_Name'],
                                              document['Last_Name'],
                                              userid,
                                              user.email,
                                              document['E-Mail'])));
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: CircleAvatar(
                                        radius: 10,
                                          backgroundColor: Color(0xFF4f4e4a),
                                          child: Text(document['Class'] ?? '',style: TextStyle(fontSize: 15),)),
                                    ),
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage:
                                      NetworkImage(document['Image'] ?? ""),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      document['First_Name'] ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      document['Last_Name'] ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: CircleAvatar(
                                        radius: 10,
                                          backgroundColor: Color(0xFF4f4e4a),
                                          child: Text(document['Roll'] ?? '',style: TextStyle(fontSize: 10),)),
                                    )
                                    //Text(widget.type)
                                  ],
                                ),
                              ),
                            ),
                          );
                        //}
                      }).toList());
                }
              }),
        ],
      ),
    );
  }
}
