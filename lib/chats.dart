import 'dart:async';
import 'package:first_app/constants.dart';
import 'dart:ui';
import 'socket.dart';
import 'package:flutter/material.dart';
import 'privateChat.dart';

class ChatsMain extends StatefulWidget {
  const ChatsMain({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _chatsPageState();
  }
}

class _chatsPageState extends State<ChatsMain> {
  List<String> chatUsers = [];
  void getChatUsers() async {
    print("in getChat");
    channel.sink.add(xor_dec_enc("Get_Chats $globalUserName"));
  }

  @override
  void initState() {
    super.initState();
    print("in initState");
    getChatUsers();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        chatUsers = globalChatUsers;
      });
    });
  }

  void moveToPrivateChat(BuildContext context, String nameOfUser) {
    if (nameOfUser == "") return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return PrivateChatPage(nameOfClient: nameOfUser);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: chatUsers.map(
          (title) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 5, 129, 9),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.withOpacity(0.5), // Set the shadow color
                      spreadRadius: 2, // Set the spread radius
                      blurRadius: 4, // Set the blur radius
                      offset: Offset(0, 2), // Set the shadow offset
                    ),
                  ],
                ),
                child: InkWell(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, // Set the text color
                        fontSize: 16.0, // Set the font size

                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () => moveToPrivateChat(context, title),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
