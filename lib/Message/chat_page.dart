import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Chatting extends StatefulWidget {
  String myuid, fname, lname, receiverUid, myEmail, receiverEmail;
  Chatting(this.myuid, this.fname, this.lname, this.receiverUid, this.myEmail, this.receiverEmail);
  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  String chatRoomId, messageId = '';
  TextEditingController _message = TextEditingController();

  getMyInfo() async {
    chatRoomId = getChatRoomId(widget.receiverUid, widget.myuid);
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getAndSetMessages() async {}
  doThisLaunch() async {
    await getMyInfo();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisLaunch();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFFc25d15),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.015,
            ),
            Text(widget.fname),
          ],
        ),
      ),
      body: Container(
          child: Column(children: [
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('chatRooms')
                        .document(chatRoomId)
                        .collection('Messages')
                        .orderBy('messageTime', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      } else
                        return ListView(
                            reverse: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: snapshot.data.documents.map((document) {
                              return Column(
                                  crossAxisAlignment:
                                  widget.myEmail != document['senderEmail']
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    // CircleAvatar(
                                    //   radius: 20,
                                    //   backgroundImage: NetworkImage(document['receiverImage']??''),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: widget.myEmail !=
                                                    document['senderEmail']
                                                    ? Colors.blue.shade500
                                                    : Color(0xFF3d403d)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    document['Message'] ?? '',
                                                    style:
                                                    TextStyle(color: Colors.white,fontSize: 15),

                                                  ),
                                                  //Text(DateFormat.yMMMd().add_jm().format(document['messageTime'].toDate()),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(DateFormat.yMd().add_jm().format(document['messageTime'].toDate()),)
                                        ],
                                      ),
                                    ),
                                  ]);
                            }).toList());
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5),
              child: Container(
                //height: MediaQuery.of(context).size.height * 0.06,
                //width: 1500,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _message,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: "Type your message",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                            BorderSide(color: Colors.black, width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                        ),
                        // onChanged: (input) {
                        //   setState(() {
                        //     _message = input;
                        //   });
                        // },
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();
                        Firestore.instance
                            .collection('chatRooms')
                            .document(chatRoomId)
                            .collection('Messages')
                            .document()
                            .setData({
                          'Message': _message.text,
                          //'receiverImage': widget.receiverImage,
                          //'senderImage': widget.userImage,
                          'senderEmail': widget.myEmail,
                          'receiverEmail': widget.receiverEmail,
                          'messageTime': DateTime.now(),
                        }).then((value) => _message.text = '');
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}