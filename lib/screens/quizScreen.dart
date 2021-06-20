import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:question_answer_api_app/helpers/quizHelper.dart';
import 'package:question_answer_api_app/screens/resultScreen.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz-screen';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizHelper? quizHelper;

  int currentIndex = 0;

  int totalSeconds = 30;
  int elapsedSeconds = 0;

  int totalScore = 0;

  Timer? timer;

  List? answers;

  String apiUrl =
      'https://opentdb.com/api.php?amount=10&category=18&type=multiple';

  @override
  void initState() {
    super.initState();
    fetchAndSet();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  fetchAndSet() async {
    var response = await http.get(Uri.parse(apiUrl));
    var body = response.body;
    var json = jsonDecode(body);

    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper!.results[currentIndex].incorrectAnswers!
          .add(quizHelper!.results[currentIndex].correctAnswer!);

      quizHelper!.results[currentIndex].incorrectAnswers!.shuffle();

      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (t.tick == totalSeconds) {
          t.cancel();
          changeQuestion();
        } else {
          setState(() {
            elapsedSeconds = t.tick;
          });
        }
      },
    );
  }

  checkAnswer(answer) {
    String? correctAnswer = quizHelper!.results[currentIndex].correctAnswer;
    if (correctAnswer == answer) {
      setState(() {
        totalScore += 1;
      });
    } else {}
    changeQuestion();
  }

  changeQuestion() {
    timer!.cancel();
    if (currentIndex == quizHelper!.results.length - 1) {
      setState(() {
        currentIndex = 0;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => ResultScreen(totalScore),
          ),
        );
      });
    } else {
      setState(() {
        currentIndex++;
      });
    }

    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return quizHelper != null
        ? Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Timer row
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterLogo(
                            size: 60,
                          ),
                          Text(
                            '$elapsedSeconds s',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Question Section
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Q. ${quizHelper!.results[currentIndex].question}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    // Answer Section
                    SizedBox(
                      height: 50,
                    ),
                    ...quizHelper!.results[currentIndex].incorrectAnswers!
                        .map((option) {
                      return Container(
                        width: 260,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                          ),
                          onPressed: () {
                            checkAnswer(option);
                          },
                        ),
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
