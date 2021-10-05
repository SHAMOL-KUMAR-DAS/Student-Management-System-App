import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Login With ${widget.type}',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Form(
        key: _formkey,
        //scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Text("Start with signing in",style: TextStyle(fontSize: 20),),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Image(image: AssetImage('assets/images/cover_logo.png'),height: 180,),
              // if (widget.type == 'Teacher')...[
              //   _Teacher_Sign_In()
              // ]
              // else if (widget.type == 'Student')...[
              //   _Student_Sign_In()
              // ],
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child:
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-Mail",
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Column(
                children: [
                  //SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.black),
                      obscureText: _obscureText,

                      decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: InkWell(
                            //onTap: VisiblePassword,
                            onTap: _toggle,
                            child: _obscureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
                          ),
                          labelStyle: TextStyle(color: Colors.black)
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              FlatButton(
                  color: Color(0xFFb7bdb9),
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    setState(() {
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
                      // else{
                      //   showDialog(context: context, builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: Text("Please Enter an Valid Password"),
                      //     );});
                      // }
                    });
                  },
                  child: Text("Sign In")),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text("Don't have an Account?"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FlatButton(
                  color: Color(0xFFb7bdb9),
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    // if(_email.isEmpty && _password.isEmpty || _email.isEmpty || _password.isEmpty){
                    // _showDeleteDialog() {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           title: Text('Delete'),
                    //           content: Text('Are you sure want to delete?'),
                    //           actions: [
                    //             FlatButton(
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: Text('Ok')),
                    //           ],
                    //         );
                    //       });
                    // }}
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sign_up(widget.type)));
                  },
                  child: Text("Sign Up",style: TextStyle(color: Colors.black),))
            ],
          ),
        ),
      ),
    );
  }
  // Widget _Teacher_Sign_In(){
  //   Container(
  //       height: MediaQuery.of(context).size.height * 0.2,
  //       child: Image(image: AssetImage('assets/images/teacher_in.png')));
  // }
  //
  // Widget _Student_Sign_In(){
  //   Container(
  //       height: MediaQuery.of(context).size.height * 0.2,
  //       child: Image(image: AssetImage('assets/images/stu_background.png')));
  // }
}
