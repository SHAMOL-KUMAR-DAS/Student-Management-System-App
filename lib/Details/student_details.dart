import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Message/chat_page.dart';

class Student_Details extends StatefulWidget {
  String student_uid, userUid, userEmail;
  Student_Details(this.student_uid, this.userUid, this.userEmail);
  @override
  _Student_DetailsState createState() => _Student_DetailsState();
}

class _Student_DetailsState extends State<Student_Details> {

  String image, fname, lname, clas, roll, add, gname, gnum, gmail;

  _fetch() async {
      await Firestore.instance
          .collection('Student')
          .document(widget.student_uid)
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
      }).catchError((e) {
        print(e);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0535f),
      body: Center(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context,snapshot){
            if(snapshot.connectionState!= ConnectionState.done)
              return Text("",style: TextStyle(color: Colors.white),);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90.0,
                  backgroundImage: NetworkImage(image),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    fname + ' ' + lname,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Text(
                  'E-Mail: $gmail',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Class: $clas',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Text(
                  'Roll No: $roll',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Address: $add',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
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
                                // onPressed: () {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_List('2')));
                                // },
                                child: Text(
                                  "Result",
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
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: FlatButton(
                              height: MediaQuery.of(context).size.height,
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Chatting(widget.userUid,fname,lname, widget.student_uid, widget.userEmail, gmail)));
                                print('User : ${widget.userUid}');
                                print(widget.student_uid);
                              },
                              child: Text(
                                "Message",
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
