import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool myMessage;
  MessageBubble(this.message, this.myMessage);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: myMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: myMessage
              ? Color.fromARGB(255, 243, 111, 243)
              : Color.fromARGB(255, 233, 218, 218),
          borderRadius: BorderRadius.circular(12),
        ),
        width: 140,
        constraints: BoxConstraints(maxWidth: 200),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontFamily: 'FjallaOne'),
        ),
      ),
    );
  }
}
