import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Teacher_Profile extends StatefulWidget {
  String teacher_uid;
  Teacher_Profile(this.teacher_uid);
  @override
  _Teacher_ProfileState createState() => _Teacher_ProfileState();
}

class _Teacher_ProfileState extends State<Teacher_Profile> {

  String image, name, contact, add, id_no, gmail;

  _fetch() async {
      await Firestore.instance
          .collection('Teacher')
          .document(widget.teacher_uid)
          .get()
          .then((ds) {
        image = ds.data['Image'];
        name = ds.data['Name'];
        contact = ds.data['Contact_No'];
        add = ds.data['Address'];
        id_no = ds.data['ID_No'];
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
                image != null ?
                CircleAvatar(
                  radius: 120.0,
                  backgroundImage: NetworkImage(image),
                ) : Text(''),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child:
                  name != null? Text(
                    name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ) : Text(''),
                ),
                gmail != null ? Text(gmail,
                style: TextStyle(fontSize: 18, color: Colors.white),) : Text(''),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child:
                  contact != null? Text(
                    contact,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ) : Text(''),
                ),
                add != null?
                Text(
                  add,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ) : Text(''),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child:
                  id_no != null ? Text(
                    id_no,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ) : Text(''),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
