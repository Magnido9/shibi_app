import 'dart:math';

import 'package:flutter/material.dart';


class MyQuestions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyQuestionsState();
  }
}

class _MyQuestionsState extends State<MyQuestions> {
  final _questions = const [
    {
      'questionText': 'ללכת לבית הספר',
      'answers': [
        {'text': '1', 'score': 0},
        {'text': '2', 'score': 1},
        {'text': '3', 'score': 2},
        {'text': '4', 'score': 3},
        {'text': '5', 'score': 4},
        {'text': '6', 'score': 5},
        {'text': '7', 'score': 6},
        {'text': '8', 'score': 7},
        {'text': '9', 'score': 8},
        {'text': '10', 'score': 9},
      ],
    },
    {
      'questionText': 'להיפגש עם חברים',
      'answers': [
        {'text': '1', 'score': 0},
        {'text': '2', 'score': 1},
        {'text': '3', 'score': 2},
        {'text': '4', 'score': 3},
        {'text': '5', 'score': 4},
        {'text': '6', 'score': 5},
        {'text': '7', 'score': 6},
        {'text': '8', 'score': 7},
        {'text': '9', 'score': 8},
        {'text': '10', 'score': 9},

      ],
    },
    {
      'questionText': ' לבקש בננה',
      'answers': [
        {'text': '1', 'score': 0},
        {'text': '2', 'score': 1},
        {'text': '3', 'score': 2},
        {'text': '4', 'score': 3},
        {'text': '5', 'score': 4},
        {'text': '6', 'score': 5},
        {'text': '7', 'score': 6},
        {'text': '8', 'score': 7},
        {'text': '9', 'score': 8},
        {'text': '10', 'score': 9},
      ],
    },
    {
      'questionText': 'לעשות סלטה',
      'answers': [
        {'text': '1', 'score': 0},
        {'text': '2', 'score': 1},
        {'text': '3', 'score': 2},
        {'text': '4', 'score': 3},
        {'text': '5', 'score': 4},
        {'text': '6', 'score': 5},
        {'text': '7', 'score': 6},
        {'text': '8', 'score': 7},
        {'text': '9', 'score': 8},
        {'text': '10', 'score': 9},
      ],
    },
    {
      'questionText':
      'חרדה?',
      'answers': [
        {
          'text': 'Yes',
          'score': 0,
        },
        {'text': 'No', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score
        *(pow(10,_questionIndex).toInt());

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Geeks for Geeks'),
          backgroundColor: Color(0xFF00E676),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          ) //Quiz
              : Result(_totalScore, _resetQuiz),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'].toString(),
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text'].toString());
        }).toList()
      ],
    ); //Column
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ), //Text
    ); //Container
  }
}
class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Color(0xFF00E676),
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: (){selectHandler();},
      ), //RaisedButton
    ); //Container
  }
}
class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 41) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          Text(
            'Score ' '$resultScore',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          FlatButton(
            child: Text(
              'Restart Quiz!',
            ), //Text
            textColor: Colors.blue,
            onPressed: (){resetHandler();},
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}