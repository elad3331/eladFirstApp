import 'package:first_app/registerPage.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'socket.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(String userName, String password, BuildContext context) async {
    print("Tries to Login");
    print("here");
    channel.sink.add(xor_dec_enc("Login $userName $password"));
    currentContext = context;
    MessageHandler messageHandler = MessageHandler();
    messageHandler.startListening();
  }

  void moveToRegistration(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return RegisterPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Login Page',
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
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
                login(_usernameController.text, _passwordController.text,
                    context);
              },
              child: const Text('Login'),
            ),
            InkWell(
              onTap: () => moveToRegistration(context),
              child: const Text("Don't have an account yet? Sign up for free."),
            )
          ],
        ),
      ),
    );
  }
}
