import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management/Teacher/teacher_notice.dart';
import 'package:school_management/Events/student_list_all.dart';
import 'package:school_management/Events/student_list_class.dart';
import 'package:school_management/Events/teacher_list.dart';
import 'package:school_management/Message/all_users_teacher.dart';

class Teacher_Home extends StatefulWidget {
  String userUid, userEmail, type;
  Teacher_Home(this.userUid, this.userEmail, this.type);
  @override
  _Teacher_HomeState createState() => _Teacher_HomeState();
}
class _Teacher_HomeState extends State<Teacher_Home> {
  String image, name, add, contact, id, gmail;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null)
      await Firestore.instance
          .collection(widget.type)
          .document(firebaseUser.uid)
          .get()
          .then((ds) {
        image = ds.data['Image'];
        name = ds.data['Name'];
        add = ds.data['Address'];
        contact = ds.data['Contact_No'];
        id = ds.data['ID_No'];
        gmail = ds.data['E-Mail'];
        //print(fname);
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0535f),
      appBar: AppBar(
        backgroundColor: Color(0xFFe0535f),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot){
                if (snapshot.connectionState != ConnectionState.done)
                  return Text('');
                return Text(name);
              }),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (context,snapshot){
                if(snapshot.connectionState!= ConnectionState.done)
                  return Text("",style: TextStyle(color: Colors.white),);
                return Column(
                  children: [
                    GestureDetector(
                      // onTap: (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_Profile(image,fname,lname,clas,roll,add,gname,gnum,gmail)));
                      // },
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: image != null ? NetworkImage(image) : AssetImage('assets/images/teacher_in.png'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'E-Mail: $gmail',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Contact: $contact',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'ID No: $id',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Address: $add',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    )
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      color: Colors.yellow,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FlatButton(
                            height: MediaQuery.of(context).size.height,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_All(widget.userUid, widget.userEmail)));
                            },
                            child: Text(
                              "Students",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.yellow,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_List(widget.userEmail)));
                          },
                          child: Text(
                            "Teacher",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      color: Colors.yellow,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FlatButton(
                            height: MediaQuery.of(context).size.height,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>All_Users_Teacher(widget.type, image)));
                            },
                            child: Text(
                              "Message",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.yellow,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Notice(widget.type)));
                          },
                          child: Text(
                            "Notice",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}