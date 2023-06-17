import 'dart:async';
import 'package:first_app/constants.dart';
import 'package:first_app/pin.dart';
import 'dart:ui';
import 'socket.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  void changePassword(BuildContext context) async {
    channel.sink.add(xor_dec_enc("Change_Password $globalEmail"));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return PinPage("Password");
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16.0),
          Text(
            "Username: $globalUserName",
            style: const TextStyle(
                color: Colors.black, // Set the text color
                fontSize: 16.0, // Set the font size

                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            "Email: $globalEmail",
            style: const TextStyle(
                color: Colors.black, // Set the text color
                fontSize: 16.0, // Set the font size

                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Password: *********",
                style: const TextStyle(
                    color: Colors.black, // Set the text color
                    fontSize: 16.0, // Set the font size

                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen, // Background color
                ),
                onPressed: () {
                  changePassword(context);
                },
                child: const Text('Change value'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
