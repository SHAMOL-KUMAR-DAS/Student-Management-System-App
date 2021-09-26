import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management/Profile/teacher_profile.dart';

class Teacher_List extends StatefulWidget {
  @override
  _Teacher_ListState createState() => _Teacher_ListState();
}

class _Teacher_ListState extends State<Teacher_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0535f),
      appBar: AppBar(
        backgroundColor: Color(0xFFe0535f),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(
          child: WavyAnimatedTextKit(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25
            ),
            text: ["Teachers List..."],
            isRepeatingAnimation: false,
          ),
        ),
      ),
      body: StreamBuilder(
          stream:
              Firestore.instance.collection("Teacher").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("No value");
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FlatButton(
                    onPressed: (){
                      String teacher_uid = document.documentID;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Profile(teacher_uid)));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(document['Image']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(document['Name'],style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),),
                        ),
                        // Text("Teacher ID: " + document['Teacher_ID'] ??
                        //     "No Data Available"),
                        // Text("Speciality: " + document['Special'] ??
                        //     "No Data Available"),
                        // Text("Contact No: " + document['Contact'] ??
                        //     "No Data Available"),
                        // Text("Cover Class: " +
                        //         document['Day'] +
                        //         " at " +
                        //         document['Time'] ??
                        //     "No Data Available"),
                        //Text("Free T: "+document['Time'] ?? "No Data Available"),
                        //SizedBox(height: MediaQuery.of(context).size.height*0.01,)
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
