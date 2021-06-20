import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:question_answer_api_app/screens/quizScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _deviceheight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Q U I Z',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _deviceheight * 0.04,
              ),
              Container(
                width: 260,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 25,
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
    );
  }
}
