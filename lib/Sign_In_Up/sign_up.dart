import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:school_management/OTP_Verification/otp_verification.dart';
import 'package:school_management/Student/information.dart';
import 'package:school_management/Teacher/information.dart';

class Sign_up extends StatefulWidget {
  String type;
  Sign_up(this.type);
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  String _password,_repassword;

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void sendOTP() async {
    EmailAuth.sessionName = 'Excel IT AI Student Management';
    var res = await EmailAuth.sendOtp(receiverMail: _inputController.text);
    if(res){
      print('Sent OTP Successfully');
    }
    else{
      showDialog(context: context, builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Please Enter Valid E-Mail"),
        );
      }
      );
    }
  }

  void verifyOTP()async{
    var res = EmailAuth.validate(receiverMail: _inputController.text, userOTP: _otpController.text);
    if(res){
      print('Sent OTP ${_inputController.text}');
      if(widget.type == 'Student') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Student_Information(widget.type,_inputController.text)));
      }
      else if(widget.type == 'Teacher'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Information(widget.type, _inputController.text)));
      }
    }
    else{
      showDialog(context: context, builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Invalid OTP"),
          content: Row(
            children: [
              new Text("Please Type Valid OTP"),
              FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          ),
        );
      }
      );
    }
  }

  final GlobalKey<FormState> _cformkey=GlobalKey<FormState>();
  Future<void> Sign_Up()async {
      final cformkey = _cformkey.currentState;
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (_inputController.text.endsWith('com')) {
        if (cformkey.validate()) {
          cformkey.save();
          try {
            if (_password.length >= 6 && _password == _repassword) {
              FirebaseUser newuser = await _auth
                  .createUserWithEmailAndPassword(
                  email: _inputController.text, password: _password);
              sendOTP();
              showDialog(
                  context: context, builder: (BuildContext context) {
                return AlertDialog(
                  //title: Text(''),
                  content: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _otpController,
                        decoration: InputDecoration(
                            hintText: "Type Your 6 digit OTP",
                            labelText: 'OTP'
                        ),
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.04,),
                      FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            verifyOTP();
                          },
                          child: Text('OTP Verification'))
                    ],
                  ),
                );
              });
            }
            else if (_password.length < 6) {
              showDialog(context: context, builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("Your Password is too Short"),
                  content: Text('Please Enter Password more than 5'),
                );
              }
              );
            }
            else if (_password != _repassword) {
              showDialog(context: context, builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("Please Enter Same Password"),
                );
              }
              );

            }
          }
          catch (e) {
            print(e.message);
            if (e.message ==
                'The email address is already in use by another account.') {
              showDialog(context: context, builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("The E-Mail Address is Already in Use"),
                );
              }
              );
            }
          }
        }
      }
      else if (_inputController.text.startsWith('+8801')) {
        //if (_password.length >= 6 && _password == _repassword) {
          await _auth.verifyPhoneNumber(
              phoneNumber: _inputController.text,
              timeout: Duration(seconds: 120),
              // verificationCompleted: (AuthCredential) async{
              //   var result = await _auth.signInWithCredential(AuthCredential);
              //   FirebaseUser user = result;
              //
              //   if(user != null){
              //     if(widget.type == 'Student'){
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_Information(widget.type, _inputController.text)));}
              //     else if(widget.type == 'Teacher'){
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Information(widget.type, _inputController.text)));}
              //   }
              // },
              verificationFailed: (exception) {
                print(exception);
              },
              codeSent: (String verificationId, [int token]) async {
                  showDialog(context: context, builder: (BuildContext context) {
                    return Center(
                      child: AlertDialog(
                        title: Text('Enter OTP'),
                        content: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _pinController,
                              obscureText: hidenpass,
                              decoration: InputDecoration(
                                labelText: 'OTP',
                                hintText: "Please Enter 6 digit OTP",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: FlatButton(
                                color: Colors.red,
                                onPressed: () async {
                                  //var smscode = _pinController.text;
                                  AuthCredential phoneauthcredential = PhoneAuthProvider
                                      .getCredential(
                                      verificationId: verificationId,
                                      smsCode: _pinController.text);
                                  var result = await _auth.signInWithCredential(
                                      phoneauthcredential);
                                  FirebaseUser user = result;

                                  if (user != null) {
                                    if (widget.type == 'Student') {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              Student_Information(widget.type,
                                                  _inputController.text)));
                                    }
                                    else if (widget.type == 'Teacher') {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              Teacher_Information(widget.type,
                                                  _inputController.text)));
                                    }
                                  }
                                },
                                child: Text('OTP Verification'),
                              ),
                            )
                          ],
                        ),),
                    );
                    //}
                  });
                // }
                // else if (_password.length < 6) {
                //   showDialog(context: context, builder: (BuildContext context) {
                //     return new AlertDialog(
                //       title: new Text("Your Password is too Short"),
                //       content: Text('Please Enter Password more than 5'),
                //     );
                //   }
                //   );
                // }
                // else if (_password != _repassword) {
                //   showDialog(context: context, builder: (BuildContext context) {
                //     return new AlertDialog(
                //       title: new Text("Please Enter Same Password"),
                //     );
                //   }
                //   );
                //
                // }
              },
              codeAutoRetrievalTimeout: (verificationId) {});

        // else if (_password.length < 6) {
        //   showDialog(context: context, builder: (BuildContext context) {
        //     return new AlertDialog(
        //       title: new Text("Your Password is too Short"),
        //       content: Text('Please Enter Password more than 5'),
        //     );
        //   }
        //   );
        // }
        // else if (_password != _repassword) {
        //   showDialog(context: context, builder: (BuildContext context) {
        //     return new AlertDialog(
        //       title: new Text("Please Enter Same Password"),
        //     );
        //   }
        //   );
        //
        // }
      }
  }

  bool hidenpass = true;
  void _togglePassView(){
    setState(() {
      hidenpass = !hidenpass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "${widget.type} Account",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: "Type Your E-Mail/Phone Number",
                      labelText: "E-Mail/Phone Number"
                    ),
                    validator: (input){
                      if(input.isEmpty){
                        return "Please Enter an E-Mail";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Form(
                  key: _cformkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          obscureText: hidenpass,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: "Suggest Password Abc12*",
                            suffixIcon: InkWell(
                              //onTap: VisiblePassword,
                              onTap: _togglePassView,
                              child: hidenpass? Icon(Icons.visibility_off):Icon(Icons.visibility),
                            ),
                          ),
                          onSaved: (input){
                            setState(() {
                              _password=input;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          obscureText: hidenpass,
                          decoration: InputDecoration(
                            labelText: 'Re-Type Password',
                            hintText: "Suggest Password Abc12*",
                            suffixIcon: InkWell(
                              //onTap: VisiblePassword,
                              onTap: _togglePassView,
                              child: hidenpass? Icon(Icons.visibility_off):Icon(Icons.visibility),
                            ),
                          ),
                          onSaved: (input){
                            setState(() {
                              _repassword=input;
                            });
                          },

                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                FlatButton(
                  color: Color(0xFF0fa7d6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Create Account"),
                  onPressed: (){
                      Sign_Up();
                      // if (_password.length >= 6 && _password == _repassword) {
                      //   sendOTP();}
                    //   showDialog(
                    //       context: context, builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       //title: Text(''),
                    //       content: Column(
                    //         children: [
                    //           TextFormField(
                    //             keyboardType: TextInputType.number,
                    //             controller: _otpController,
                    //             decoration: InputDecoration(
                    //                 hintText: "Type Your 6 digit OTP",
                    //                 labelText: 'OTP'
                    //             ),
                    //           ),
                    //           SizedBox(height: MediaQuery
                    //               .of(context)
                    //               .size
                    //               .height * 0.04,),
                    //           FlatButton(
                    //               color: Colors.red,
                    //               onPressed: () {
                    //                 verifyOTP();
                    //               },
                    //               child: Text('OTP Verification'))
                    //         ],
                    //       ),
                    //     );
                    //   });
                    //   }
                    //   else if (_password.length < 6) {
                    //     showDialog(context: context, builder: (BuildContext context) {
                    //       return new AlertDialog(
                    //         title: new Text("Your Password is too Short"),
                    //         content: Text('Please Enter Password more than 5'),
                    //       );
                    //     }
                    //     );
                    //   }
                    // else if (_password != _repassword) {
                    //   showDialog(context: context, builder: (BuildContext context) {
                    //     return new AlertDialog(
                    //       title: new Text("Please Enter Same Password"),
                    //     );
                    //   }
                    //   );
                    // }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}