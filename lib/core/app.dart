import 'package:calculatorapp/views/clculator_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorApp(),
    );
  }
}

class MyRoutes {
  static const String calculator = '/calculator';
}
