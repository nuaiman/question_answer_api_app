import 'package:flutter/material.dart';
import 'package:question_answer_api_app/screens/quizScreen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  ResultScreen(this.score);

  static const routeName = '/result-screen';

  @override
  Widget build(BuildContext context) {
    final _deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: _deviceheight * 0.125,
                ),
                FlutterLogo(
                  size: 150,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'R E S U L T ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  '$score / 10',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 260,
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    child: Text(
                      'R E S T A R T ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(QuizScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
