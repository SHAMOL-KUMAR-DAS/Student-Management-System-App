import 'package:flutter/material.dart';
import 'package:school_management/homepage.dart';
import 'package:school_management/student_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management/student_list.dart';
import 'package:school_management/teacher_signup.dart';

class Teacher_SignIn extends StatefulWidget {
  @override
  _Teacher_SignInState createState() => _Teacher_SignInState();
}

class _Teacher_SignInState extends State<Teacher_SignIn> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void>signIn()async{
    final formstate =_formkey.currentState;
    if(formstate.validate()){
      formstate.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_List()));
      }catch(e){
        print(e.message);
      }
    }
  }

  bool hidePassword=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://cdn.pixabay.com/photo/2015/12/01/15/43/black-1072366__480.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              child: Column(
                children: [
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Image(image: NetworkImage("https://cdn.pixabay.com/photo/2016/04/01/11/11/boy-1300242__480.png",scale: 3)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Text(
                    "Teacher Login",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.035,
                  // ),
                  // Text(
                  //   "Sign in to Continue",
                  //   style: TextStyle(fontSize: 16, color: Colors.white),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
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
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
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
                      style: TextStyle(color: Colors.white),
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(Icons.visibility,color: Colors.white,)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  FlatButton(
                      color: Colors.white,
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
                  Text("Don't have an account?",style: TextStyle(color: Colors.white),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  FlatButton(
                      color: Colors.white,
                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Signup()));
                      },
                      child: Text("SIGN UP"))
                ],
              ),
              ),
            ),
          ),

        ),
      ),
    );
  }

  void _togglePasswordView(){
    if(hidePassword == true){
      hidePassword=false;
    }else{
      hidePassword=true;
    }
    setState(() {

    });
  }

}
