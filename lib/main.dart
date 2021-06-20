import 'package:flutter/material.dart';
import 'package:question_answer_api_app/screens/homeScreen.dart';
import 'package:question_answer_api_app/screens/quizScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        QuizScreen.routeName: (ctx) => QuizScreen(),
      },
    );
  }
}
