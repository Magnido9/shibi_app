library authantication;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Avatar/avatar.dart';
import '../home/home.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';


import 'privacy.dart';


class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageViewIndicators Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
        Stack(
          children: <Widget>[
            _buildPageView(),
            Positioned(
                right:MediaQuery.of(context).size.width*0.05 ,
                child:
                Align(
                    alignment: Alignment.topRight,child:Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: <Widget>[

                    Text(
                      "\nשלום דנה",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ), Text(
                      "\nהאפליקציה הזו מציעה",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ), Text(
                      "ידע חשוב על החרדה שלך",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                  ],
                ))),
            Align( alignment:Alignment.centerLeft,child:_buildCircleIndicator()),
          ],
      ),
    );
  }


  Color _chooseColor(){
    int i= _currentPageNotifier.value;
    if(i==0) return Color(0x42a6d6c3);
    if(i==1) return Color(0x4271e5b7);
    if(i==2) return Color(0x4280b2cf);
    else return Color(0x428280cf);


  }

  _buildPageView() {
    var _items = <Widget>[
      _add_image(context, Center(
          child: Column(children:<Widget>[

            Text(
              "\n?איך היא גורמת לך להרגיש\n\n",
              textAlign: TextAlign.center,
              style: GoogleFonts.assistant(
                color: Color(0xff35258a),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),

            )

          ]
          )
      ), 'images/shibi_pages/1.png'),
      _add_image(context,Center(
          child: Column(children:<Widget>[

            Text(
              "\n?מה משמר ומעצים אותה\n\n",
              textAlign: TextAlign.center,
              style: GoogleFonts.assistant(
                color: Color(0xff35258a),
                fontSize: 18,
                fontWeight: FontWeight.w700,

              ),
            )

          ]
          )
      ),  'images/shibi_pages/2.png',  ),
      _add_image(context, Center(
          child: Column(children:<Widget>[


            Text(
              "\n?איך ניתן להתגבר עליה\n\n",
              textAlign: TextAlign.center,
              style: GoogleFonts.assistant(
                color: Color(0xff35258a),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),

            )

          ]
          )
      ),  'images/shibi_pages/3.png'),
      _add_image(context, Center(
          child: Column(children:<Widget>[

            Text(
              "\nבעזרת ליווי, כלים ותרגול \nנעבוד יחד עד שתלמדי להכיר ולנהל\nאת החרדה שלך בעצמך.\n\n",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: GoogleFonts.assistant(
                color: Color(0xff35258a),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),/*
                      MaterialButton(
                        color: Color(0xff35258a),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(36) ),
                        onPressed:  (){  Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Privacy()));},
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'אני מוכנה',
                            style:GoogleFonts.assistant(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),




                        )*/
            Stack(children:[
              Container(width:200,
                  height: 39,

                  child:MaterialButton(
                      onPressed:  (){  Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Privacy()));},

                      minWidth: 200,
                      height: 39,
                      shape:RoundedRectangleBorder( borderRadius: BorderRadius.circular(36) ),
                      color: Color(0xff35258a),
                      child: Stack(children:<Widget>[

                        Positioned(
                          top:5,
                          right: 35,
                          child: Text(
                            "אני מוכנ/ה!",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.assistant(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ]
                      )
                  )
              ),
              Positioned(
                  top:5,
                  right:165,
                  child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(color: Colors.white, width: 9 ),
                      ))),])


          ]
          )
      ),  'images/shibi_pages/win.png'),



    ];
    return Stack(
        children:[
          Positioned(
              left:-((0.8125*MediaQuery.of(context).size.height) -MediaQuery.of(context).size.width)/2,
              top: -0.1
                  *MediaQuery.of(context).size.height,
              child:Container(
                  width: 0.8125
                      *MediaQuery.of(context).size.height,
                  height: 0.8125
                      *MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:_chooseColor(),
                  ))),

     Positioned(
         top:MediaQuery.of(context).size.height*0.4,
         child: Container(width:MediaQuery.of(context).size.width,
             height:MediaQuery.of(context).size.height/2,
             child:Center(
               child:PageView.builder(
                 scrollDirection: Axis.vertical,
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
            setState(() {

            });
          },
          itemCount: 4,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return _items[index];
          },
          ),)
        )),

        ]);
  }

  _buildCircleIndicator() {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: RotatedBox(quarterTurns: 1,
        child:CirclePageIndicator(
          itemCount: 4,
          currentPageNotifier: _currentPageNotifier,
          size: 20,
          dotColor: Colors.grey,
          selectedSize: 20,
          selectedDotColor: Color(0xff8ec3aa) ,
        ),
      ),
    );
  }


}

_add_image(BuildContext context,Widget w ,String s){
  return Stack(
    children: [
      Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: FittedBox(
            child: Image.asset(s),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    w
    ],
  );
}