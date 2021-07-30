import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management/coverpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management/result.dart';
import 'package:school_management/routine.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String fname,lname,clas,roll,add,gname,gnum,gmail;

  _fetch()async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser!=null)
      await Firestore.instance.collection('student_information').document(firebaseUser.uid).get().then((ds){
        fname=ds.data['First_Name'];
        lname=ds.data['Last_Name'];
        clas=ds.data['Class'];
        roll=ds.data['Roll_No'];
        add=ds.data['Address'];
        gname=ds.data['Guardian'];
        gnum=ds.data['Guardian_Contact'];
        gmail=ds.data['Guardian_E-mail'];
        //print(fname);
      }).catchError((e){
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF39423b),
        appBar: AppBar(
          actions: [
            FlatButton(onPressed: (){
              //Navigator.pop(context, MaterialPageRoute(builder: (context)=>CoverPage()));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CoverPage()));
            }, child: Icon(Icons.logout))
          ],
        ),
        body:
          SingleChildScrollView(
            child:Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  child: FutureBuilder(
                    future: _fetch(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState!= ConnectionState.done)
                        return Text("Loading Data..");
                      return Column(
                        children: [
                          Text("Name: $fname $lname"),
                          Text("Class: $clas"),
                          Text("Roll No: $roll"),
                          Text("Address: $add"),
                          Text("Guardian Name: $gname"),
                          Text("Mobile No: $gnum"),
                          Text("E-Mail: $gmail")
                        ],
                      );
                    },
                  ),
                ),
                
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.green,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {},
                          child: Text("Exam Schedule",style: TextStyle(fontSize: 18),)),),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.055,
                    ),
                    Card(
                      color: Colors.yellow,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {},
                          child: Text("Event Schedule",style: TextStyle(fontSize: 18),)),),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.yellow,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Result()));
                          },
                          child: Text("Result",style: TextStyle(fontSize: 20),)),),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.055,
                    ),
                    Card(
                      color: Colors.green,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FlatButton(
                            height: MediaQuery.of(context).size.height,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Routine()));
                            },
                            child: Text("Class Routine",style: TextStyle(fontSize: 18),)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
      )
    );
  }
}
