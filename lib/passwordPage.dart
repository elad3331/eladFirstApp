import 'dart:async';
import 'package:first_app/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'constants.dart';
import 'dart:ui';
import 'socket.dart';

class PasswordPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();

  PasswordPage({super.key});

  void send_password(String password, BuildContext context) async {
    channel.sink.add(xor_dec_enc("New_Password $password $globalUserName"));
    currentContext = context;
    Navigator.pushReplacement(currentContext!,
        MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: Text(
          'Change your password',
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
              ),
              onPressed: () {
                send_password(passwordController.text, context);
              },
              child: const Text('Change password'),
            ),
          ],
        ),
      ),
    );
  }
}
