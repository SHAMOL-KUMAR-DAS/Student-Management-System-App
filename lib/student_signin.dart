import 'package:flutter/material.dart';
import 'package:school_management/homepage.dart';
import 'package:school_management/student_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management/student_signup.dart';

class Student_SignIn extends StatefulWidget {
  @override
  _Student_SignInState createState() => _Student_SignInState();
}

class _Student_SignInState extends State<Student_SignIn> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void>signIn()async{
    final formstate =_formkey.currentState;
    if(formstate.validate()){
      formstate.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
      }catch(e){
        print(e.message);
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1cfc03),
        body: Form(
          key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                // child: Container(
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: NetworkImage("https://cdn.pixabay.com/photo/2020/09/18/21/35/abstraction-5582994__480.jpg"),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      //0xFFeb740c
                    ),
                    Image(image: NetworkImage("https://cdn.pixabay.com/photo/2019/08/30/15/48/lock-4441691_1280.png",scale: 10)),
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    // Text(
                    //   "WELCOME TO SCHOOL MANAGEMENT SYSTEM",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    // Text(
                    //   "Student Sign In Page",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.035,
                    // ),
                    Text(
                      "STUDENT LOGIN",
                      style: TextStyle(fontSize: 16,),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right:50),
                      child: TextFormField(
                        onSaved: (input){
                          setState(() {
                            _email=input;
                          });
                        },
                        validator: (input){
                          if(input.isEmpty){
                            return "The E-mail Field is empty";
                          }
                          return null;
                        },
                        //style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            //labelStyle: TextStyle(color: Colors.white),
                            // enabledBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.white))
                          ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        onSaved: (input){
                          setState(() {
                            _password=input;
                          });
                        },
                        validator: (input){
                          if(input.length<6){
                            return "Password is too small";
                          }
                          return null;
                        },
                        //style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            //labelStyle: TextStyle(color: Colors.white),
                            // enabledBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.white))
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    FlatButton(
                        color: Color(0xFFd4d0b8),
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        onPressed: () {
                          setState(() {
                            signIn();
                          });
                        },
                        child: Text("SIGN IN")),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Text("Don't have an account?",),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    FlatButton(
                        color: Color(0xFFd4d0b8),
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_SignUp()));
                        },
                        child: Text("SIGN UP"))
                  ],
                ),
              //),
            ),

        ),
      ),
      ),
    );
  }
}
