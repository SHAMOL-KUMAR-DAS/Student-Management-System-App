import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentResult extends StatefulWidget {
  String fname, lname, clas, roll;
  StudentResult(this.fname, this.lname, this.clas, this.roll);
  @override
  _StudentResultState createState() => _StudentResultState();
}
class _StudentResultState extends State<StudentResult> {

  String bangla1, bangla2, english1, english2, general_science, ict, math, optional, religious, social_science;

  String sixToEightTotal = '950', oneToTwoTotal = '300', threeToFiveTotal = '600';

  String bang1G = '', bang2G = '',
  eng1G = '', eng2G = '',
  mathG = '', socialG = '',
  scienceG = '', ictG = '',
  reliG = '', optG = '';

  var bang1M, bang2M, eng1M, eng2M, mathM, socialM, scienceM, ictM, reliM, optM;

  var totalMark, totalGrade, totalGPA = '';

  _fetch()async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser!=null)
      await Firestore.instance.collection('Result').document(firebaseUser.uid).get().then((ds){
        bangla1 = ds.data['Bangla1'];
        bangla2 = ds.data['Bangla2'];
        english1 = ds.data['English1'];
        english2 = ds.data["English2"];
        general_science = ds.data["General_Science"];
        ict = ds.data["ICT"];
        math = ds.data["Math"];
        optional = ds.data['Optional'];
        religious = ds.data['Religious'];
        social_science = ds.data['Social_Science'];

      }).catchError((e){
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFadbaff),
      appBar: AppBar(
        backgroundColor: Color(0xFFadbaff),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.fname + ' ' + widget.lname),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Text('Roll No: ${widget.roll}'),
              ),
              if(widget.clas == '1' || widget.clas =='2')...[
                _oneToTowResultView()
              ]
              else if(widget.clas == '3' || widget.clas == '4' || widget.clas == '5')...[
                _threeToFiveResultView()
              ]
              else if(widget.clas == '6' || widget.clas == '7' || widget.clas == '8')...[
                _sixToEightResultView()
                ]
            ],
          ),
        ),
      ),
    );
  }
  Widget _oneToTowResultView(){
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: _fetch(),
            builder: (context,snapshot){
              if(snapshot.connectionState!= ConnectionState.done)
                return Text("No Data Available..");
              else{
                if(bangla1 != null && english1 != null && math != null){
                  totalMark = int.parse(bangla1) + int.parse(english1) + int.parse(math);

                  if(int.parse(bangla1)<33){
                    bang1G = 'F';
                    bang1M = -50;
                  }
                  if(int.parse(english1)<33){
                    eng1G = 'F';
                    eng1M = -50;
                  }
                  if(int.parse(math)<33){
                    mathG = 'F';
                    mathM = -50;
                  }
                  if(int.parse(bangla1)>=33 && int.parse(bangla1)<=39){
                    bang1G = 'D';
                    bang1M = 1;
                  }
                  if(int.parse(english1)>=33 && int.parse(english1)<=39){
                    eng1G = 'D';
                    eng1M = 1;
                  }
                  if(int.parse(math)>=33 && int.parse(math)<=39){
                    mathG = 'D';
                    mathM = 1;
                  }
                  if(int.parse(bangla1)>=40 && int.parse(bangla1)<=49){
                    bang1G = 'C';
                    bang1M = 2;
                  }
                  if(int.parse(english1)>=40 && int.parse(english1)<=49){
                    eng1G = 'C';
                    eng1M = 2;
                  }
                  if(int.parse(math)>=40 && int.parse(math)<=49){
                    mathG = 'C';
                    mathM = 2;
                  }
                  if(int.parse(bangla1)>=50 && int.parse(bangla1)<=59){
                    bang1G = 'B';
                    bang1M = 2;
                  }
                  if(int.parse(english1)>=50 && int.parse(english1)<=59){
                    eng1G = 'B';
                    eng1M = 2;
                  }
                  if(int.parse(math)>=50 && int.parse(math)<=59){
                    mathG = 'B';
                    mathM = 2;
                  }
                  if(int.parse(bangla1)>=60 && int.parse(bangla1)<=69){
                    bang1G = 'A-';
                    bang1M = 3.5;
                  }
                  if(int.parse(english1)>=60 && int.parse(english1)<=69){
                    eng1G = 'A-';
                    eng1M = 3.5;
                  }
                  if(int.parse(math)>=60 && int.parse(math)<=69){
                    mathG = 'A-';
                    mathM = 3.5;
                  }
                  if(int.parse(bangla1)>=70 && int.parse(bangla1)<=79){
                    bang1G = 'A';
                    bang1M = 4;
                  }
                  if(int.parse(english1)>=70 && int.parse(english1)<=79){
                    eng1G = 'A';
                    eng1M = 4;
                  }
                  if(int.parse(math)>=70 && int.parse(math)<=79){
                    mathG = 'A';
                    mathM = 4;
                  }
                  if(int.parse(bangla1)>=80 && int.parse(bangla1)<=100){
                    bang1G = 'A+';
                    bang1M = 5;
                  }
                  if(int.parse(english1)>=80 && int.parse(english1)<=100){
                    eng1G = 'A+';
                    eng1M = 5;
                  }
                  if(int.parse(math)>=80 && int.parse(math)<=100){
                    mathG = 'A+';
                    mathM = 5;
                  }
                }
                totalGrade = (bang1M + eng1M + mathM) / 3;

                if(totalGrade<=0){
                  totalGPA = 'F';
                  totalGrade = 0;
                }
                if(totalGrade>=1 && totalGrade<=1.99){
                  totalGPA = 'D';
                }
                if(totalGrade>=2 && totalGrade<=2.99){
                  totalGPA = 'C';
                }
                if(totalGrade>=3 && totalGrade<=3.49){
                  totalGPA = 'B';
                }
                if(totalGrade>=3.50 && totalGrade<=3.99){
                  totalGPA = 'A-';
                }
                if(totalGrade>=4 && totalGrade<=4.99){
                  totalGPA = 'A';
                }
                if(totalGrade>=5){
                  totalGPA = 'A+';
                }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    DataTable(columns:[
                      DataColumn(label: Text("Subject Name")),
                      DataColumn(label: Text("Out of")),
                      DataColumn(label: Text("Mark")),
                      DataColumn(label: Text("Grade Point")),
                    ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text("Bangla")),
                            DataCell(Text("100")),
                            DataCell( bangla1 != null ? Text("$bangla1") : ''),
                            DataCell( bang1G != null ? Text("$bang1G") : '')
                          ]),
                          DataRow(cells: [
                            DataCell(Text("English")),
                            DataCell(Text("100")),
                            DataCell( english1 != null ? Text("$english1") : ''),
                            DataCell( eng1G != null ? Text("$eng1G") : '')
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Mathematics")),
                            DataCell(Text("100")),
                            DataCell( math != null ? Text("$math") : ''),
                            DataCell( mathG != null ? Text("$mathG") : '')
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Total")),
                            DataCell( oneToTwoTotal != null ?Text("$oneToTwoTotal") : ''),
                            DataCell(Text('$totalMark')),
                            DataCell(Text("GPA: $totalGPA (${totalGrade.toStringAsFixed(2)})"))
                          ])
                        ]
                    ),
                  ],
                ),
              );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _threeToFiveResultView(){
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: _fetch(),
            builder: (context,snapshot){
              if(snapshot.connectionState!= ConnectionState.done)
                return Text("No Data Available..");
              else{
                if(bangla1 != null && english1 != null && general_science != null && math != null && religious != null && social_science !=null){
                  totalMark = int.parse(bangla1) + int.parse(english1) + int.parse(math) + int.parse(social_science) + int.parse(general_science) + int.parse(religious);

                  if(int.parse(bangla1)<33){
                    bang1G = 'F';
                    bang1M = -50;
                  }
                  if(int.parse(english1)<33){
                    eng1G = 'F';
                    eng1M = -50;
                  }
                  if(int.parse(math)<33){
                    mathG = 'F';
                    mathM = -50;
                  }
                  if(int.parse(social_science)<33){
                    socialG = 'F';
                    socialM = -50;
                  }
                  if(int.parse(general_science)<33){
                    scienceG = 'F';
                    scienceM = -50;
                  }
                  if(int.parse(religious)<33){
                    reliG = 'F';
                    reliM = -50;
                  }

                  if(int.parse(bangla1)>=33 && int.parse(bangla1)<=39){
                    bang1G = 'D';
                    bang1M = 1;
                  }
                  if(int.parse(english1)>=33 && int.parse(english1)<=39){
                    eng1G = 'D';
                    eng1M = 1;
                  }
                  if(int.parse(math)>=33 && int.parse(math)<=39){
                    mathG = 'D';
                    mathM = 1;
                  }
                  if(int.parse(social_science)>=33 && int.parse(social_science)<=39){
                    socialG = 'D';
                    socialM = 1;
                  }
                  if(int.parse(general_science)>=33 && int.parse(general_science)<=39){
                    scienceG = 'D';
                    scienceM = 1;
                  }
                  if(int.parse(religious)>=33 && int.parse(religious)<=39){
                    reliG = 'D';
                    reliM = 1;
                  }

                  if(int.parse(bangla1)>=40 && int.parse(bangla1)<=49){
                    bang1G = 'C';
                    bang1M = 2;
                  }
                  if(int.parse(english1)>=40 && int.parse(english1)<=49){
                    eng1G = 'C';
                    eng1M = 2;
                  }
                  if(int.parse(math)>=40 && int.parse(math)<=49){
                    mathG = 'C';
                    mathM = 2;
                  }
                  if(int.parse(social_science)>=40 && int.parse(social_science)<=49){
                    socialG = 'C';
                    socialM = 2;
                  }
                  if(int.parse(general_science)>=40 && int.parse(general_science)<=49){
                    scienceG = 'C';
                    scienceM = 2;
                  }
                  if(int.parse(religious)>=40 && int.parse(religious)<=49){
                    reliG = 'C';
                    reliM = 2;
                  }

                  if(int.parse(bangla1)>=50 && int.parse(bangla1)<=59){
                    bang1G = 'B';
                    bang1M = 2;
                  }
                  if(int.parse(english1)>=50 && int.parse(english1)<=59){
                    eng1G = 'B';
                    eng1M = 2;
                  }
                  if(int.parse(math)>=50 && int.parse(math)<=59){
                    mathG = 'B';
                    mathM = 2;
                  }
                  if(int.parse(social_science)>=50 && int.parse(social_science)<=59){
                    socialG = 'B';
                    socialM = 2;
                  }
                  if(int.parse(general_science)>=50 && int.parse(general_science)<=59){
                    scienceG = 'B';
                    scienceM = 2;
                  }
                  if(int.parse(religious)>=50 && int.parse(religious)<=59){
                    reliG = 'B';
                    scienceM = 2;
                  }

                  if(int.parse(bangla1)>=60 && int.parse(bangla1)<=69){
                    bang1G = 'A-';
                    bang1M = 3.5;
                  }
                  if(int.parse(english1)>=60 && int.parse(english1)<=69){
                    eng1G = 'A-';
                    eng1M = 3.5;
                  }
                  if(int.parse(math)>=60 && int.parse(math)<=69){
                    mathG = 'A-';
                    mathM = 3.5;
                  }
                  if(int.parse(social_science)>=60 && int.parse(social_science)<=69){
                    socialG = 'A-';
                    socialM = 3.5;
                  }
                  if(int.parse(general_science)>=60 && int.parse(general_science)<=69){
                    scienceG = 'A-';
                    scienceM = 3.5;
                  }
                  if(int.parse(religious)>=60 && int.parse(religious)<=69){
                    reliG = 'A-';
                    reliM = 3.5;
                  }

                  if(int.parse(bangla1)>=70 && int.parse(bangla1)<=79){
                    bang1G = 'A';
                    bang1M = 4;
                  }
                  if(int.parse(english1)>=70 && int.parse(english1)<=79){
                    eng1G = 'A';
                    eng1M = 4;
                  }
                  if(int.parse(math)>=70 && int.parse(math)<=79){
                    mathG = 'A';
                    mathM = 4;
                  }
                  if(int.parse(social_science)>=70 && int.parse(social_science)<=79){
                    socialG = 'A';
                    socialM = 4;
                  }
                  if(int.parse(general_science)>=70 && int.parse(general_science)<=79){
                    scienceG = 'A';
                    scienceM = 4;
                  }
                  if(int.parse(religious)>=70 && int.parse(religious)<=79){
                    reliG = 'A';
                    reliM = 4;
                  }

                  if(int.parse(bangla1)>=80 && int.parse(bangla1)<=100){
                    bang1G = 'A+';
                    bang1M = 5;
                  }
                  if(int.parse(english1)>=80 && int.parse(english1)<=100){
                    eng1G = 'A+';
                    eng1M = 5;
                  }
                  if(int.parse(math)>=80 && int.parse(math)<=100){
                    mathG = 'A+';
                    mathM = 5;
                  }
                  if(int.parse(social_science)>=80 && int.parse(social_science)<=100){
                    socialG = 'A+';
                    socialM = 5;
                  }
                  if(int.parse(general_science)>=80 && int.parse(general_science)<=100){
                    scienceG = 'A+';
                    scienceM = 5;
                  }
                  if(int.parse(religious)>=80 && int.parse(religious)<=100) {
                    reliG = 'A+';
                    reliM = 5;
                  }
                }
                totalGrade = (bang1M + eng1M + mathM + socialM + scienceM +reliM) / 6;

                if(totalGrade<=0){
                  totalGPA = 'F';
                  totalGrade = 0;
                }
                if(totalGrade>=1 && totalGrade<=1.99){
                  totalGPA = 'D';
                }
                if(totalGrade>=2 && totalGrade<=2.99){
                  totalGPA = 'C';
                }
                if(totalGrade>=3 && totalGrade<=3.49){
                  totalGPA = 'B';
                }
                if(totalGrade>=3.50 && totalGrade<=3.99){
                  totalGPA = 'A-';
                }
                if(totalGrade>=4 && totalGrade<=4.99){
                  totalGPA = 'A';
                }
                if(totalGrade>=5){
                  totalGPA = 'A+';
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      DataTable(columns:[
                        DataColumn(label: Text("Subject Name")),
                        DataColumn(label: Text("Out of")),
                        DataColumn(label: Text("Mark")),
                        DataColumn(label: Text("Grade Point")),
                      ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text("Bangla")),
                              DataCell(Text("100")),
                              DataCell( bangla1 != null ? Text("$bangla1") : ''),
                              DataCell( bang1G != null ? Text("$bang1G") : '')
                            ]),
                            DataRow(cells: [
                              DataCell(Text("English")),
                              DataCell(Text("100")),
                              DataCell( english1 != null ? Text("$english1") : ''),
                              DataCell( eng1G != null ? Text("$eng1G") : '')
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Mathematics")),
                              DataCell(Text("100")),
                              DataCell( math != null ? Text("$math") : ''),
                              DataCell( mathG != null ? Text("$mathG") : '')
                            ]),
                            DataRow(cells: [
                              DataCell(Text("General Science")),
                              DataCell(Text("100")),
                              DataCell( general_science != null ? Text("$general_science") : ''),
                              DataCell( scienceG != null ? Text("$scienceG") : '')
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Social Science")),
                              DataCell(Text("100")),
                              DataCell( social_science != null ? Text("$social_science") : ''),
                              DataCell( socialG != null ? Text("$socialG") : '')
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Religious")),
                              DataCell(Text("100")),
                              DataCell( religious != null ? Text("$religious") : ''),
                              DataCell( reliG != null ? Text("$reliG") : '')
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Total")),
                              DataCell( threeToFiveTotal != null ? Text("$threeToFiveTotal") : ''),
                              DataCell( totalMark != null ? Text("$totalMark") : ''),
                              DataCell( totalGPA != null ? Text("GPA: $totalGPA (${totalGrade.toStringAsFixed(2)})") : ''),
                            ])
                          ]
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _sixToEightResultView(){
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: _fetch(),
            builder: (context,snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text("No Data Available..");
              else {
                  if (bangla1 != null && bangla2 != null && english1 != null &&
                      english2 != null && math != null &&
                      general_science != null && social_science != null &&
                      optional != null && ict != null && religious != null) {
                    totalMark = int.parse(bangla1) + int.parse(bangla2) +
                        int.parse(english1) + int.parse(english2) +
                        int.parse(math) + int.parse(general_science) +
                        int.parse(ict) + int.parse(optional) +
                        int.parse(religious) + int.parse(social_science);

                    if (int.parse(bangla1) < 33) {
                      bang1G = 'F';
                      bang1M = -50;
                    }
                    if (int.parse(english1) < 33) {
                      eng1G = 'F';
                      eng1M = -50;
                    }
                    if (int.parse(math) < 33) {
                      mathG = 'F';
                      mathM = -50;
                    }
                    if (int.parse(social_science) < 33) {
                      socialG = 'F';
                      socialM = -50;
                    }
                    if (int.parse(general_science) < 33) {
                      scienceG = 'F';
                      scienceM = -50;
                    }
                    if (int.parse(religious) < 33) {
                      reliG = 'F';
                      reliM = -50;
                    }
                    if (int.parse(bangla2) < 33) {
                      bang2G = 'F';
                      bang2M = -50;
                    }
                    if (int.parse(english2) < 33) {
                      eng2G = 'F';
                      eng2M = -50;
                    }
                    if (int.parse(ict) < 15) {
                      ictG = 'F';
                      ictM = -50;
                    }
                    if (int.parse(optional) < 33) {
                      optG = 'F';
                      optM = -50;
                    }
                    if (int.parse(bangla1) >= 33 && int.parse(bangla1) <= 39) {
                      bang1G = 'D';
                      bang1M = 1;
                    }
                    if (int.parse(english1) >= 33 &&
                        int.parse(english1) <= 39) {
                      eng1G = 'D';
                      eng1M = 1;
                    }
                    if (int.parse(math) >= 33 && int.parse(math) <= 39) {
                      mathG = 'D';
                      mathM = 1;
                    }
                    if (int.parse(social_science) >= 33 &&
                        int.parse(social_science) <= 39) {
                      socialG = 'D';
                      socialM = 1;
                    }
                    if (int.parse(bangla2) >= 33 && int.parse(bangla2) <= 39) {
                      bang2G = 'D';
                      bang2M = 1;
                    }
                    if (int.parse(english2) >= 33 &&
                        int.parse(english2) <= 39) {
                      eng2G = 'D';
                      eng2M = 1;
                    }
                    if (int.parse(ict) >= 15 && int.parse(ict) <= 19) {
                      ictG = 'D';
                      ictM = 1;
                    }
                    if (int.parse(optional) >= 33 &&
                        int.parse(optional) <= 39) {
                      optG = 'D';
                      optM = 1;
                    }
                    if (int.parse(general_science) >= 33 &&
                        int.parse(general_science) <= 39) {
                      scienceG = 'D';
                      scienceM = 1;
                    }
                    if (int.parse(religious) >= 33 &&
                        int.parse(religious) <= 39) {
                      reliG = 'D';
                      reliM = 1;
                    }
                    if (int.parse(bangla1) >= 40 && int.parse(bangla1) <= 49) {
                      bang1G = 'C';
                      bang1M = 2;
                    }
                    if (int.parse(english1) >= 40 &&
                        int.parse(english1) <= 49) {
                      eng1G = 'C';
                      eng1M = 2;
                    }
                    if (int.parse(math) >= 40 && int.parse(math) <= 49) {
                      mathG = 'C';
                      mathM = 2;
                    }
                    if (int.parse(social_science) >= 40 &&
                        int.parse(social_science) <= 49) {
                      socialG = 'C';
                      socialM = 2;
                    }
                    if (int.parse(bangla2) >= 40 && int.parse(bangla2) <= 49) {
                      bang2G = 'C';
                      bang2M = 2;
                    }
                    if (int.parse(english2) >= 40 &&
                        int.parse(english2) <= 49) {
                      eng2G = 'C';
                      eng2M = 2;
                    }
                    if (int.parse(ict) >= 20 && int.parse(ict) <= 24) {
                      ictG = 'C';
                      ictM = 2;
                    }
                    if (int.parse(optional) >= 40 &&
                        int.parse(optional) <= 49) {
                      optG = 'C';
                      optM = 2;
                    }
                    if (int.parse(general_science) >= 40 &&
                        int.parse(general_science) <= 49) {
                      scienceG = 'C';
                      scienceM = 2;
                    }
                    if (int.parse(religious) >= 40 &&
                        int.parse(religious) <= 49) {
                      reliG = 'C';
                      reliM = 2;
                    }
                    if (int.parse(bangla1) >= 50 && int.parse(bangla1) <= 59) {
                      bang1G = 'B';
                      bang1M = 3;
                    }
                    if (int.parse(english1) >= 50 &&
                        int.parse(english1) <= 59) {
                      eng1G = 'B';
                      eng1M = 3;
                    }
                    if (int.parse(social_science) >= 50 &&
                        int.parse(social_science) <= 59) {
                      socialG = 'B';
                      socialM = 3;
                    }
                    if (int.parse(bangla2) >= 50 && int.parse(bangla2) <= 59) {
                      bang2G = 'B';
                      bang2M = 3;
                    }
                    if (int.parse(english2) >= 50 &&
                        int.parse(english2) <= 59) {
                      eng2G = 'B';
                      eng2M = 3;
                    }
                    if (int.parse(ict) >= 25 && int.parse(ict) <= 29) {
                      ictG = 'B';
                      ictM = 3;
                    }
                    if (int.parse(optional) >= 50 &&
                        int.parse(optional) <= 59) {
                      optG = 'B';
                      optM = 3;
                    }
                    if (int.parse(general_science) >= 50 &&
                        int.parse(general_science) <= 59) {
                      scienceG = 'B';
                      scienceM = 3;
                    }
                    if (int.parse(religious) >= 50 &&
                        int.parse(religious) <= 59) {
                      reliG = 'B';
                      reliM = 3;
                    }
                    if (int.parse(math) >= 50 && int.parse(math) <= 59) {
                      mathG = 'B';
                      mathM = 3;
                    }
                    if (int.parse(bangla1) >= 60 && int.parse(bangla1) <= 69) {
                      bang1G = 'A-';
                      bang1M = 3.5;
                    }
                    if (int.parse(english1) >= 60 &&
                        int.parse(english1) <= 69) {
                      eng1G = 'A-';
                      eng1M = 3.5;
                    }
                    if (int.parse(social_science) >= 60 &&
                        int.parse(social_science) <= 69) {
                      socialG = 'A-';
                      socialM = 3.5;
                    }
                    if (int.parse(bangla2) >= 60 && int.parse(bangla2) <= 69) {
                      bang2G = 'A-';
                      bang2M = 3.5;
                    }
                    if (int.parse(english2) >= 60 &&
                        int.parse(english2) <= 69) {
                      eng2G = 'A-';
                      eng2M = 3.5;
                    }
                    if (int.parse(ict) >= 30 && int.parse(ict) <= 34) {
                      ictG = 'A-';
                      ictM = 3.5;
                    }
                    if (int.parse(optional) >= 60 &&
                        int.parse(optional) <= 69) {
                      optG = 'A-';
                      optM = 3.5;
                    }
                    if (int.parse(general_science) >= 60 &&
                        int.parse(general_science) <= 69) {
                      scienceG = 'A-';
                      scienceM = 3.5;
                    }
                    if (int.parse(religious) >= 60 &&
                        int.parse(religious) <= 69) {
                      reliG = 'A-';
                      reliM = 3.5;
                    }
                    if (int.parse(math) >= 60 && int.parse(math) <= 69) {
                      mathG = 'A-';
                      mathM = 3.5;
                    }
                    if (int.parse(bangla1) >= 70 && int.parse(bangla1) <= 79) {
                      bang1G = 'A';
                      bang1M = 4;
                    }
                    if (int.parse(english1) >= 70 &&
                        int.parse(english1) <= 79) {
                      eng1G = 'A';
                      eng1M = 4;
                    }
                    if (int.parse(social_science) >= 70 &&
                        int.parse(social_science) <= 79) {
                      socialG = 'A';
                      socialM = 4;
                    }
                    if (int.parse(bangla2) >= 70 && int.parse(bangla2) <= 79) {
                      bang2G = 'A';
                      bang2M = 4;
                    }
                    if (int.parse(english2) >= 70 &&
                        int.parse(english2) <= 79) {
                      eng2G = 'A';
                      eng2M = 4;
                    }
                    if (int.parse(ict) >= 35 && int.parse(ict) <= 39) {
                      ictG = 'A';
                      ictM = 4;
                    }
                    if (int.parse(optional) >= 70 &&
                        int.parse(optional) <= 79) {
                      optG = 'A';
                      optM = 4;
                    }
                    if (int.parse(general_science) >= 70 &&
                        int.parse(general_science) <= 79) {
                      scienceG = 'A';
                      scienceM = 4;
                    }
                    if (int.parse(religious) >= 70 &&
                        int.parse(religious) <= 79) {
                      reliG = 'A';
                      reliM = 4;
                    }
                    if (int.parse(math) >= 70 && int.parse(math) <= 79) {
                      mathG = 'A';
                      mathM = 4;
                    }
                    if (int.parse(bangla1) >= 80 && int.parse(bangla1) <= 100) {
                      bang1G = 'A+';
                      bang1M = 5;
                    }
                    if (int.parse(english1) >= 80 &&
                        int.parse(english1) <= 100) {
                      eng1G = 'A+';
                      eng1M = 5;
                    }
                    if (int.parse(social_science) >= 80 &&
                        int.parse(social_science) <= 100) {
                      socialG = 'A+';
                      socialM = 5;
                    }
                    if (int.parse(bangla2) >= 80 && int.parse(bangla2) <= 100) {
                      bang2G = 'A+';
                      bang2M = 5;
                    }
                    if (int.parse(english2) >= 80 &&
                        int.parse(english2) <= 100) {
                      eng2G = 'A+';
                      eng2M = 5;
                    }
                    if (int.parse(ict) >= 40 && int.parse(ict) <= 50) {
                      ictG = 'A+';
                      ictM = 5;
                    }
                    if (int.parse(optional) >= 80 &&
                        int.parse(optional) <= 100) {
                      optG = 'A+';
                      optM = 5;
                    }
                    if (int.parse(general_science) >= 80 &&
                        int.parse(general_science) <= 100) {
                      scienceG = 'A+';
                      scienceM = 5;
                    }
                    if (int.parse(religious) >= 80 &&
                        int.parse(religious) <= 100) {
                      reliG = 'A+';
                      reliM = 5;
                    }
                    if (int.parse(math) >= 80 && int.parse(math) <= 100) {
                      mathG = 'A+';
                      mathM = 5;
                    }


                    totalGrade = 4;
                    totalGrade =
                        (bang1M + eng1M + mathM + socialM + scienceM + reliM +
                            bang2M + eng2M + optM + ictM) / 10;
                    if (totalGrade <= 0) {
                      totalGPA = 'F';
                      totalGrade = 0;
                    }
                    if (totalGrade >= 1 && totalGrade <= 1.99) {
                      totalGPA = 'D';
                    }
                    if (totalGrade >= 2 && totalGrade <= 2.99) {
                      totalGPA = 'C';
                    }
                    if (totalGrade >= 3 && totalGrade <= 3.49) {
                      totalGPA = 'B';
                    }
                    if (totalGrade >= 3.50 && totalGrade <= 3.99) {
                      totalGPA = 'A-';
                    }
                    if (totalGrade >= 4 && totalGrade <= 4.99) {
                      totalGPA = 'A';
                    }
                    if (totalGrade >= 5) {
                      totalGPA = 'A+';
                    }
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        DataTable(columns: [
                          DataColumn(label: Text("Subject Name")),
                          DataColumn(label: Text("Out of")),
                          DataColumn(label: Text("Mark")),
                          DataColumn(label: Text("Grade Point")),
                        ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text("Bangla First paper")),
                                DataCell(Text("100")),
                                //DataCell(bangla1 != null ? Text("$bangla1") : ''),
                                DataCell(Text("$bangla1")),
                                DataCell(Text("$bang1G"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Bangla Second paper")),
                                DataCell(Text("100")),
                                //DataCell(bangla2 != null ? Text("$bangla2") : ''),
                                DataCell(Text("$bangla2")),
                                DataCell(Text("$bang2G"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("English First paper")),
                                DataCell(Text("100")),
                                //DataCell(english1 != null ? Text("$english1") : ''),
                                DataCell(Text("$english1")),
                                DataCell(Text("$eng1G"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("English Second paper")),
                                DataCell(Text("100")),
                                // DataCell(
                                //     english2 != null ? Text("$english2") : ''),
                                DataCell(Text("$english2")),
                                DataCell(Text("$eng2G"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Mathematics")),
                                DataCell(Text("100")),
                                //DataCell(math != null ? Text("$math") : ''),
                                DataCell(Text("$math")),
                                DataCell(Text("$mathG"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("General Science")),
                                DataCell(Text("100")),
                                // DataCell(general_science != null ? Text(
                                //     "$general_science") : ''),
                                DataCell(Text("$general_science")),
                                DataCell(Text("$scienceG"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Social Science")),
                                DataCell(Text("100")),
                                // DataCell(social_science != null ? Text(
                                //     "$social_science") : ''),
                                DataCell(Text("$social_science")),
                                DataCell(Text("$socialG"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Religious")),
                                DataCell(Text("100")),
                                // DataCell(
                                //     religious != null ? Text("$religious") : ''),
                                DataCell(Text("$religious")),
                                DataCell(Text("$reliG"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("ICT")),
                                DataCell(Text("50")),
                                //DataCell(ict != null ? Text("$ict") : ''),
                                DataCell(Text("$ict")),
                                DataCell(Text("$ictG"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Agriculture / Home Science")),
                                DataCell(Text("100")),
                                // DataCell(
                                //     optional != null ? Text("$optional") : ''),
                                DataCell(Text("$optional")),
                                DataCell(Text("$optG"))
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Total")),
                                DataCell(Text("$sixToEightTotal")),
                                DataCell(Text('$totalMark')),
                                DataCell(Text(
                                    "GPA: $totalGPA (${totalGrade
                                        .toStringAsFixed(
                                        2)})"))
                              ])
                            ]
                        ),
                      ],
                    ),
                  );
                }
              }
          ),
        ),
      ],
    );
  }
}
