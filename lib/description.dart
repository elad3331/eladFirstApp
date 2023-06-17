import 'dart:async';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'socket.dart';
import 'dart:ui';

class ProductInfo extends StatefulWidget {
  final String titleText;

  const ProductInfo({Key? key, required this.titleText}) : super(key: key);

  @override
  ProductInfoState createState() => ProductInfoState();
}

class ProductInfoState extends State<ProductInfo> {
  // Initial Selected Value
  String dropdownvalue = 'cellphone';
  String dropdownvalue1 = 'black';
  String dropdownvalue2 = 'brand-new';
  String dropdownvalue3 = "A'SAM";

  // List of items in dropdown menu
  var items = [
    'cellphone',
    'watch',
    'wallet',
  ];
  var colors = [
    'black',
    'dark-blue',
    'red',
    'orange',
    'yellow',
    'light-blue',
    'green',
    'grey',
    'brown',
  ];
  var condition = [
    'brand-new',
    'good',
    'bad',
  ];

  @override
  void initState() {
    super.initState();
    print("in initState");
    getCities();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        cities;
      });
    });
  }

  void getCities() async {
    print("in getCities");
    channel.sink.add(xor_dec_enc("Get_Cities $globalUserName"));
  }

  void sendDescription() async {
    String msgType = "";
    if (widget.titleText.contains("loss")) {
      msgType = "Lost";
    } else {
      msgType = "Found";
    }
    channel.sink.add(xor_dec_enc(
        "$msgType $globalUserName $dropdownvalue $dropdownvalue1 $dropdownvalue2 $dropdownvalue3"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
            DropdownButton(
              // Initial Value
              value: dropdownvalue1,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: colors.map((String colors) {
                return DropdownMenuItem(
                  value: colors,
                  child: Text(colors),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue1 = newValue!;
                });
              },
            ),
            DropdownButton(
              // Initial Value
              value: dropdownvalue2,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: condition.map((String condition) {
                return DropdownMenuItem(
                  value: condition,
                  child: Text(condition),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue2 = newValue!;
                });
              },
            ),
            DropdownButton(
              // Initial Value
              value: dropdownvalue3,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: cities.map((String cities) {
                return DropdownMenuItem(
                  value: cities,
                  child: Text(cities),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue3 = newValue!;
                });
              },
            ),
            ElevatedButton(
                onPressed: sendDescription,
                child: const Text("submit your description"))
          ],
        ),
      ),
    );
  }
}
