import 'dart:math';
import '../home/home.dart';
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
      'questionText': 'כשאני מפחד, קשה לי לנשום',
      'answers': [
        {'text': 'לעיתים קרובות', 'score': 2},
        {'text': 'לפעמים', 'score': 1},
        {'text': 'כמעט אף פעם', 'score': 0},
      ],
    },
    {
      'questionText': 'אני מודאג מאנשים שלא יחבבו אותי',
      'answers': [
        {'text': 'לעיתים קרובות', 'score': 2},
        {'text': 'לפעמים', 'score': 1},
        {'text': 'כמעט אף פעם', 'score': 0},
      ],
    },
    {
      'questionText': 'שאלה 3',
      'answers': [
        {'text': 'לעיתים קרובות', 'score': 2},
        {'text': 'לפעמים', 'score': 1},
        {'text': 'כמעט אף פעם', 'score': 0},
      ],
    },
    {
      'questionText': 'שאלה 4',
      'answers': [
        {'text': 'לעיתים קרובות', 'score': 2},
        {'text': 'לפעמים', 'score': 1},
        {'text': 'כמעט אף פעם', 'score': 0},
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
    _totalScore += score * (pow(10, _questionIndex).toInt());

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
      theme: ThemeData(fontFamily: "Assistant"),
      home: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "שאלון חרדה יומי",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: "Assistant",
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          leading: Builder(
            builder: (context) => GestureDetector(
                onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Home()))
                    },
                child: Icon(Icons.arrow_back)),
          ),
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
        ), //Paddingk
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
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Color(0xff8ec3aa),
            width: 9,
          ),
        ),
        child: Column(
          children: [
            Text(
              ' שאלה ${(questionIndex + 1).toString()} מתוך ${questions.length.toString()}\n\n\n\n\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w700,
              ),
            ),
            Question(
              questions[questionIndex]['questionText'].toString(),
            ), //Question
            ...(questions[questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              return Answer(() => answerQuestion(answer['score']),
                  answer['text'].toString());
            }).toList()
          ],
        )); //Column
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
        questionText + "\n\n",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: "Assistant",
          fontWeight: FontWeight.w700,
        ),
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
      //width: double.infinity,
      child: MaterialButton(
        minWidth: 189,
        height: 37,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Color(0xff8ec3aa), width: 2)),
        color: Colors.white,
        splashColor: Colors.yellow[200],
        textColor: Colors.black,
        child: Text(answerText),
        onPressed: () {
          selectHandler();
        },
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
          //Text
          Text(
            'תודה ששיתפת',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Assistant",
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ), //Text
          FlatButton(
            child: Text(
              'חזור למסך הבית',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w700,
              ),
            ), //Text
            onPressed: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()))
            },
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
