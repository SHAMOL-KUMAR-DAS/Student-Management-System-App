import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseserviceStudent {

  String uid;

  DatabaseserviceStudent({this.uid});

  final CollectionReference user = Firestore.instance.collection('student_information');

  Future updateuserdata(
      String _fname,String _lname,String _roll,String _add, String _g_name,String _g_num,String _g_email,String _class,
      String _math, String _phy,String _chem,
      String _sub1,String _teacher1,String _sub2, String _teacher2,String _sub3,String _teacher3,
      String _event,String _event_date,
      String _exam_date1,_exam_date2,_exam_date3,String _exam_time,String _exam_venue
      ) async {
    return await user.document(uid).setData({
      'First_Name': _fname,
      'Last_Name': _lname,
      'Roll_No': _roll,
      'Address': _add,
      'Guardian': _g_name,
      'Guardian_Contact': _g_num,
      'Guardian_E-mail': _g_email,
      'Class': _class,
      'Math': "- -",
      'Physics': "- -",
      'Chemistry': "- -",
      'Subject_1': "Mathematics",
      'Teacher_1': "Monyeem sir",
      'Subject_2': "Physics",
      'Teacher_2': "Sakkhar sir",
      'Subject_3': "Chemistry",
      'Teacher_3': "Hasibur Sir",
      'Event': "No Event Available Right Now",
      'Event_Date': "Not Exist\nDD/MM/YYYY",
      'Exam_Date1': "Not Exist\nDD/MM/YYYY",
      'Exam_Date2': "Not Exist\nDD/MM/YYYY",
      'Exam_Date3': "Not Exist\nDD/MM/YYYY",
      'Exam_Time': "Not Exist\nHH:MM",
      'Exam_Venue': "Not Exist"
    }
    );
  }
}