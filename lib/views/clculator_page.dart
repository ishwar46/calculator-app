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
  Widget resultWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 150, 150, 150), width: 1),
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
      ],
    );
  }

  //button widget
  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: GridView.builder(
        clipBehavior: Clip.hardEdge,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: buttonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return buttons(buttonList[index]);
        },
      ),
    );
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
  Widget buttons(String text) {
    return Material(
      color: getBgColor(text),
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.5),
      child: InkWell(
        onTap: () {
          setState(() {
            whenButtonPressed(text);
          });
        },
        borderRadius: BorderRadius.circular(10),
        hoverColor: Colors.grey.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 224, 224, 224), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  whenButtonPressed(String text) {
    if (text == 'C') {
      userInput = '';
      result = '0';
    } else if (text == '=') {
      result = calculate();
      userInput = result.replaceAll('.0', '');
    } else if (text == '<-') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    } else {
      userInput += text;
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Input a valid mathematical expression.';
    }
  }
}
