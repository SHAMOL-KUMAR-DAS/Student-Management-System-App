import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management/coverpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management/event.dart';
import 'package:school_management/exam.dart';
import 'package:school_management/result.dart';
import 'package:school_management/routine.dart';
import 'package:school_management/teacher_list.dart';

class Student_Home extends StatefulWidget {
  String type;
  Student_Home(this.type);
  @override
  _Student_HomeState createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> {
  String image, fname, lname, clas, roll, add, gname, gnum, gmail;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null)
      await Firestore.instance
          .collection(widget.type)
          .document(firebaseUser.uid)
          .get()
          .then((ds) {
        image = ds.data['Image'];
        fname = ds.data['First_Name'];
        lname = ds.data['Last_Name'];
        clas = ds.data['Class'];
        roll = ds.data['Roll'];
        add = ds.data['Address'];
        gname = ds.data['Guardian_Name'];
        gnum = ds.data['Guardian_Number'];
        gmail = ds.data['E-Mail'];
        //print(fname);
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                  return Text(fname + ' ' + lname);
                })),
        //actions: [
        //   FlatButton(onPressed: (){
        //     //Navigator.pop(context, MaterialPageRoute(builder: (context)=>CoverPage()));
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CoverPage()));
        //   }, child: Icon(Icons.logout,color: Colors.white,)),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CircleAvatar(
            //   radius: 110,
            //   backgroundImage: image !=null ? NetworkImage(image) : AssetImage('assets/images/teacher_in.png'),
            // ),
            FutureBuilder(
            future: _fetch(),
        builder: (context,snapshot){
          if(snapshot.connectionState!= ConnectionState.done)
            return Text("",style: TextStyle(color: Colors.white),);
          return Column(
            children: [
              CircleAvatar(
                radius: 90.0,
                backgroundImage: NetworkImage(image),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                'E-Mail: $gmail',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Class: $clas',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Roll No: $roll',
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.green,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Exam()));
                        },
                        child: Text(
                          "Exam Schedule",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.055,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Event()));
                        },
                        child: Text(
                          "Notice Board",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Card(
                color: Colors.yellow,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: FlatButton(
                      height: MediaQuery.of(context).size.height,
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Teacher_List()));
                      },
                      child: Text(
                        "Teacher Info",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Result()));
                        },
                        child: Text(
                          "Result",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.055,
                ),
                Card(
                  color: Colors.green,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Routine()));
                        },
                        child: Text(
                          "Class Routine",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
