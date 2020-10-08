import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'calcButton.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  int result = 0;
  int buffer = 0;
  String operation = "=";
  String display = "";
  ScrollController scrollController = ScrollController();

  List<String> labels = [
    "7",
    "8",
    "9",
    "/",
    "4",
    "5",
    "6",
    "X",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    "=",
    "+",
  ];

  void onButtonPressed(String label) {
    Vibration.vibrate(
      duration: 30,
      amplitude: 5,
    );
    if (scrollController.position.pixels > 0) {
      scrollController.animateTo(
        0,
        duration: Duration(
          milliseconds: 200,
        ),
        curve: Curves.fastOutSlowIn,
      );
    }
    int number = int.tryParse(label);
    bool isNumber = number != null;
    if (isNumber) {
      buffer = buffer * 10 + number;
      setState(() {
        display = buffer.toString();
      });
    } else {
      if (label == "C") {
        resetCalc();
        setState(() {
          display = "";
        });
      } else {
        switch (operation) {
          case "+":
            result = result + buffer;
            break;
          case "-":
            result = result - buffer;
            break;
          case "/":
            if (buffer != 0) {
              result = result ~/ buffer;
            }
            break;
          case "X":
            result = result * buffer;
            break;
          default:
            result = buffer;
            break;
        }
        setState(() {
          buffer = 0;
          display = result.toString();
        });
        if (label == "=") {
          resetCalc();
        } else {
          operation = label;
        }
      }
    }
  }

  void resetCalc() {
    buffer = 0;
    result = 0;
    operation = "=";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                    ),
                    BoxShadow(
                      color: Colors.green[100],
                      spreadRadius: -3.0,
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(32),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                height: 200,
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  reverse: true,
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    display,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: "Calculator",
                      fontSize: 64,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                children: List<Widget>.from(
                  labels.map(
                    (String label) => CalcButton(
                      label: label,
                      onPressed: onButtonPressed,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                "Homemade calculator",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

