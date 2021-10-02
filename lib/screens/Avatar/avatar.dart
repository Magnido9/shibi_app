import 'dart:math';
import 'package:application/screens/Avatar/bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';

class AvatarData {
  AvatarData(
      {required this.body,
      this.glasses,
      this.hands,
      this.body_color,
      this.money,
        this.acquired}) {
    hands = hands ?? AvatarData.hand_default;
    glasses = glasses ?? "images/glasses1.png";
    acquired = acquired ?? AvatarShop.empty();
  }
  AvatarShop? acquired;
  String body;
  String? glasses;
  String? hands;
  int color = 0;
  int? money = 0;
  Color? body_color = Color(0xffdabfa0);


  int bar2 = 0;
  int mode = 0;

  static Color color_default = Color(0xffdabfa0);

  static String body_default = "images/poo.png";
  static String hand_default = "images/hands1.png";

  static Future<AvatarData> load() async {
    String? pid = AuthRepository.instance().user?.uid;
    var v =
        (await FirebaseFirestore.instance.collection("avatars").doc(pid).get());
    /*String valueString=v['body_color'];
    int value = int.parse(valueString, radix: 16);*/
    print(v.data());
    // Map<String, int> pricess = {
    //   "images/glasses3.png": 10,
    //   "images/glasses4.png": 12,
    // };
    // String image;
    // for (int i = 0; i < pricess.keys.length; i++) {
    //   image = pricess.keys.elementAt(i);
    //   if ((v).data()!.containsKey(image)) {
    //     pricess.remove(pricess.keys.elementAt(i));
    //   }
    // }
    var a = AvatarData(
        body: v['body'],
        glasses: v['glasses'],
        // hands: v['hands'],
        body_color: Color(int.parse(v['body_color'], radix: 16)),
        money: v['money'],
    );
    // print('load  '+a.toString()+' cat');
    return a;
  }
}

class Avatar extends StatelessWidget {
  // This widget is the root of your application.
  Avatar({required this.first});
  final bool first;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (first)
          ? AvatarPage(
              title: "hey",
              data: AvatarData(
                  body: AvatarData.body_default,
                  hands: AvatarData.hand_default,
                  body_color: AvatarData.color_default,
                  money: 10))
          : FutureBuilder(
              future: AvatarData.load(),
              builder:
                  (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
                if (snapshot.hasData) {
                  return AvatarPage(
                      title: "hey",
                      data: (snapshot.data ??
                          AvatarData(
                              body: AvatarData.body_default,
                              hands: AvatarData.hand_default,
                              body_color: AvatarData.color_default)));
                } else
                  return AvatarPage(
                      title: "hey",
                      data: (AvatarData(
                          body: AvatarData.body_default,
                          hands: AvatarData.hand_default,
                          body_color: AvatarData.color_default)));
              }),
    );
  }
}

class AvatarPage extends StatefulWidget {
  AvatarPage({Key? key, required this.title, required this.data})
      : super(key: key);
  final String title;

  @override
  _AvatarPageState createState() => _AvatarPageState();
  final AvatarData data;
}

class _AvatarPageState extends State<AvatarPage> {
  void _save() async {
    String? pid = AuthRepository.instance().user?.uid;
    print("saving");
    await FirebaseFirestore.instance.collection("avatars").doc(pid).update({
      'body': widget.data.body,
      'glasses': widget.data.glasses,
      'body_color': widget.data.body_color.toString().split('(0x')[1].split(')')[0],
      'purchased' : widget.data.acquired?.acquired_items.toString()
    });
  }
/*
  Future<bool> _buy(int price, String image) async {
    if (!(widget.data.prices.containsKey(image))) {
      return true;
    }
    String? pid = AuthRepository.instance().user?.uid;
    var v =
        (await FirebaseFirestore.instance.collection("avatars").doc(pid).get());

    print(v.data());
    int money = v['money'];
    print(money);

    print(v);
    print(widget.data.body_color);
    Map<String, dynamic> m = v.data()!;
    if (money >= price) {
      m.remove("money");
      m.addAll({image: 'unlocked', "money": money - price});
      await FirebaseFirestore.instance.collection("avatars").doc(pid).set(m);
      widget.data.prices.remove(image);
      return true;
    }
    return false;
  }
*/
  buy(int i, int j, int n){
    int money = widget.data.money ?? 0;
    if((widget.data.acquired?.acquired_items[i][j][n]?? false) || money>= AvatarShop.merch[i][j][n].item2){
     setState(() {
       widget.data.money =money - AvatarShop.merch[i][j][n].item2;
       widget.data.acquired?.acquired_items[i][j][n] = true;
     });
    }
  }

