import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Sign_In_Up/sign_in.dart';

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
                    image: AssetImage("assets/images/background.png"),
                    //NetworkImage("https://cdn.pixabay.com/photo/2016/09/10/12/40/grass-1659054_1280.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/cover_logo.png"),
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width*0.25,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Sign_In('Teacher')));
                            },
                            child: WavyAnimatedTextKit(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w400
                              ),
                              text: ["Login as a Teacher"],
                              isRepeatingAnimation: true,
                            ),
                          ),
                        ),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_In('Student')));
                              },
                              child: WavyAnimatedTextKit(
                                textStyle: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400
                                ),
                                text: ["Login as a Student"],
                                isRepeatingAnimation: true,
                              )
                          ),
                        ),
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
