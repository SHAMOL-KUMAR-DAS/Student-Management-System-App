import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:school_management/Config/color_config.dart';
import 'package:school_management/Student/information.dart';
import 'package:school_management/Teacher/information.dart';

class OTP_Verification extends StatefulWidget {
  String _email, type;
  OTP_Verification(this._email, this.type);
  @override
  _OTP_VerificationState createState() => _OTP_VerificationState(this._email);
}

class _OTP_VerificationState extends State<OTP_Verification> {
  String _email;
  _OTP_VerificationState(this._email);

  final TextEditingController _otpController = TextEditingController();

  void verifyOTP()async{
    var res = EmailAuth.validate(receiverMail: _email, userOTP: _otpController.text);
    if(res){
      if(widget.type == 'Student') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Student_Information(widget.type, widget._email)));
      }
      else if(widget.type == 'Teacher'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Information(widget.type, widget._email)));
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

  final FocusNode _pinFocus = FocusNode();
  BoxDecoration pinOtpDecoration = BoxDecoration(
      color: colors,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: Colors.grey
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       padding: EdgeInsets.only(left: 25, right: 25),
       child: PinPut(
         fieldsCount: 6,
         textStyle: TextStyle(fontSize: 25, color: textFormColor),
         eachFieldWidth: 40,
         eachFieldHeight: 50,
         focusNode: _pinFocus,
         controller: _otpController,
         submittedFieldDecoration: pinOtpDecoration,
         selectedFieldDecoration: pinOtpDecoration,
         followingFieldDecoration: pinOtpDecoration,
         pinAnimationType: PinAnimationType.rotation,
         autovalidateMode: AutovalidateMode.always,
         onSubmit: (otp) async{
           verifyOTP();
         },
       ),
      )
    );
  }
}