  choose(int i, int j, int n){
    if(widget.data.acquired?.acquired_items[i][j][n]?? false){
      switch (i){
        case 0:{
          if(j==0) setState(() {
            widget.data.glasses = AvatarShop.merch[i][j][n].item1;
          });
        }break;
        case 1:{

        }break;
      }
    }
  }


  Widget build_money(String text) {
    return Stack(children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.white,
        ),
      ),
      Container(
        width: 24,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.white,
        ),
      ),
      Container(
        width: 24,
        height: 26,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 0.65,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _min = min(_width, _height);
    return Scaffold(
        body: Stack(children: [
          Positioned(
              left: -0.8 * MediaQuery.of(context).size.width,
              top: -1.25 * MediaQuery.of(context).size.height,
              child: Container(
                  width: 0.8125 * MediaQuery.of(context).size.height * 2,
                  height: 0.8125 * MediaQuery.of(context).size.height * 1.8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(
                        0xffecdbc7,
                      )))),
          Positioned(
              right: 25,
              top: 75,
              child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "עיצוב השיבי שלך",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.assistant(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ]))),

          // Figma Flutter Generator Group304Widget - GROUP

          Positioned(
              left: 22,
              top: 131.32,
              child: build_money(widget.data.money.toString())),
          Positioned(
            left: 45,
            top: 120,
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(height: 200),
                Flexible(
                  flex:1,
                  child: Container(
                      width: 200,
                      height: 200,
                      child: AvatarStack(
                        data: widget.data,
                      )),
                ),
                Container(height: 10),
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
                      onPressed: () {},
                    ),
                  ],
                ),
                /*
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (widget.data.mode % 4 == 0 && widget.data.bar2 == 0)
                        ? Row(children: <Widget>[
                            Container(width: 14),
                            Container(width: 14),
                            _pick_box('images/glasses1.png', 1),
                            Container(width: 14),
                            _pick_box('images/glasses2.png', 2),
                            Container(width: 14),
                            _pick_box('images/glasses3.png', 3),
                            Container(width: 14),
                            _pick_box('images/glasses4.png', 4),
                            Container(width: 14),
                            Container(width: 14),
                          ])
                        : (widget.data.mode % 4 == 1 && widget.data.bar2 == 0)
                            ? Row(children: <Widget>[
                                Container(width: 14),
                                Container(width: 14),
                                _pick_box('images/color(ff6f6ca7).png', 1),
                                Container(width: 14),
                                _pick_box('images/color(ffa6d6c3).png', 2),
                                Container(width: 14),
                                _pick_box('images/color(ffdabfa0).png', 3),
                                Container(width: 14),
                                _pick_box('images/color(ffefb3e2).png', 4),
                                Container(width: 14),
                                Container(width: 14),
                              ])
                            : Row(children: <Widget>[
                                Container(width: 14),
                                Container(width: 14),
                                _pick_box('images/glasses1.png', 1),
                                Container(width: 14),
                                _pick_box('images/glasses2.png', 2),
                                Container(width: 14),
                                _pick_box('images/glasses3.png', 3),
                                Container(width: 14),
                                _pick_box('images/glasses4.png', 4),
                                Container(width: 14),
                                Container(width: 14),
                              ])),
                Container(height: 10),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 65,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffb9b8b8),
                            width: 2,
                          ),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('images/left_arrow.png'),
                              fit: BoxFit.scaleDown)),
                    ),
                    Container(
                      width: 88,
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: Color(0xffb9b8b8),
                            width: 2,
                          ),
                          color: widget.data.mode % 3 == 0
                              ? Color(0xfffefad8)
                              : widget.data.mode % 3 == 1
                                  ? Color(0xffddfed8)
                                  : widget.data.mode % 3 == 2
                                      ? Color(0xffddfed8)
                                      : Color(0xffddfed8),
                          image: DecorationImage(
                              image: widget.data.mode % 3 == 0
                                  ? AssetImage('images/face.png')
                                  : widget.data.mode % 3 == 1
                                      ? AssetImage('images/color.png')
                                      : widget.data.mode % 3 == 2
                                          ? AssetImage('images/color.png')
                                          : AssetImage('images/color.png'),
                              fit: BoxFit.scaleDown)),
                    ),
                    Container(
                      width: 30,
                      height: 65,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffb9b8b8),
                            width: 2,
                          ),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('images/right_arrow.png'),
                              fit: BoxFit.scaleDown)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.data.mode += 1;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 148,
                      height: 65,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                              width: 84,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                    color: widget.data.bar2 == 0
                                        ? Color(0xff35258a)
                                        : Color(0xffb9b8b8),
                                    width: widget.data.bar2 == 0 ? 4 : 2,
                                  ),
                                  color: Color(0xfff6f5ed),
                                  image: DecorationImage(
                                      image: widget.data.mode % 4 == 0
                                          ? AssetImage('images/eyes.png')
                                          : widget.data.mode % 4 == 1
                                              ? AssetImage('images/body.png')
                                              : widget.data.mode % 4 == 2
                                                  ? AssetImage(
                                                      'images/color1.png')
                                                  : AssetImage(
                                                      'images/color1.png'),
                                      fit: BoxFit.scaleDown)),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.data.bar2 = 0;
                                  });
                                },
                              )),
                          Container(
                              width: 84,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                    color: widget.data.bar2 == 1
                                        ? Color(0xff35258a)
                                        : Color(0xffb9b8b8),
                                    width: widget.data.bar2 == 1 ? 4 : 2,
                                  ),
                                  color: Color(0xfff6f5ed),
                                  image: DecorationImage(
                                      image: widget.data.mode % 4 == 0
                                          ? AssetImage('images/brows.png')
                                          : widget.data.mode % 4 == 1
                                              ? AssetImage('images/eyes.png')
                                              : widget.data.mode % 4 == 2
                                                  ? AssetImage(
                                                      'images/color2.png')
                                                  : AssetImage(
                                                      'images/color2.png'),
                                      fit: BoxFit.scaleDown)),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.data.bar2 = 1;
                                  });
                                },
                              )),
                          Container(
                              width: 84,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                    color: widget.data.bar2 == 2
                                        ? Color(0xff35258a)
                                        : Color(0xffb9b8b8),
                                    width: widget.data.bar2 == 2 ? 4 : 2,
                                  ),
                                  color: Color(0xfff6f5ed),
                                  image: DecorationImage(
                                      image: widget.data.mode % 4 == 0
                                          ? AssetImage('images/mouth.png')
                                          : widget.data.mode % 4 == 1
                                              ? AssetImage('images/mouth.png')
                                              : widget.data.mode % 4 == 2
                                                  ? AssetImage(
                                                      'images/color3.png')
                                                  : AssetImage(
                                                      'images/color3.png'),
                                      fit: BoxFit.scaleDown)),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.data.bar2 = 2;
                                  });
                                },
                              )),
                          Container(
                              width: 84,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                    color: widget.data.bar2 == 3
                                        ? Color(0xff35258a)
                                        : Color(0xffb9b8b8),
                                    width: widget.data.bar2 == 3 ? 4 : 2,
                                  ),
                                  color: Color(0xfff6f5ed),
                                  image: DecorationImage(
                                      image: widget.data.mode % 4 == 0
                                          ? AssetImage('images/mouth.png')
                                          : widget.data.mode % 4 == 1
                                              ? AssetImage('images/mouth.png')
                                              : widget.data.mode % 4 == 2
                                                  ? AssetImage(
                                                      'images/color3.png')
                                                  : AssetImage(
                                                      'images/color3.png'),
                                      fit: BoxFit.scaleDown)),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.data.bar2 = 3;
                                  });
                                },
                              ))
                        ],
                      ),
                    )
                  ],
                ),*/
                AvatarBar(
                    shop: widget.data.acquired ?? AvatarShop(AvatarShop.empty().toString()),
                    tap: choose,
                    dtap: buy),
                MaterialButton(
                  onPressed: () => {
                    _save(),
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Home()))
                  },
                  color: Colors.grey,
                  child: Text("שמור"),
                ),
              ],
            ),
          )
        ]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Home()))
              },
              label: Text("חזור"),
            ),
          ],
        ));
  }
}

