import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:school_management/Config/button_config.dart';
import 'package:school_management/Config/color_config.dart';
import 'package:school_management/Sign_In_Up/sign_up.dart';
import 'package:school_management/Student/home.dart';
import 'package:school_management/Teacher/home.dart';

class Sign_In extends StatefulWidget {
  String type;
  Sign_In(this.type);
  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  //String _email, _password;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> SignIn() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

          if (widget.type == 'Student'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_Home(widget.type)));
          }
          else if(widget.type == 'Teacher' && _emailController.text.endsWith('teacher.com')){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Home(user.uid, user.email, widget.type)));
          }
          else{
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: Text("Please Enter Correct Email"),
              );
            });
          }
      } catch (e) {
        if(e.message == 'The password is invalid or the user does not have a password.' ||
            e.message == 'Ignoring header X-Firebase-Locale because its value was null.' ||
            e.message == 'We have blocked all requests from this device due to unusual activity. Try again later. [ Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later. ]'){
          showDialog(context: context, builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Please Enter Valid Password"),
            );
          }
          );
        }

        if(e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.' ||
            e.message == 'Ignoring header X-Firebase-Locale because its value was null.'){
          showDialog(context: context, builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Please Enter Valid E-Mail"),
            );
          }
          );
        }
        print(e.message);
      }
    }
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: colors,
        title: Center(
          child: Text(
            'Login With ${widget.type}',
            style: TextStyle(
                fontSize: 25, color: buttonColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25, top: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Image(image: AssetImage('assets/images/cover_logo.png'),height: 180,),


                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 15),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: textFormColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      labelText: 'Email',
                      hintText: 'Enter Your Email',
                      prefixIcon: Icon(Icons.mail_outline),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: backColor
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colors
                        ),
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),

                TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black),
                  obscureText: _obscureText,
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    fillColor: textFormColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      labelText: "Password",
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                         color: backColor
                       ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: backColor
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      suffixIcon: InkWell(
                        //onTap: VisiblePassword,
                        onTap: _toggle,
                        child: _obscureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
                      ),
                    
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: ButtonConfig(
                    text: 'Sign In',
                    press: (){
                      SignIn();
                      if(_emailController.text.isEmpty){
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Please Enter an Email"),
                          );});
                      }
                      else if(_passwordController.text.isEmpty){
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Please Enter an Password"),
                          );});
                      }
                    },
                  ),
                ),

                Text("Don't have an Account?"),

                ButtonConfig(
                  text: 'Sign Up',
                  press: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sign_up(widget.type)));
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
