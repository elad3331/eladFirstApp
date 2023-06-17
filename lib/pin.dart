import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'constants.dart';
import 'dart:ui';
import 'socket.dart';
import 'emailVerify.dart';

class PinPage extends StatelessWidget {
  final TextEditingController pinController = TextEditingController();
  String command = "";

  PinPage(command) {
    this.command = command;
  }

  void send_pin(String pin, BuildContext context) async {
    if (command == "Pin") {
      channel.sink.add(xor_dec_enc("Pin $pin $globalEmail $globalUserName"));
    } else {
      channel.sink.add(xor_dec_enc("Password_Pin $pin $globalCurrentPin"));
    }
    currentContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Pin Verification',
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: pinController,
              decoration: const InputDecoration(
                labelText: '6 digits pin',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
              ),
              onPressed: () {
                send_pin(pinController.text, context);
              },
              child: const Text("Enter the pin you've recieved in your email"),
            ),
          ],
        ),
      ),
    );
  }
}
