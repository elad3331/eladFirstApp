import 'dart:collection';

import 'package:flutter/material.dart';

const int minUserNameLength = 6;
const int minPasswordLength = 8;
var globalUserName = "";
List<String> globalChatUsers = [];
Map<String, Queue<String>> chatQueues = {};
BuildContext? currentContext = null;
const String key = "123";
var cities = ["A'SAM"];
String ip_given = "";
String globalEmail = "";
int globalPassword = 0;
int globalCurrentPin = 0;

String xor_dec_enc(String text) {
  List<int> encrypted = [];
  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i) ^ key.codeUnitAt(i % key.length);
    encrypted.add(charCode);
  }
  return String.fromCharCodes(encrypted);
}
