import 'package:flutter/material.dart';
import 'package:school_management/homepage.dart';
import 'package:school_management/student_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Student_SignUp extends StatefulWidget {
  @override
  _Student_SignUpState createState() => _Student_SignUpState();
}

class _Student_SignUpState extends State<Student_SignUp> {
  String _upemail, _uppassword;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void>SignUp()async{
    final formstate =_formkey.currentState;
    if(formstate.validate()){
      formstate.save();
      try{
        FirebaseUser newuser= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _upemail, password: _uppassword);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_Information()));
      }catch(e){
        print(e.message);
      }
    }
  }

  bool hidePassword = true;

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
                    image: AssetImage("assets/images/stu_up_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Image(image: AssetImage("assets/images/stu_up.png"),
                        height: MediaQuery.of(context).size.height*0.2),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    Text(
                      "Create Your Account",
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
                            _upemail=input;
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
                            _uppassword=input;
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
                            suffixIcon: InkWell(
                                onTap: VisiblePassword,
                                child: Icon(Icons.visibility,color: Colors.white,)),
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
                            SignUp();
                          });
                        },
                        child: Text("REGISTER")),
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }

  void VisiblePassword(){
    if(hidePassword == true){
      hidePassword = false;
    }
    else{
      hidePassword = true;
    }
    setState(() {

    });
  }

}
