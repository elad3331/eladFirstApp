import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:first_app/mainPage.dart';
import 'constants.dart';
import 'dart:ui';
import 'socket.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});
  void showValidationError(String message, BuildContext context) {
    // Display an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void register(String userName, String password, BuildContext context) async {
    print("Tries to Register");

    if (userName.isEmpty) {
      showValidationError("Username is required", context);
      return;
    } else if (userName.length < minUserNameLength) {
      showValidationError(
          "Username must be at least $minUserNameLength characters long",
          context);
      return;
    } else if (password.isEmpty) {
      showValidationError("Password is required", context);
      return;
    } else if (password.length < minPasswordLength) {
      showValidationError(
          "Password must be at least $minPasswordLength characters long",
          context);
      return;
    }
    channel.sink.add(xor_dec_enc("Registration $userName $password"));
    currentContext = context;
    MessageHandler messageHandler = MessageHandler();
    messageHandler.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Sign up',
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
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
                register(
                    usernameController.text, passwordController.text, context);
              },
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
