import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Student_Notice extends StatefulWidget {
  String type;
  Student_Notice(this.type);
  @override
  _Student_NoticeState createState() => _Student_NoticeState();
}

class _Student_NoticeState extends State<Student_Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
          Firestore.instance.collection("Events").orderBy('Time', descending: false).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("No value");
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text(DateFormat.yMd().add_jm().format(document['Time'].toDate()),)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                        Center(child: Image(image: NetworkImage(document['Image'] ?? '',scale: 4))),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 25),
                          child: Text(document['Message'] ?? '', style: TextStyle(
                              fontSize: 12,
                              color: Colors.black
                          ),),
                        ),
                      ],
                    ),
                  );
              }).toList(),
            );
          }),
    );
  }
}
