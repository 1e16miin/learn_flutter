import 'package:flutter/material.dart';
import 'package:learn_flutter/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Momentum App',
      home: HomeScreen(),
    );
  }
}
