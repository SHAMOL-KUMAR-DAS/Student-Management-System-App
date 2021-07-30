import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Container(),
      ),
    );
  }
}

