// import 'package:flutter/material.dart';
// import 'package:email_auth/email_auth.dart';
// import 'package:school_management/Student/information.dart';
// import 'package:school_management/Teacher/information.dart';
//
// class OTP_Verification extends StatefulWidget {
//   String _email, type;
//   OTP_Verification(this._email, this.type);
//   @override
//   _OTP_VerificationState createState() => _OTP_VerificationState(this._email);
// }
//
// class _OTP_VerificationState extends State<OTP_Verification> {
//   String _email;
//   _OTP_VerificationState(this._email);
//
//   final TextEditingController _otpController = TextEditingController();
//
//   void verifyOTP()async{
//     var res = EmailAuth.validate(receiverMail: _email, userOTP: _otpController.text);
//     if(res){
//       if(widget.type == 'Student') {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => Student_Information(widget.type, widget._email)));
//       }
//       else if(widget.type == 'Teacher'){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_Information(widget.type, widget._email)));
//       }
//       }
//     else{
//       showDialog(context: context, builder: (BuildContext context) {
//         return new AlertDialog(
//           title: new Text("Invalid OTP"),
//           content: Row(
//             children: [
//               new Text("Please Type Valid OTP"),
//               FlatButton(
//                   onPressed: (){
//                     Navigator.pop(context);
//                   },
//                   child: Text('Ok'))
//             ],
//           ),
//         );
//       }
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.number,
//             controller: _otpController,
//             decoration: InputDecoration(
//                 hintText: "Type Your 6 digit OTP",
//                 labelText: 'OTP'
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
//           FlatButton(onPressed: (){
//             verifyOTP();
//           },
//               child: Text('OTP Verification'))
//         ],
//       ),
//
//     );
//   }
// }
