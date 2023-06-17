import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'constants.dart';
import 'dart:ui';
import 'socket.dart';

class EmailPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  EmailPage({super.key});
  void showValidationError(String message, BuildContext context) {
    // Display an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void send_email(String email, BuildContext context) async {
    print("Tries to Register");
    if (email.isEmpty) {
      showValidationError("Email is required", context);
      return;
    } else if (!email.contains("@")) {
      showValidationError("Please enter valid email", context);
      return;
    }
    globalEmail = email;
    channel.sink.add(xor_dec_enc("Email_Verification $email"));
    currentContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: Text(
          'Email Verification',
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
              ),
              onPressed: () {
                send_email(_emailController.text, context);
              },
              child: const Text('Send pin code to your email'),
            ),
          ],
        ),
      ),
    );
  }
}
