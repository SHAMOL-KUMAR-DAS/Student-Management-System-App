import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Student_List extends StatefulWidget {
  @override
  _Student_ListState createState() => _Student_ListState();
}
class _Student_ListState extends State<Student_List> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Students List")),
      ),
      body: StreamBuilder(
            stream: Firestore.instance.collection("student_information").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
              if(!snapshot.hasData){
                return Text("No value");
              }
              return ListView(
                children: snapshot.data.documents.map((document){
                  return Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("\t Name: "+document['First_Name'] ?? "No Data Available"),
                            Text("\t Class: "+document['Class'] ?? "No Data Available"),
                            Text("\t Roll: "+document['Roll_No'] ?? "No Data Available"),
                          ],

                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,)
                    ],
                  );
                }).toList(),
              );
              }
          ),

    );
  }
}

