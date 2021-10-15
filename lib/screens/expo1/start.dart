library expo;

import 'package:application/screens/Avatar/avatar.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:application/screens/login/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'feelings.dart';
import 'thoughts.dart';

class Expo1 extends StatelessWidget {
  Expo1({required this.adata});
  AvatarData adata;

  @override
  Widget build(BuildContext context) {
    return Provider(create: (context)=>ExpoData(adata: adata),
      child: MaterialApp(
        title: 'חשיפה 1',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => _Page1(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => _Page2(),
          '/main': (context) => _Main(),
          '/thoughts/1': (context) => thought1_1(),
          '/thoughts/2': (context) => thought2_1(),
           '/feelings/1' : (context) => feeling1_1(),
          // '/body/1' : (context) => ,
        },
      ),
    );
  }
}

class _Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<_Page1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Stack(
        children: [
          Positioned(
              left: -0.8 * MediaQuery.of(context).size.width,
              top: -1.25 * MediaQuery.of(context).size.height,
              child: Container(
                  width: 0.8125 * MediaQuery.of(context).size.height * 2,
                  height: 0.8125 * MediaQuery.of(context).size.height * 1.8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: Color(0xffdee8f3)))),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: FloatingActionButton(
                backgroundColor: Colors.grey.shade400,
                onPressed: () {
                },
                child: Icon(Icons.arrow_forward),
              ),
              margin: EdgeInsets.all(30),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child:  FlatButton(
                color: Colors.transparent,
                onPressed: () {

                },

                child: new IconTheme(
                  data: new IconThemeData(
                    size:35,
                      color: Color(0xff6f6ca7)),
                  child: new Icon(Icons.menu),
    ),
              ),
              margin: EdgeInsets.all(30),
            ),
          ),

          Positioned(
              top: -height,
              left: -width * 0.5,
              child: Container(
                width: width * 2,
                height: width * 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Color(0xffdee8f3),
                ),
              )),
          Column(
            children: [
              Container(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "חשיפה ראשונה",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Assistant",
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "?מה עליי לבצע",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Assistant",
                          fontWeight: FontWeight.w700,
                        ),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.all(30),
                width: width * 0.9,
                height: height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xccebebeb),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    '\"להכנס לחנות בגדים ולבקש למדוד פריט מסוים. לבקש עוד פריט, לצאת ולומר תודה רבה מבלי לקנות דבר\"',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xff6f6ca7),
                      fontSize: 20,
                      fontFamily: "Assistant",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(40),
                  child: Stack(children: [
                    Container(
                        width: 200,
                        height: 39,
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/second');
                            },
                            minWidth: 200,
                            height: 39,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36)),
                            color: Color(0xff35258a),
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 5,
                                right: 25,
                                child: Text(
                                  "בואו נתחיל!",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.assistant(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ]))),
                    Positioned(
                        top: 5,
                        right: 165,
                        child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(color: Colors.white, width: 9),
                            ))),
                  ]))
            ],
          )
        ],
      ),
    );
  }
}

