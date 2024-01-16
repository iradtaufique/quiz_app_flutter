// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/quiz_brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // list that keep track of user scores in terms of icons
  List<Icon> scoreKeeper = [];

  // create an abject that contain questions and answers
  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                //quizBrain.questionBank[questionNumber].questionText,
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        // True Button starts here
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                bool correctAnswer =
                    //quizBrain.questionBank[questionNumber].questionAnswer;
                    quizBrain.getQuestionAnswer();
                if (correctAnswer == true) {
                  print('user got it right');
                } else {
                  print('user got it wrong');
                }
                setState(() {
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        // False Button start here
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red[400]),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                bool correctAnswer =
                    //quizBrain.questionBank[questionNumber].questionAnswer;
                    quizBrain.getQuestionAnswer();
                if (correctAnswer == false) {
                  print('user got it right');
                } else {
                  print('user got it wrong');
                }
                setState(() {
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          // ScoreKeeper is a list that store the scores
          children: scoreKeeper,
        )
      ],
    );
  }
}
