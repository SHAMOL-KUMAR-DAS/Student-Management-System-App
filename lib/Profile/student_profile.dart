import 'package:flutter/material.dart';

class Student_Profile extends StatefulWidget {
  String image, fname, lname, clas, roll, add, gname, gnum, gmail;
  Student_Profile(this.image, this.fname, this.lname, this.clas, this.roll, this.add, this.gname, this.gnum, this.gmail);
  @override
  _Student_ProfileState createState() => _Student_ProfileState();
}

class _Student_ProfileState extends State<Student_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0535f),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundImage: NetworkImage(widget.image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 10),
              child: Text(widget.fname + ' ' + widget.lname,style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),),
            ),
            Text(widget.gmail,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('Address: ${widget.add}',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),
            ),
            Text('Class: ${widget.clas}',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('Roll: ${widget.roll}',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),
            ),
            Text('Guardian Name: ${widget.gname}',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('Guardian Contact: ${widget.gnum}',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),
            )
          ],
        ),
      ),
    );
  }
}
