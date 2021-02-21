import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../components/message_bubble.dart';

class AuthenticateUser extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String _errorMessage = '';
  String _userImage = '';
  bool _loading = false;
  FirebaseFirestore get firestore {
    return _firestore;
  }

  String get userImage {
    return _userImage;
  }

  FirebaseAuth get auth {
    return _auth;
  }

  FirebaseStorage get storage {
    return _storage;
  }

  String get errorMessage {
    return _errorMessage;
  }

  bool get loading {
    return _loading;
  }

  // Methods

  //Sign in
  void creatUser(String _email, _password, Function navigator) async {
    _loading = true;
    notifyListeners();

    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) {
        _errorMessage = '';
      });
      _loading = false;
      notifyListeners();
      navigator();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'The account already exists for that email.';
      } else {
        _errorMessage = 'Enter valid email !';
      }
      _loading = false;
      notifyListeners();
    }
    getUserImage();
  }

  // logIn
  void logUser(String _email, _password, Function navigator) async {
    _loading = true;
    notifyListeners();
    try {
      await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((_) {
        _errorMessage = '';
      });
      _loading = false;
      
      notifyListeners();
      navigator();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Wrong password provided for that user.';
      } else {
        _errorMessage = 'Enter valid email !';
      }
      _loading = false;
      notifyListeners();
    }
    getUserImage();
    notifyListeners();
  }

  // sent message
  void sentMessage(
    String sentMessage,
  ) {
    _firestore.collection('messages').doc().set({
      'message': sentMessage,
      'sender': _auth.currentUser.email,
      'time': DateTime.now(),
      'image': _userImage,
    });
  }

  // reset data
  void reset() {
    _errorMessage = '';
    _userImage = '';
    notifyListeners();
  }

  // Messages
  Widget messagesStreamer() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // print(snapshot.error);
            return Container(
              child: CircularProgressIndicator(),
            );
          }

          List<Widget> messageBubbles = [];
          final messages = snapshot.data.docs.reversed;
          for (var message in messages) {
            final messageTxt = message.data()['message'];
            final sender = message.data()['sender'];
            final time = message.data()['time'];
            final image = message.data()['image'];
            bool localUser = sender == _auth.currentUser.email;
            final messageBubble = MessageBubble(
              sender: sender,
              messageTxt: messageTxt,
              localUser: localUser,
              time: time,
              image: image,
            );
            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView(
                  reverse: true,
                  children: messageBubbles,
                )),
          );
        });
  }

  // set Profile Image
  Future <void> uploadFile(String filePath) async {
    _loading = true;
    notifyListeners();
    File file = File(filePath);
    try {
      _storage
          .ref('usersImages/' + _auth.currentUser.uid + '.jpg')
          .putFile(file)
          .then((file) {
        getUserImage();
      });
      _loading = false;
    notifyListeners();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e);
      _loading = false;
    notifyListeners();
    }
    
  }

  void getUserImage() async {
    await _storage
        .ref('usersImages/' + _auth.currentUser.uid + '.jpg')
        .getDownloadURL()
        .then((url) {
      _userImage = url;
      notifyListeners();
    });
  }
}

// Widget usersStreamer(String searchedEmail, Function navigator) {
//   return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection("users").snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           print(snapshot.error);
//           return Container(
//             child: Center(
//               child: Text('No users Found'),
//             ),
//           );
//         }

//         List<Widget> foundAccounts = [];
//         final users = snapshot.data.docs;
//         for (var user in users) {
//           if (user.data()['email'] == searchedEmail) {
//             var account = ListTile(
//               onTap: () {
//                 notifyListeners();
//                 navigator();
//               },
//               title: Text(user.data()['name'].toString()),
//               subtitle: Text(user.data()['email'].toString()),
//             );
//             foundAccounts.add(account);
//           }
//         }

//         return Expanded(
//           child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView(
//                 children: foundAccounts,
//               )),
//         );
//       });
// }

// Widget chatsStreamer(Function navigator) {
//   return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser.uid)
//           .collection('chats')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           print(snapshot.error);
//           return Container(
//             child: Center(
//               child: Text('No chats Found'),
//             ),
//           );
//         }

//         List<Widget> conversations = [];
//         final chats = snapshot.data.docs;
//         for (var chat in chats) {
//           print(FirebaseAuth.instance.currentUser.uid);
//           print(chat.data());
//           var chatItem = ListTile(
//             onTap: () {
//               notifyListeners();
//               navigator();
//               print(chat.id);
//             },
//             title: Text("seko"),
//           );
//           conversations.add(chatItem);
//         }

//         return Expanded(
//           child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView(
//                 children: conversations,
//               )),
//         );
//       });
// }
