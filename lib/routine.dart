import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Routine extends StatefulWidget {
  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {

  String tname,sname;

  _fetch()async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser!=null)
      await Firestore.instance.collection('teacher_information').document().get().then((ds){
        tname=ds.data['Name'];
        sname=ds.data['Special'];
      }).catchError((e){
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,

      appBar: AppBar(
        //elevation: 0,
        title: Center(child: Text("Class Routine"))
      ),
      body: Center(
        child: DataTable(columns: [
          DataColumn(label: Text("Day/Time")),
          DataColumn(label: Text("9 - 10 AM")),
          DataColumn(label: Text("10 - 11 AM"))
        ], rows: [
          DataRow(cells: [
            DataCell(Text("Saturday")),
            DataCell(Text("Math Monyeem")),
            DataCell(Text("Physics Sakkhar")),
          ],),
          DataRow(cells: [
            DataCell(Text("Sunday")),
            DataCell(Text("Physics Sakkhar")),
            DataCell(Text("Math Monyeem")),
          ])
        ]),
      ),
    );
  }
}
