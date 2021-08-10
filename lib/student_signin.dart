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

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFe8736b),
        body: Form(
          key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      //0xFFeb740c
                    ),
                    Image(image: AssetImage("assets/images/stu_background.png"),
                      height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width*0.25,),
                    //SizedBox(height: MediaQuery.of(context).size.height*0.04,),
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
                      style: TextStyle(fontSize: 16,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w700),
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
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility))
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

  void _togglePasswordView(){
    if(isHiddenPassword == true){
      isHiddenPassword = false;
    }else{
      isHiddenPassword = true;
    }
    setState(() {

    });
  }

}
