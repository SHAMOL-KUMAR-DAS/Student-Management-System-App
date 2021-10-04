import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Teacher_Result extends StatefulWidget {
  String student_uid, image, fname, lname, roll, clas;
  Teacher_Result(
      this.student_uid, this.image, this.fname, this.lname, this.roll, this.clas);
  @override
  _Teacher_ResultState createState() => _Teacher_ResultState();
}

class _Teacher_ResultState extends State<Teacher_Result> {

  TextEditingController bangla1 = TextEditingController();
  TextEditingController bangla2 = TextEditingController();
  TextEditingController english2 = TextEditingController();
  TextEditingController english1 = TextEditingController();
  TextEditingController math = TextEditingController();
  TextEditingController social = TextEditingController();
  TextEditingController science = TextEditingController();
  TextEditingController religious = TextEditingController();
  TextEditingController ict = TextEditingController();
  TextEditingController optional = TextEditingController();

  Firestore firestore = Firestore.instance;

  Future<void> sendResult()async{
      firestore.collection('Result').document(widget.student_uid).setData({
        'Bangla1': bangla1.text,
        'English1': english1.text,
        'Math': math.text,
        'Bangla2': bangla2.text,
        'English2': english2.text,
        'Social_Science': social.text,
        'General_Science': science.text,
        'Religious': religious.text,
        'ICT': ict.text,
        'Optional': optional.text
      });
  }

  String groupchose;
  List group = [
    "Science",
    "Commerce",
    "Arts",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  widget.fname + ' ' + widget.lname,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
                ),
              ),
              Text('Roll: ${widget.roll}',style: TextStyle(
                fontSize: 18
              ),),
              Padding(
                padding: const EdgeInsets.only(left: 75, right: 75, top: 25),
                child: TextFormField(
                  controller: bangla1,
                  decoration: InputDecoration(
                      labelText: 'Bangla',
                      hintText: 'Out of 100'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75, right: 75),
                child: TextFormField(
                  controller: english1,
                  decoration: InputDecoration(
                      labelText: "English",
                      hintText: 'Out of 100'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75, right: 75),
                child: TextFormField(
                  controller: math,
                  decoration: InputDecoration(
                      labelText: "Math",
                      hintText: 'Out of 100'
                  ),
                ),
              ),
              if(widget.clas == '3' || widget.clas == '4' || widget.clas == '5')...[
                _classThreeToFiveResult()
              ]
              else if(widget.clas == '6' || widget.clas == '7' || widget.clas == '8')...[
                _classThreeToFiveResult(),
                _classSixToEightResult()
              ]
              else if(widget.clas == '9' || widget.clas == '10' || widget.clas == '11' || widget.clas == '12')...[
                  _classThreeToFiveResult(),
                  _classSixToEightResult(),
                  _classNineToTwelveResult()
                ],
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FlatButton(
                  color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: (){
                      sendResult();
                    },
                    child: Text('Put Mark')),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _classThreeToFiveResult(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: social,
            decoration: InputDecoration(
              labelText: 'Social Science',
              hintText: 'Out of 100'
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: science,
            decoration: InputDecoration(
              labelText: "General Science",
                hintText: 'Out of 100'
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: religious,
            decoration: InputDecoration(
                labelText: "Religious",
                hintText: 'Out of 100'
            ),
          ),
        ),
      ],
    );
  }
  Widget _classSixToEightResult(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: bangla2,
            decoration: InputDecoration(
                labelText: 'Bangla Second Paper',
                hintText: 'Out of 100'
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: english2,
            decoration: InputDecoration(
                labelText: "English Second Paper",
                hintText: 'Out of 100'
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: ict,
            decoration: InputDecoration(
                labelText: "ICT",
                hintText: 'Out of 100'
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: TextFormField(
            controller: optional,
            decoration: InputDecoration(
                labelText: "Agriculture / Home Science",
                hintText: 'Out of 100'
            ),
          ),
        ),
      ],
    );
  }
  Widget _classNineToTwelveResult(){
    return Column(
      children: [
        DropdownButton(
          iconEnabledColor: Colors.white,
          //style: TextStyle(decorationColor: Colors.white),
          dropdownColor: Color(0xFFe37c22),
          hint: Text(
            "Select Student Group",
            style: TextStyle(color: Colors.black),
          ),
          value: groupchose,
          onChanged: (newValue) {
            setState(() {
              groupchose = newValue;
            });
          },
          items: group.map((valueitem) {
            // if (groupchose == 'Science') {
            //   return
            //     Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 75, right: 75),
            //         child: TextFormField(
            //           controller: bangla2,
            //           decoration: InputDecoration(
            //               labelText: 'Physics',
            //               hintText: 'Out of 100'
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 75, right: 75),
            //         child: TextFormField(
            //           controller: bangla2,
            //           decoration: InputDecoration(
            //               labelText: 'Chemistry',
            //               hintText: 'Out of 100'
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 75, right: 75),
            //         child: TextFormField(
            //           controller: bangla2,
            //           decoration: InputDecoration(
            //               labelText: 'Higher Math',
            //               hintText: 'Out of 100'
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 75, right: 75),
            //         child: TextFormField(
            //           controller: bangla2,
            //           decoration: InputDecoration(
            //               labelText: 'Biology',
            //               hintText: 'Out of 100'
            //           ),
            //         ),
            //       ),
            //     ]
            //   );
            // }
            // else if (groupchose == 'Commerce') {
            //   return Column(
            //     children: [
            //       Text('commerce')
            //     ],
            //   );
            // }
            // else if (groupchose == 'Arts') {
            //   return Column(
            //     children: [
            //       Text('Arts')
            //     ],
            //   );
            // }
            return DropdownMenuItem(
                value: valueitem,
                child: Text(
                  valueitem,
                  style: TextStyle(color: Colors.black),
                ),
            );
          }).toList(),
        )
      ],
    );

  }
}