class _Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<_Page2> {
  double feeling = 50;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -height,
              left: -width * 0.5,
              child: Container(
                width: width * 2,
                height: width * 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Color(0xffdee8f3),
                ),
              )),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: FloatingActionButton(
                backgroundColor: Colors.grey.shade400,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_forward),
              ),
              margin: EdgeInsets.all(30),
            ),
          ),
          Column(
            children: [
              Container(                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "דיווח ראשון",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Assistant",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      child: Center(
                        child: Text(
                          '?',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffc4c4c4),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              //
                              TextSpan(
                                  text:
                                      'עלייך לדרג מ-0 עד 100 יחידות מצוקה.\n'),
                              TextSpan(
                                  text: '0 - ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff35258A))),
                              TextSpan(text: 'המצב לא מעורר חרדה.\n'),
                              TextSpan(
                                  text: '50 - ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff35258A))),
                              TextSpan(
                                  text:
                                      'מצב מעורר חרדה אך, במאמץ את מרגישה שתוכלי להתמודד איתו.\n'),
                              TextSpan(
                                  text: '100 - ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff35258A))),
                              TextSpan(
                                  text:
                                      'המצב שבו את מדמיינת שתחווי את החרדה הגרועה ביותר שתחויי בחייך.\n'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text(
                              'x',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "עד כמה את מרגישה לחץ או חרדה?",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Assistant",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          "דרגי את המשימה בהתאם",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Consumer<ExpoData>(
                builder: (context, data, x){
                  AvatarData x = data.adata;
                  if(feeling<50 ) x.hands= 'images/handsclosed.png';
                  else x.hands= 'images/handsopen.png';
                    print(x.hands);
                  print('efew');
                  print(data.adata.hands);
                  print('wef');
                  // x.hands= 'images/handsclosed.png';
                  return Flexible(
                    flex: 1,
                    child: AvatarStack(data: x),
                    // child: AvatarStack(data: AvatarData()),
                  );
                },
              ),
              Container(

                  margin:
                      EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 0),
                child: SfSliderTheme(

                  data: SfSliderThemeData(
                    //trackHeight: 20.0,
                      activeTrackHeight: 20,
                    inactiveTrackHeight: 20,
                    thumbColor: Color(0xffefb3e2),
                    //thumbColor: Color(0xf0c0cd),
                    //thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    inactiveTrackColor: Color(0xffececec),
                    activeTrackColor: Color(0xffececec),

                  ),
                  child: SfSlider(
                    value: feeling,
                    min: 0,
                    max: 100,
                    showLabels:true,

                    //interval: 1,

                    onChanged: (dynamic value) {
                      setState(() {
                        feeling = value;
                      });
                    },



                  ),

                  /*child: SliderTheme(

                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 20.0,
                        thumbColor: Color(0xffefb3e2),
                          //thumbColor: Color(0xf0c0cd),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        inactiveTrackColor: Color(0xffececec),
                        activeTrackColor: Color(0xffececec),
                      ),

                    child: Slider(
                    value: feeling,
                    onChanged: (double value) {
                      setState(() {
                        feeling = value;
                      });
                    },
                    min: 0,
                    max: 100,
                    label: feeling.round().toString(),
                    divisions: 100,
                    /*inactiveColor: Colors.grey,
                    activeColor: Colors.grey,*/
                  )),*/
              ),),
              /*Container(
                child: Text
                  (
                  "0                                                   100",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Assistant",
                    //fontWeight: FontWeight.w700,
                  ),
                ),

              ),*/
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff35258a),
                      shape: CircleBorder(),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/main');
                    },
                  )
                ],
              ),
              Container(
                height: 20,
              ),

            ],
          )
        ],
      ),
    );
  }
}

class _Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<_Main> {
  int choose = -1;
  @override
  Widget build(BuildContext context) {
    print('main');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: -height,
          left: -width * 0.5,
          child: Container(
            width: width * 2,
            height: width * 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],
              shape: BoxShape.circle,
              color: Color(0xffdee8f3),
            ),
          )),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          child: FloatingActionButton(
            backgroundColor: Colors.grey.shade400,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_forward),
          ),
          margin: EdgeInsets.all(30),
        ),
      ),
      Column(
        children: [
          Container(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "זיהוי",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: "Assistant",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  child: Center(
                    child: Text(
                      '?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc4c4c4),
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: Text('יאללה תלחץ על משהו'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'x',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "בואי נזהה יחד את החרדה",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(
                      "בחרי עם איזה זיהוי להתחיל",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.01,
          ),

        TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: (choose==-1)? 0.5:0.8, end: (choose==-1)? 0.8:0.5),
            duration: Duration(milliseconds: 500),
            builder: (BuildContext context, double percent,
                Widget? child) {
              return Container(
                width: (choose==-1)?width: width*percent,
                child: Consumer<ExpoData>(
                  builder: (context, data, w){
                    print(data.done);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _MyButton(
                            isDone: data.done[0],
                            isSelected: (choose==0),
                            name: 'גוף',
                            func: (){setState(() {
                              choose=0;
                            });},
                            image: 'images/expo/meditate.png'
                        ),
                        _MyButton(
                            isDone: data.done[1],
                            isSelected: (choose==1),
                            name: 'רגשות',
                            func: (){setState(() {
                              choose=1;
                            });},
                            image: 'images/expo/smile.png'
                        ),
                        _MyButton(
                            isDone: data.done[2],
                            isSelected: (choose==2),
                            name: 'מחשבות',
                            func: (){setState(() {
                              choose=2;
                            });},
                            image: 'images/expo/brain.png'
                        ),

                      ],
                    );
                  },
                ),
              )
              ;}),

          if (choose != -1)
            Flexible(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: width * 0.9,
                  height: 247,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: Color(0xfff3f1de),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          _title(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Assistant",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        margin: EdgeInsets.all(30),
                      ),
                      Container(
                        child: Text(
                          _text(),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 30, right: 30),
                      ),
                    ],
                  )),
            ),
          if (choose != -1)
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [ TextButton(
             style: TextButton.styleFrom(
               backgroundColor: Color(0xff35258a),
               shape: CircleBorder(),
             ),
             child: Icon(
               Icons.arrow_back,
               color: Colors.white,
             ),
             onPressed: () async{
               if(choose==2) {
                 await Navigator.pushNamed(context, '/thoughts/1');

               }else if(choose==0){
                 await Navigator.pushNamed(context, '/body/1');
               } else if(choose==1){
                 await Navigator.pushNamed(context, '/feelings/1');
               }
               setState(() {
                 choose=-1;
               });
             },
           )],
         )

        ],
      ),
    ]));
  }

  String _title() {
    if (choose == 0) return 'זיהוי גוף';
    if (choose == 1) return 'זיהוי רגשות';
    if (choose == 2) return 'זיהוי מחשבות';
    return '';
  }

  String _text() {
    if (choose == 0) return 'חשוב שנלמד לזהות כיצד הגוף משפיע על החרדה שלנו.';
    if (choose == 1) return 'הרגש הוא חלק מהותי מן החרדה שלנו......';
    if (choose == 2) return 'המחשבות הם מחל מהמחשבה, וחשוב שנאתרן...';
    return '';
  }
}

