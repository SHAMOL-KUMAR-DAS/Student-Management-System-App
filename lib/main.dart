import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_management/Provider/image_get.dart';
import 'Front_Page/splash.dart';
import 'Student/information.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> Get_Class()),
          //another_one for another class
        ],
          child: MyApp()
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.solwayTextTheme(
          Theme.of(context).textTheme
        ),
        primarySwatch: Colors.red,
      ),
      //home: Splash(),
      home: Student_Information('',''),
      debugShowCheckedModeBanner: false,
    );
  }
}