class AvatarStack extends StatelessWidget {
  AvatarStack({required this.data, Key? key}) : super(key: key);

  final AvatarData data;
  @override
  Widget build(BuildContext context) {
    return Center(child:
        LayoutBuilder(builder: (BuildContext context, BoxConstraints cons) {
      return Container(
          // color:Colors.grey,
          width: min(cons.maxWidth, cons.maxHeight),
          height: min(cons.maxWidth, cons.maxHeight),
          child: Stack(children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.green,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Image.asset(
                              data.hands ?? AvatarData.hand_default),
                        ),
                        height: constraints.maxHeight * 0.75,
                        margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.2,
                          // left: constraints.maxWidth/14
                        ),
                      ),
                    ]);
              },
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var r = constraints.maxWidth * 0.5;
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Container(
                              width: r,
                              height: r,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(r),
                                  border: Border.all(
                                    color: data.body_color ?? Colors.grey,
                                    width: r * 45 / 128,
                                  ))),
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.15,
                          )),
                    ]);
              },
            ),

            //glasses
            if (data.glasses != null)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(data.glasses ?? ''),
                          height: constraints.maxHeight * 0.1,
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.15,
                            // left: constraints.maxWidth/14
                          ),
                        ),
                      ]);
                },
              )
          ]));
    }));
  }
}

