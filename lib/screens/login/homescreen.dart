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
          color: Colors.black,
          fontSize: 14,
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
                color: Colors.black,
                fontSize: 14,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w700,

            ),
          )

        ]
        )
    ),Center(
        child: Column(children:<Widget>[


             Text(
              "\n?איך ניתן להתגבר עליה\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
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
    return Center(child:Column(
      children: <Widget>[
        Text(
          "\nשלום דנה",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "\nבאפליקציה הזו אנו מציעים\n ידע חשוב על החרדה שלך\n\n\n\n",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w700,
          ),
        ),
        Stack(
          children: <Widget>[

            _buildPageView(),
          ],
        ),

        _buildCircleIndicator(),
      ],
    ));
  }

  _buildPageView() {
    return  Container(
      width: 330,
      height: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xff8ec3aa), width: 9, ),
      ),
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
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
                      "\n\n\n\n:ועכשיו, הגיע הזמן לעצב את האוואטר שלך\n\n\n",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Assistant",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Column(children:<Widget>[Text(
                          "\n\n",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Assistant",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      MaterialButton(
                        color: Colors.lightGreenAccent,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                        onPressed:  (){  Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Avatar(first:true)));},
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(
                            '!עצב',
                            style:TextStyle(
                              color: Colors.black,
                              fontSize: 24,
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
          ),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
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
