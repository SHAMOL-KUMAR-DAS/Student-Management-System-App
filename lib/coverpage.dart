import 'package:flutter/material.dart';
import 'package:school_management/student_signin.dart';
import 'package:school_management/teacher_signin.dart';

class CoverPage extends StatefulWidget {
  @override
  _CoverPageState createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
              image: DecorationImage(
              image: NetworkImage("https://cdn.pixabay.com/photo/2016/09/10/12/40/grass-1659054_1280.jpg"),
              fit: BoxFit.cover,
            ),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Image(image: NetworkImage("https://cdn.pixabay.com/photo/2013/03/29/13/39/home-97609_1280.png",scale: 10),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Card(
                  color: Colors.red,
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher_SignIn()));
                            },
                            child: Text(
                              "Login as a Teacher",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ))),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Card(
                  color: Colors.red,
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: FlatButton(
                          height: MediaQuery.of(context).size.height,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Student_SignIn()));
                            },
                            child: Text(
                              "Login as a Student",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ))),
                  ),
                ),
              ],
            ),
          )
    ),
      )
    );
  }
}
