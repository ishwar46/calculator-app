import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String userInput = '';
  String result = '0';

  List<String> buttonList = [
    'C',
    '*',
    '/',
    '<-',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: resultWidget(),
          ),
          Expanded(child: buttonWidget()),
        ],
      ),
    );
  }

//widget for result

  //widget for result
  Widget resultWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 150, 150, 150), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(userInput,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        SizedBox(height: 10),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //           color: Color.fromARGB(255, 150, 150, 150), width: 1),
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     padding: const EdgeInsets.all(10),
        //     alignment: Alignment.centerRight,
        //     child: Text(result,
        //         style: const TextStyle(
        //           fontSize: 50,
        //           fontWeight: FontWeight.bold,
        //         )),
        //   ),
        // )
      ],
    );
  }

  //button widget
  Widget buttonWidget() {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: GridView.builder(
            itemCount: buttonList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return button(buttonList[index]);
            }));
  }

  getColor(String text) {
    if (text == "C" ||
        text == "/" ||
        text == "*" ||
        text == "-" ||
        text == "<-" ||
        text == "+" ||
        text == "%" ||
        text == "=") {
      return Colors.amber;
    } else if (text == "0" ||
        text == "1" ||
        text == "2" ||
        text == "3" ||
        text == "4" ||
        text == "5" ||
        text == "6" ||
        text == "7" ||
        text == "8" ||
        text == "9" ||
        text == ".") {
      return Colors.green;
    } else {
      return Colors.indigo;
    }
  }

  getBgColor(String text) {
    if (text == 'AC') {
      return Colors.green;
    }
    if (text == '=') {
      return Color.fromARGB(255, 244, 57, 54);
    }
    return Colors.white;
  }

  //button widget
  Widget button(String text) {
    return InkWell(
        onTap: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  handleButtonPress(String text) {
    if (text == 'C') {
      userInput = '';
      result = '0';
      return;
    }

    if (text == '=') {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll('.0', '');
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll('.0', '');
      }

      return;
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
