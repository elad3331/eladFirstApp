import 'dart:async';
import 'dart:collection';
import 'package:first_app/socket.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:ui';
import 'chats.dart';
import 'chatBubble.dart';
import 'messageStore.dart';

class PrivateChatPage extends StatefulWidget {
  final String nameOfClient;

  const PrivateChatPage({Key? key, required this.nameOfClient})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _privateChatPageState();
  }
}

class _privateChatPageState extends State<PrivateChatPage> {
  final TextEditingController _userMsgController = TextEditingController();
  MessageStore _messageStore = MessageStore();
  var _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startTimer();
  }

  void dispose() {
    _timer?.cancel(); // Cancel the timer when the component is disposed
    _userMsgController.clear();
    super.dispose();
  }

  onWillPop() async {
    channel.sink.add(xor_dec_enc("Get_Chats $globalUserName"));
  }

  void _submitMsg(String text) {
    if (text == "") return;
    String message = "Chat $globalUserName ${widget.nameOfClient} $text";
    print("here is message $message");
    channel.sink
        .add(xor_dec_enc("Chat $globalUserName ${widget.nameOfClient} $text"));
    setState(() {
      _messageStore.clientMessages
          .putIfAbsent(widget.nameOfClient, () => [])
          .insert(0, text);
    });
    _userMsgController.clear();
  }

  void _startTimer() {
    print("start timer");
    // Create a repeating timer that executes the _submitPalMsg() function every 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _submitPalMsg();
    });
  }

  void _submitPalMsg() {
    Queue<String>? currentQueue;
    if (chatQueues.containsKey(widget.nameOfClient)) {
      // The specified client name exists as a key in the chatQueues map
      currentQueue = chatQueues[widget.nameOfClient];
      while (currentQueue!.isNotEmpty) {
        String msgText = currentQueue.removeFirst();
        setState(() {
          _messageStore.clientMessages
              .putIfAbsent(widget.nameOfClient, () => [])
              .insert(0, msgText + "sent_by_other_client");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _messages =
        _messageStore.clientMessages[widget.nameOfClient] ?? [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Chat with ${widget.nameOfClient}",
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final mainString = _messages[index];
                final subString = "sent_by_other_client";

                bool isMe = true;
                if (mainString.contains("sent_by_other_client")) {
                  isMe = false;
                } else {
                  isMe = true;
                }
                final String cutString = mainString.replaceAll(subString, '');
                return MessageBubble(cutString, isMe);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _userMsgController,
                      onSubmitted: _submitMsg,
                      decoration: const InputDecoration(
                        hintText: "Type your message here...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _submitMsg(_userMsgController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
