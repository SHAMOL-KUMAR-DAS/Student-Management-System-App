import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:school_management/Provider/image_get.dart';

class Teacher_Notice extends StatefulWidget {
  String type;
  Teacher_Notice(this.type);
  @override
  _Teacher_NoticeState createState() => _Teacher_NoticeState();
}

class _Teacher_NoticeState extends State<Teacher_Notice> {
  final _image = Get_Class().image;

  @override
  Widget build(BuildContext context) {

    final _get_class = Provider.of<Get_Class>(context, listen: true);

    return Scaffold(
      backgroundColor: Color(0xFF79f069),
      appBar: AppBar(
        backgroundColor: Color(0xFF79f069),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            WavyAnimatedTextKit(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 32
              ),
              text: ["Upcoming Events..."],
              isRepeatingAnimation: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                //width: MediaQuery.of(context).size.width * 0.3,
                child: _get_class.image == null ? Text("") : Image.file(_get_class.image),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _get_class.cameraImage();
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    //color: Color(0xFFe37c22),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _get_class.galleryImage();
                  },
                  child: Icon(Icons.photo_library_outlined,
                    //    color: Color(0xFFe37c22)
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                controller: _get_class.notice,
                maxLines: 10,
                minLines: 5,

                decoration: InputDecoration(
                    isDense: false,
                    fillColor: Colors.yellow,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    )

                ),
              ),
            ),
            FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10))
              ),
              onPressed: (){
                print(_get_class.notice.text);
                _get_class.sendData();
              },
              child: Text('Put Notice',style: TextStyle(
                  fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }
}
