import 'package:flutter/material.dart';
import 'package:myquizapp/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//
// void main() {
//   runApp(QuizApp());
// }
//
// class QuizApp extends StatefulWidget {
//   const QuizApp({Key? key}) : super(key: key);
//
//   @override
//   State<QuizApp> createState() => _QuizAppState();
// }
//
// class _QuizAppState extends State<QuizApp> {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           appBar: AppBar(
//               centerTitle: true,
//               title: Text(
//                 'My Profile ',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//           ),
//
//           body:
//               Expanded(
//
//
//   ),
//             ),
//           );
//
//
// }

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
//////////////////////////////////////////////////////////////////
    //Check For Correct And Incorrect Answers
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'THE END',
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      //For Incorrect Answer
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
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
        ////////////////////////////////////////////////////////////////////
        //questions
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ),
        ),
        //////////////////////////////////////////////////////////////
        //Corrent Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:Colors.green,
                // Text Color
              ),
              child: const Text(
                'CORRECT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        ///////////////////////////////////////////////////////////////////
        //Incorrect Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:Colors.red, // Text Color
              ),
              child: const Text(
                'INCORRECT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        ////////////////////////////////////////////////////////////////////
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}