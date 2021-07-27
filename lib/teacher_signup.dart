import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management/teacher_information.dart';

class Teacher_Signup extends StatefulWidget {
  @override
  _Teacher_SignupState createState() => _Teacher_SignupState();
}

class _Teacher_SignupState extends State<Teacher_Signup> {

  String _teacher_upemail, _teacher_uppassword;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void>Teacher_SignUp()async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        FirebaseUser newuser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _teacher_upemail, password: _teacher_uppassword);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>Teacher_Information()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFffa200),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Center(
              // child: Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage("https://cdn.pixabay.com/photo/2015/12/01/15/43/black-1072366__480.jpg"),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Image(image: NetworkImage("https://cdn.pixabay.com/photo/2014/04/03/09/59/teacher-309533__480.png",scale: 3),),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    // ),
                    // Text(
                    //   "WELCOME TO SCHOOL MANAGEMENT SYSTEM",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    Text(
                      "Teacher Signing up",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        onSaved: (input){
                          setState(() {
                            _teacher_upemail=input;
                          });
                        },
                        validator: (input){
                          if(input.isEmpty){
                            return "The E-mail Field is empty";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        onSaved: (input){
                          setState(() {
                            _teacher_uppassword=input;
                          });
                        },
                        validator: (input){
                          if(input.length<6){
                            return "Password is too small";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    FlatButton(
                        color: Colors.white,
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        onPressed: () {
                          setState(() {
                            Teacher_SignUp();
                          });
                        },
                        child: Text("REGISTER")),
                  ],
                ),
              ),
            ),
          ),

        ),
    //  ),
    );
  }
}
