import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}
class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Student Result")),
      ),
      body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: [
              DataColumn(label: Text("Student_Name")),
              DataColumn(label: Text("Mathematics")),
              DataColumn(label: Text("Physics")),
              DataColumn(label: Text("Chemistry")),
            ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Shamol")),
                  DataCell(Text("89")),
                  DataCell(Text("82")),
                  DataCell(Text("80"))
                ]),
                DataRow(cells: [
                  DataCell(Text("Sagor")),
                  DataCell(Text("90")),
                  DataCell(Text("84")),
                  DataCell(Text("82"))
                ]),
                DataRow(cells: [
                  DataCell(Text("Shahin")),
                  DataCell(Text("80")),
                  DataCell(Text("78")),
                  DataCell(Text("76"))
                ]),
                DataRow(cells: [
                  DataCell(Text("Soton")),
                  DataCell(Text("81")),
                  DataCell(Text("78")),
                  DataCell(Text("76"))
                ]),
              ],
            ),
          ),
        ),
    );
  }
}