class _MyButton extends StatelessWidget {
  _MyButton({required this.isSelected, required this.name, required this.func, required this.image, this.isDone = false});
  final bool isSelected,isDone;
  final String name, image;
  final func;

  @override
  Widget build(BuildContext context) {
    return Flexible(child: GestureDetector(
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints){
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(constraints.maxWidth*0.15),
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset(image, color:(isDone)? Color(0xffEDEBEB):(isSelected)? Color(0xffB3E8EF): Color(0xff35258A),)),
                  margin: EdgeInsets.all(constraints.maxWidth*0.08),
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDone)? Color(0xffABAAAA):(isSelected)? Color(0xff35258A):Color(0xffdee8f3),
                  ),
                ),
                if(isDone)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: FittedBox(
                      fit: BoxFit.fitHeight,
            child:Icon(Icons.check,color: Colors.white,),),
                      padding: EdgeInsets.all(constraints.maxWidth*0.05),

                      margin: EdgeInsets.only(top:constraints.maxWidth*0.04 ,right:constraints.maxWidth*0.08),
                      width: constraints.maxWidth*0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff808080),
                      ),
                    ),
                  )
              ],
            );
          }),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          )
        ],
      ),
      onTap: func,)
    );
  }
}

class ExpoData {
  ExpoData({required this.adata}){
    while (feelings.length % 8 != 0) {
      feelings.add('');
    }

  }
  List<bool> done =[false,false, false];
  int stress=50;
  List<String> thoughts= [
  'אני תמיד אגיד או אעשה משהו',
  'הכי נורא שיכול לקרות זה',
  'תמיד כשאני עושה דברים כאלו',
  'אף אחד אף פעם לא אוהב ש',
  'אני מרגישה לא בנוח ולכן',
  'אני לא אדע איך'
  ];
  List<String> replies=['','','','','',''];
  List<String> feelings = [
   'סיבוך', 'פגיעות', 'עצב', 'בדידות', 'ריקנות', 'אבודה', 'נידוי', 'אכזבה', 'בחילה',
    'תיעוב', 'גועל', 'חוסר נוחות', 'היסוס', 'אדישות',
    'חרטה', 'מוצף', 'מפוחד', 'מופתע', 'נואשות', '', 'לחץ','מבועט',
    'ספקנות', 'פאניקה', 'ביטחון עצמי', 'השראה', 'ריגוש', 'תקווה', '', 'גאווה',
    'שמחה', 'הקלה', 'מרמור', 'השפלה', '', 'מופתע', 'נואשות', 'כעס', 'עצבנות', 'תסכול', 'רוגז', 'קימום'
  ];
  List<int> felt=[];

  AvatarData adata;
}
