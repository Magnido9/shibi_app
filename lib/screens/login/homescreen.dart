library authantication;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import '../home/home.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("THIS IS HOME"),
      ),
    );
  }
}
*/

/*
/// This is the main application widget.
class Instructions extends StatelessWidget {
   const Instructions({Key? key}) : super(key: key);
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body:  _MyStatelessWidget(),

      ),
    );
  }

}

/// This is the stateless widget that the main application instantiates.
class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget({Key? key}) : super(key: key);
  final _currentPageNotifier = ValueNotifier<int>(0);
  void fr(){}
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Column(
    children: <Widget>[PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      onPageChanged: (int index) {
          _currentPageNotifier.value = index;
        },
      children:  <Widget>[
        Center(
          child: Text('שלום!'),
        ),
        Center(
          child: Text('זה אפליקציה שתתקן לך חרדה'),
        ),
        Center(
          child: Column(
              children: <Widget>[
                 Text('בהצלחה'),
                ElevatedButton(
                    onPressed:  (){  Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Avatar(first:true)));},
                    child: Text("יאללה בלגן"))
          ])
        )
      ],
    ),
    Positioned(
    left: 0.0,
    right: 0.0,
    bottom: 0.0,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: CirclePageIndicator(
    itemCount: 3,
    currentPageNotifier: _currentPageNotifier,
    ),
    ),
    )
 ],
    );

  }
}



void _next(BuildContext context){
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => Home()));
}*/
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';


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
  final _items = <Widget>[
    Center(
  child: Column(children:<Widget>[

 Text(
        "\n?איך היא גורמת לך להרגיש\n\n",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xff35258a),
          fontSize: 18,
          fontFamily: "Assistant",
          fontWeight: FontWeight.w700,
        ),

    )

  ]
  )
  ),
    Center(
        child: Column(children:<Widget>[

 Text(
              "\n?מה משמר ומעצים אותה\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff35258a),
                fontSize: 18,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w700,

            ),
          )

        ]
        )
    ),
    Center(
        child: Column(children:<Widget>[


             Text(
              "\n?איך ניתן להתגבר עליה\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff35258a),
                fontSize: 18,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w700,
              ),

          )

        ]
        )
    )
  ];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(children: <Widget>[_buildPageView(),
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
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w900,
          ),
        ), Text(
          "\nהאפליקציה הזו מציעה",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w900,
          ),
        ), Text(
          "ידע חשוב על החרדה שלך",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w900,
          ),
        ),

          ],
        ))),
        Align( alignment:Alignment.centerLeft,child:_buildCircleIndicator()),
      ],
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
    return Stack(
        children:[

     Positioned(top:MediaQuery.of(context).size.height*0.4,child: Container(width:MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height/2,child:Center(child:PageView.builder(
          scrollDirection: Axis.vertical,
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
            setState(() {

            });
          },
          itemCount: 4,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            if(index==3){
              return /*Center(
                  child: Column(
                      children: <Widget>[
                        Text('בהצלחה'),
                        ElevatedButton(
                            onPressed:  (){  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => Avatar(first:true)));},
                            child: Text("יאללה בלגן"))
                      ])
              )*/Center(
                  child: Column(children:<Widget>[

                    Text(
                      "\nבעזרת ליווי, כלים ותרגול \nנעבוד יחד עד שתלמדי להכיר ולנהל\nאת החרדה שלך בעצמך:\n\n",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff35258a),
                        fontSize: 18,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Column(children:<Widget>[
                      MaterialButton(
                        color: Color(0xff35258a),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(36) ),
                        onPressed:  (){  Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Avatar(first:true)));},
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'אני מוכנה',
                            style:TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Assistant",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )


                      ]
                        )


                  ]
                  )
              );
            }
            return _items[index];
          },
          ),)
        )),
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

        ]);
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
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
    ));
  }


}
