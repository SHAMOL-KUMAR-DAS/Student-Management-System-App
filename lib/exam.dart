import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Exam extends StatefulWidget {
  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {

  String _sub1,_sub2,_sub3,_exam_date1,_exam_date2,_exam_date3,_exam_time,_exam_venue;

  _fetch()async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser!=null)
      await Firestore.instance.collection('student_information').document(firebaseUser.uid).get().then((ds){
        _sub1=ds.data['Subject_1'];
        _sub2=ds.data['Subject_2'];
        _sub3=ds.data['Subject_3'];
        _exam_date1=ds.data['Exam_Date1'];
        _exam_date2=ds.data['Exam_Date2'];
        _exam_date3=ds.data['Exam_Date3'];
        _exam_time=ds.data['Exam_Time'];
        _exam_venue=ds.data['Exam_Venue'];

      }).catchError((e){
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Center(child: Text("Exam Routine",)),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              FutureBuilder(
                future: _fetch(),
                builder: (context,snapshot){
                  if(snapshot.connectionState!= ConnectionState.done)
                    return Text("No Data Available..");
                  return DataTable(columns:[
                    DataColumn(label: Text("Exam Name")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Time")),
                    DataColumn(label: Text("Venue"))
                  ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("$_sub1")),
                          DataCell(Text("$_exam_date1")),
                          DataCell(Text("$_exam_time")),
                          DataCell(Text("$_exam_venue"))
                        ]),
                        DataRow(cells: [
                          DataCell(Text("$_sub2")),
                          DataCell(Text("$_exam_date2")),
                          DataCell(Text("$_exam_time")),
                          DataCell(Text("$_exam_venue"))
                        ]),
                        DataRow(cells: [
                          DataCell(Text("$_sub3")),
                          DataCell(Text("$_exam_date3")),
                          DataCell(Text("$_exam_time")),
                          DataCell(Text("$_exam_venue"))
                        ])
                      ]
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

