import 'package:flutter/material.dart';
import 'package:school_management/teacher_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher_Information extends StatefulWidget {
  @override
  _Teacher_InformationState createState() => _Teacher_InformationState();
}

class _Teacher_InformationState extends State<Teacher_Information> {

  String genderchoose;
  List genderitem = ["Male", "Female", "Others"];

  String sectionchoose;
  List sectionitem = ["Science", "Commerce", "Arts", "Others"];

  String _t_fname,_t_lname,_t_id,_t_add,_t_contact,_t_email;

  Firestore information = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFe8f00a),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.05,
                // ),
                // Text(
                //   "Teacher Sign Up Page",
                //   style: TextStyle(
                //       fontSize: 26,
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.04,
                // ),
                Image(image: NetworkImage("https://cdn.pixabay.com/photo/2013/07/13/13/42/tux-161406__480.png",scale: 4)),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Text(
                  "Create your account",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: "First Name"),
                    onChanged: (input){
                      setState(() {
                        _t_fname=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: "Last Name"),
                    onChanged: (input){
                      setState(() {
                        _t_lname=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Teacher ID No."),
                    onChanged: (input){
                      setState(() {
                        _t_id=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:
                    InputDecoration(hintText: "Present Address"),
                    onChanged: (input){
                      setState(() {
                        _t_add=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Contact No."),
                    onChanged: (input){
                      setState(() {
                        _t_contact=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "E-mail Address"),
                    onChanged: (input){
                      setState(() {
                        _t_email=input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: DropdownButton(
                        dropdownColor: Color(0xFF4d4d44),
                        hint: Text("Gender"),
                        value: genderchoose,
                        onChanged: (newValue) {
                          setState(() {
                            genderchoose = newValue;
                          });
                        },
                        items: genderitem.map((valueitem) {
                          return DropdownMenuItem(
                              value: valueitem, child: Text(valueitem));
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 138),
                      child: DropdownButton(
                        dropdownColor: Color(0xFF4d4d44),
                        hint: Text("Expertise"),
                        value: sectionchoose,
                        onChanged: (newValue) {
                          setState(() {
                            sectionchoose = newValue;
                          });
                        },
                        items: sectionitem.map((valueitem) {
                          return DropdownMenuItem(
                              value: valueitem,
                              child: Text(
                                valueitem,
                              ));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FlatButton(
                    color: Color(0xFF4d4d44),
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_SignIn()));
                      setState(() {
                        information.collection('teacher_information').add(
                            {
                              'First_Name': _t_fname,
                              'Last_Name': _t_lname,
                              'Teacher_ID': _t_id,
                              'Address': _t_add,
                              'Contact': _t_contact,
                              'E-mail': _t_email,
                            }
                        );
                      });
                    },
                    child: Text(
                      "Save Information",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
