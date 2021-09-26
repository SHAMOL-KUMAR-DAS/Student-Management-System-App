import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Student/information.dart';
//import 'package:school_management/student_signin.dart';
import 'package:splashscreen/splashscreen.dart';
import 'cover.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.lightGreenAccent,
      navigateAfterSeconds:
      CoverPage(),
      //Teacher_Information('Teacher'),
      //Student_Information('',''),
      // FutureBuilder(
      //     future: FirebaseAuth.instance.currentUser(),
      //     builder: (context, AsyncSnapshot<dynamic> snapshot){
      //       if(snapshot.hasData){
      //         return Homepage();
      //       } else{
      //         return CoverPage();
      //       }
      //     }),
      seconds: 3,
      loadingText: Text("School Management System"),
    );
  }
}
