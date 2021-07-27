import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseserviceStudent {

  String uid;

  DatabaseserviceStudent({this.uid});

  final CollectionReference user = Firestore.instance.collection('student_information');

  Future updateuserdata(String _fname,String _lname,String _roll,String _add, String _g_name,String _g_num,String _g_email,String _class) async {
    return await user.document(uid).setData({
      'First_Name': _fname,
      'Last_Name': _lname,
      'Roll_No': _roll,
      'Address': _add,
      'Guardian': _g_name,
      'Guardian_Contact': _g_num,
      'Guardian_E-mail': _g_email,
      'Class': _class
    }
    );
  }
}