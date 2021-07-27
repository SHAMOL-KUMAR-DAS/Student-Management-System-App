import 'package:flutter/material.dart';
import 'package:school_management/coverpage.dart';
import 'package:school_management/student_signin.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.lightGreenAccent,
      image: Image(
        image: AssetImage("images/school.jpg"),
        height: 150,
        width: 300,
        fit: BoxFit.fill,
      ),
      navigateAfterSeconds: CoverPage(),
      seconds: 3,
      loadingText: Text("School Management System"),
    );
  }
}
