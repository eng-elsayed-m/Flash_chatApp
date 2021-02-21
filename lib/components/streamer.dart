// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../components/message_bubble.dart';

// FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class Streamer extends StatelessWidget {
//   final loggedInUser;

//   const Streamer({this.loggedInUser});

//   @override
//   Widget build(BuildContext context) {
//     return
// }

// // class ChatsStreamer extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //         stream: _firestore.collection("messages").orderBy('time').snapshots(),
// //         builder: (context, snapshot) {
// //           if (!snapshot.hasData) {
// //             print(snapshot.error);
// //             return Container(
// //               child: CircularProgressIndicator(),
// //             );
// //           }

// //           List<Widget> messageBubbles = [];
// //           final messages = snapshot.data.docs.reversed;
// //           for (var message in messages) {
// //             final messageTxt = message.data()['message'];
// //             final sender = message.data()['sender'];
// //             final time = message.data()['time'];
// //             bool localUser = sender == loggedInUser.email;
// //             final messageBubble = MessageBubble(
// //               sender: sender,
// //               messageTxt: messageTxt,
// //               localUser: localUser,
// //               time: time,
// //             );
// //             messageBubbles.add(messageBubble);
// //           }

// //           return Expanded(
// //             child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: ListView(
// //                   reverse: true,
// //                   children: messageBubbles,
// //                 )),
// //           );
// //         });
// //   }
// // }
