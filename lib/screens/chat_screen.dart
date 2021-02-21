import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
import '../components/authentication_firestore.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const navName = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String sentMessage;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticateUser>(
      builder: (context, _userData, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFE6DD8E),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _userData.loading
                              ? CircularProgressIndicator()
                              : Stack(
                                  children: [
                                    CircleAvatar(
                                     
                                      backgroundImage: _userData.userImage == ''
                                          ? NetworkImage('https://gravatar.com/avatar/39b4d1b41aa81031bf27f6af70e4034d?s=400&d=mp&r=x',)
                                          : NetworkImage(_userData.userImage),


                                      // : Icon(Icons.person,
                                      //     size: 50, color: Color(0xFF393e46)),
                                      backgroundColor: Color(0xAF555753),
                                      radius: 35,
                                    ),
                                    Positioned(
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        iconSize: 18,
                                        onPressed: () async {
                                          await ImagePicker()
                                              .getImage(
                                                  source: ImageSource.gallery)
                                              .then((image) {
                                            _userData.uploadFile(image.path);
                                            
                                          });
                                        },
                                      ),
                                      top: 33,
                                      left: 28,
                                    )
                                  ],
                                ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                              _userData.auth.currentUser.email
                                  .split('@')
                                  .first
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Color(0xFF393e46),
                                  shadows: [
                                    Shadow(
                                        blurRadius: 3,
                                        color: Color(0xFF393e46),
                                        offset: Offset(0, 1))
                                  ])),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.exit_to_app_rounded,
                            color: Color(0xFF393e46),
                          ),
                          onPressed: () {
                            _userData.auth.signOut();
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        color: Color(0xFFeeeeee),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF000000),
                              blurRadius: 5,
                              offset: Offset(0, 4),
                              spreadRadius: 3)
                        ]),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _userData.messagesStreamer(),
                          Container(
                            decoration: kMessageContainerDecoration,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _textEditingController,
                                    onChanged: (value) {
                                      sentMessage = value;
                                    },
                                    decoration: kMessageTextFieldDecoration,
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    _userData.sentMessage(sentMessage);
                                    setState(() {
                                      _textEditingController.clear();
                                    });
                                  },
                                  child: Text(
                                    'Send',
                                    style: kSendButtonTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