class LoadAvatar extends StatefulWidget {
  @override
  _LoadAvatarState createState() => _LoadAvatarState();
}

class _LoadAvatarState extends State<LoadAvatar> {
  Future<AvatarData>? _data;

  @override
  void initState() {
    super.initState();
    _data = AvatarData.load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
          if (snapshot.hasData) {
            return AvatarStack(
                data: (snapshot.data ??
                    AvatarData(
                        body: AvatarData.body_default,
                        hands: AvatarData.hand_default,
                      )));
          } else
            return CircularProgressIndicator(
              color: Colors.green,
            );
        });
  }
}

class AvatarShop {
  AvatarShop(String s): acquired_items=[]
  {fromString(s);}

  List<List<List<bool>>> acquired_items;
  static List<String> groups=
  [
    'images/face.png',
    'images/color.png',

  ];

  static List<List<String>> sub_groups=
  [
    [
      'images/eyes.png',
      'images/brows.png',
      'images/mouth.png',
    ],
    [
      'images/body.png',
      'images/eyes.png',
      'images/mouth.png',
    ]
  ];

  static List<List<List<Tuple2<String,int>>>> merch=
  [
    [//face
      [//eyes
  Tuple2('images/glasses1.png',0),
  Tuple2('images/glasses2.png',0),
  Tuple2('images/glasses3.png',10),
  Tuple2('images/glasses4.png',12),
      ],
      [],//brows
      [],//lips
    ],
    [//color
      [//body
  Tuple2('images/color(ff6f6ca7).png',0),
  Tuple2('images/color(ffa6d6c3).png',0),
  Tuple2('images/color(ffdabfa0).png',0),
  Tuple2('images/color(ffefb3e2).png',0),
      ],
      [//eyes
  Tuple2('images/color(ff6f6ca7).png',0),
  Tuple2('images/color(ffa6d6c3).png',0),
  Tuple2('images/color(ffdabfa0).png',0),
  Tuple2('images/color(ffefb3e2).png',0),
      ],
      [//lips
  Tuple2('images/color(ff6f6ca7).png',0),
  Tuple2('images/color(ffa6d6c3).png',0),
  Tuple2('images/color(ffdabfa0).png',0),
  Tuple2('images/color(ffefb3e2).png',0),
      ]
    ]
  ];

  static AvatarShop empty(){
    var ret=[];
    for( int i=0; i< groups.length; i++){
      ret.add([]);
      for( int j=0; j< sub_groups[i].length; j++){
        ret[i].add([]);
        for( int n=0; n< merch[i][j].length; n++){
          ret[i][j].add(false);
        }
      }
    }
    var a=AvatarShop(ret.toString());
    return  a;
  }

  @override
  toString(){
    var ret=[];
    for( int i=0; i< groups.length; i++){
      ret.add([]);
      for( int j=0; j< sub_groups[i].length; j++){
        ret[i].add([]);
        for( int n=0; n< merch[i][j].length; n++){
          ret[i].add(acquired_items[i][j][n]? 1: 0);

        }
      }
    }
    return acquired_items.toString();
  }

  fromString(String s){
    var lists = json.decode(s);
    acquired_items=[];
    for( int i=0; i< groups.length; i++){
      acquired_items.add([]);
      for( int j=0; j< sub_groups[i].length; j++){
        acquired_items[i].add([]);
        for( int n=0; n< merch[i][j].length; n++){

          acquired_items[i][j].add((lists[i][j][n]==1)? true: false);

        }
      }
    }
  }


}











