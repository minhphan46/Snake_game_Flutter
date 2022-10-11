import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color backroundColor = Color(0xff3EB2E5);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomeScreen(backroundColor),
    );
  }
}
