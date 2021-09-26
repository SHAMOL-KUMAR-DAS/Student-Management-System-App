import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  String _event, _event_date, _teacher;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null)
      await Firestore.instance
          .collection('student_information')
          .document(firebaseUser.uid)
          .get()
          .then((ds) {
        _event = ds.data['Event'];
        _event_date = ds.data['Event_Date'];
        _teacher = ds.data['Teacher_1'];
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF79f069),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              WavyAnimatedTextKit(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 32
                ),
                text: ["Upcoming Events..."],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              FutureBuilder(
                future: _fetch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text("No Data Available..");
                  return DataTable(columns: [
                    DataColumn(label: Text("Event Name")),
                    DataColumn(label: Text("Starting Date")),
                    DataColumn(label: Text("Event Director")),
                  ], rows: [
                    DataRow(cells: [
                      DataCell(Text("$_event")),
                      DataCell(Text("$_event_date")),
                      DataCell(Text("$_teacher"))
                    ])
                  ]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
