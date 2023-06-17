import 'dart:collection';
import 'dart:ui';
import 'package:first_app/passwordPage.dart';
import 'package:first_app/privateChat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_socket_channel/io.dart';
import 'constants.dart';
import 'mainPage.dart';
import 'emailVerify.dart';
import 'pin.dart';

final channel = IOWebSocketChannel.connect('ws://$ip_given:12345');

class MessageHandler {
  final Map<String, Function> messageHandlers = {
    'Match': handleMatch,
    'Chat': handleChat,
    'GetChats': handleGetChat,
    'Login': handleLogin,
    'Registration': handleRegistration,
    'Cities': handleCities,
    'Email_Verification': handleEmailVerification,
    'Pin': handlePin,
    'Change_Password': handleChangePassword,
    'Password_Pin': handlePasswordPin
  };

  void startListening() {
    print("listeningggggggggg");
    channel.stream.listen((encedMessage) {
      print("need to be encr $encedMessage");
      var message = xor_dec_enc(encedMessage);
      print("message received here is $message");
      final messageType = getMessageType(message);
      print("messaftetype is $messageType");
      if (messageHandlers.containsKey(messageType)) {
        print("hereeeee");
        messageHandlers[messageType]!(message);
      }
    }, onDone: () {
      print('Stream closed');
    }, onError: (error) {
      print('Error: $error');
    });
  }

  String getMessageType(String message) {
    print("in message type");
    return message.split(',')[0];
  }

  static void handlePasswordPin(String message) {
    if (message.contains("Succeed")) {
      Navigator.pushReplacement(currentContext!,
          MaterialPageRoute(builder: (context) => PasswordPage()));
    } else {
      showValidationError("The pin is incorrect", currentContext!);
    }
  }

  static void handleChangePassword(String message) {
    globalCurrentPin = int.tryParse(message.split(",")[2].trim())!;
    Navigator.pushReplacement(currentContext!,
        MaterialPageRoute(builder: (context) => PinPage("Password")));
  }

  static void handleMatch(String message) {
    print("sending!!!");
    var username = "";
    if (message.contains("Succeed")) {
      print("succes");
      String msgToDisplay = "";
      if (message.contains("Lost")) {
        username = message.split(",")[2].split(" ")[1];
        print("current usernmae is $username");
        msgToDisplay =
            "$username lost product that matches the one you found. Chat with him!";
      } else {
        username = message.split(",")[2].split(" ")[1];
        msgToDisplay =
            "$username found product that matches the one you lost. Chat with him!";
      }
      Fluttertoast.showToast(
        msg: msgToDisplay,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Currently there is no product that matches yours",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  static void handleChat(String message) {
    print("the message in chats is $message");
    String msgFrom = message.split(",")[2].split(" ")[0];
    print("msgFrom $msgFrom");
    String msgContent = message.substring(msgFrom.length + 13);
    print("msgCont $msgContent");
    if (!chatQueues.containsKey(msgFrom)) {
      print("Contains");
      chatQueues[msgFrom] = Queue();
    }
    chatQueues[msgFrom]?.add(msgContent);
  }

  static void handleGetChat(String message) {
    if (message.contains("Succeed")) {
      var users = message.split(",")[2];
      globalChatUsers = users.split(" ");
    }
  }

  static void handleLogin(String message) {
    if (message.contains("Succeed")) {
      globalUserName = message.split(",")[2].split(" ")[0];
      globalEmail = message.split(",")[2].split(" ")[1];
      Navigator.pushReplacement(currentContext!,
          MaterialPageRoute(builder: (context) => const MainPage()));
    } else if (message.contains("user doesn't exist")) {
      showValidationError("Username or password is incorrect", currentContext!);
    } else {
      showValidationError(
          "This username is already logged in", currentContext!);
    }
  }

  static void handleEmailVerification(String message) {
    if (message.contains("Succeed")) {
      Navigator.push(currentContext!,
          MaterialPageRoute(builder: (context) => PinPage("Pin")));
    } else {
      showValidationError("Email is already in use", currentContext!);
    }
  }

  static void handleRegistration(String message) {
    if (message.contains("Succeed")) {
      globalUserName = message.split(",")[2];
      Navigator.push(currentContext!,
          MaterialPageRoute(builder: (context) => EmailPage()));
    } else if (message == "Registration,Failed,user already exists") {
      showValidationError(
          "A user with that username already exsits", currentContext!);
    }
  }

  static void handleCities(String message) {
    if (message.contains("Cities,Succeed,")) {
      var allCities = message.substring(15);
      print("cities is $allCities");
      var length = cities.length;
      print("my length $length");
      cities.addAll(allCities.split(","));
    }
  }

  static void handlePin(String message) {
    if (message.contains("Succeed")) {
      Navigator.pushReplacement(
          currentContext!, MaterialPageRoute(builder: (context) => MainPage()));
    } else if (message.contains("Failed")) {
      showValidationError("The pin is incorrect", currentContext!);
    }
  }

  static void showValidationError(String message, BuildContext context) {
    // Display an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
