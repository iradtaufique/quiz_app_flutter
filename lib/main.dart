// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// create an abject quizBrain that contain questions and answers
QuizBrain quizBrain = QuizBrain();
int corAnswer = 0;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Quiz App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white70,
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

  // create a method that will check users answers
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    int scoreLength = scoreKeeper.length + 1;
    setState(() {
      //todo the method isFinished check if all question is done or not, and if its done it shows the alert message
      if (quizBrain.isFinished() == true) {
        //todo this is the alert that displays when all question is done
        Alert(
          context: context,
          title: 'Finished!',
          type: AlertType.success,
          desc: 'Your Score is: $corAnswer/$scoreLength',
        ).show();
        //todo, this method reset() is used to rest the questions number to 0, restart the questions,
        quizBrain.reset();
        //todo, empty all icons that stored in scoreKeeper list
        scoreKeeper = [];
      } else {
        //todo, check if user choose a correct answeer and add icon check icon in scoreKeeper list
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check_circle,
            color: Colors.green[900],
          ));
          corAnswer++;
        }
        //todo, else add close icon in scoreKeeper List
        else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red[900],
          ));
        }
        //todo, nextQuestion method check if it is safe to go to the next question by checking the index of Question list
        quizBrain.nextQuestion();
      }
    });
  }

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
                //todo, quizBrain is the object
                //todo, getQuestionText method is the method used to get every question
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
        //todo, True Button starts here
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green[900]),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //todo, The user picked true as an answer.
                checkAnswer(true);
              },
            ),
          ),
        ),
        // False Button start here
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red[900]),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //todo, check answer, this is for the wrong answer
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          //todo, ScoreKeeper is a list that store Icons(Check and close icon) based on what user answered
          children: scoreKeeper,
        )
      ],
    );
  }
}
