import 'dart:ui';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {@required this.sender,
      @required this.messageTxt,
      @required this.localUser,
      @required this.time,
      @required this.image });

  final sender;
  final messageTxt;
  final localUser;
  final time;
  final image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          localUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        localUser
            ? SizedBox()
            : Column(
                children: [
                  CircleAvatar(
                    backgroundImage: image == '' ? Icon(
                      Icons.person_sharp,
                      size: 30,
                      color: Color(0xFF393e46),
                    ): NetworkImage(image),
                    radius: 20,
                    
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    sender.toString().toUpperCase().split("@").first,
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF393e46),
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
        Flexible(
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Material(
              borderRadius: BorderRadius.only(
                  topRight: localUser ? Radius.zero : Radius.circular(35),
                  topLeft: localUser ? Radius.circular(35) : Radius.zero,
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35)),
              animationDuration: Duration(seconds: 2),
              elevation: 3.0,
              shadowColor: Color(0xFF393e46),
              color: localUser ? Color(0xFF393e46) : Color(0xFFE6DD8E),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                child: Text(
                  messageTxt,
                  textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                      color: localUser ? Color(0xFFeeeeee) : Color(0xFF393e46),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
