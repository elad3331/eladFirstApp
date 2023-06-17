import 'package:first_app/chats.dart';
import 'package:first_app/home.dart';
import 'package:flutter/material.dart';
import 'package:first_app/description.dart';
import 'dart:ui';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _mainPageState();
  }
}

class _mainPageState extends State<MainPage> {
  int selectedIndex = 0;

  static const List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    const ProductInfo(titleText: "Describe the loss"),
    const ProductInfo(titleText: "Describe the finding"),
    const ChatsMain()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'ReturnIt - Home Page';
      case 1:
        return 'ReturnIt - Lost Items';
      case 2:
        return 'ReturnIt - Found Items';
      case 3:
        return 'ReturnIt - Chats';
      default:
        return '';
    }
  }

  Color getAppBarColor(int index) {
    switch (index) {
      case 0:
        return Color.fromARGB(57, 51, 16, 177);
      case 1:
        return Colors.pinkAccent;
      case 2:
        return Color.fromARGB(255, 55, 161, 121);
      case 3:
        return Colors.lightGreen;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = getAppBarTitle(selectedIndex);
    final appBarColor = getAppBarColor(selectedIndex);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        title: Text(
          appBarTitle,
          style: TextStyle(fontFamily: 'Anton'),
        ),
      ),
      body: widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            label: 'Lost',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.find_in_page,
              color: Colors.blue,
            ),
            label: 'Found',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.blue,
            ),
            label: 'Chats',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: onItemTapped,
      ),
    );
  }
}
