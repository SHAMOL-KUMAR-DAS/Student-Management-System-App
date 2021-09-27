import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Details/student_details.dart';

class Student_List extends StatefulWidget {
  String clas, userUid, userEmail;
  Student_List(this.clas, this.userUid, this.userEmail);
  @override
  _Student_ListState createState() => _Student_ListState();
}

class _Student_ListState extends State<Student_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0535f),
      body: StreamBuilder(
          stream:
          Firestore.instance.collection("Student").where('Class',isEqualTo:'${widget.clas}').orderBy('Roll').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("No value");
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                return FlatButton(
                  onPressed: (){
                    String student_uid = document.documentID;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_Details(student_uid, widget.userUid, widget.userEmail)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, left: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(document['Image']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 15),
                          child: Text(document['First_Name'] + ' ' + document['Last_Name'],style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),),
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xFF4f4e4a),
                          child: Text(document['Roll'],style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.w500,
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
