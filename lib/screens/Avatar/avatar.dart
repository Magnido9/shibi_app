import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';




class AvatarData {
  AvatarData({required this.body, this.glasses, this.body_color,this.money,required this.prices});
  String body;
  String? glasses;
  String? hands="images/hands1.png";
  int color=0;
  Map<String,int> prices={
    "images/glasses3.png":10,
    "images/glasses4.png":12,

  };
  int? money;
  Color? body_color=Color(0xffdabfa0);
  int bar2=0;
  int mode=0;
  static Map<String,int> prices_default={
    "images/glasses3.png":10,
    "images/glasses4.png":12,

  };
  static String body_default = "images/poo.png";
  static Future<AvatarData> load() async {
    String? pid = AuthRepository.instance().user?.uid;
    var v =
        (await FirebaseFirestore.instance.collection("avatars").doc(pid).get());
    /*String valueString=v['body_color'];
    int value = int.parse(valueString, radix: 16);*/

    Map<String,int> pricess={
      "images/glasses3.png":10,
      "images/glasses4.png":12,

    };
    String image;
    for(int i=0;i< pricess.keys.length;i++){
      image=pricess.keys.elementAt(i);
      if((v).data()!.containsKey(image)){
        pricess.remove(pricess.keys.elementAt(i));
    }
    }
    return AvatarData(body: v['body'], glasses: v['glasses'], body_color: Color(int.parse(v['body_color'], radix: 16)) ,money:v['money'],prices:pricess );
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
              title: "hey", data: AvatarData(body: AvatarData.body_default , prices:AvatarData.prices_default))
          : FutureBuilder(
              future: AvatarData.load(),
              builder:
                  (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
                if (snapshot.hasData) {
                  return AvatarPage(
                      title: "hey",
                      data: (snapshot.data ??
                          AvatarData(body: AvatarData.body_default , prices:AvatarData.prices_default)));
                } else
                  return AvatarPage(
                      title: "hey",
                      data: (AvatarData(body: AvatarData.body_default , prices:AvatarData.prices_default)));
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
    await FirebaseFirestore.instance
        .collection("avatars")
        .doc(pid)
        .set({'body': widget.data.body, 'glasses': widget.data.glasses, 'body_color':widget.data.body_color.toString().split('(0x')[1].split(')')[0]});
  }
  Future<bool> _buy(int price,String image) async {
    if(!(widget.data.prices.containsKey(image))){
      return true;
    }
    String? pid = AuthRepository.instance().user?.uid;
    print(price);
    var v =
    (await FirebaseFirestore.instance.collection("avatars").doc(pid).get());
    int money=v['money'];
    print(money);
    if(money>=price){
      await FirebaseFirestore.instance
          .collection("avatars")
          .doc(pid)
          .set({'body': widget.data.body, 'glasses': widget.data.glasses, 'body_color':widget.data.body_color.toString().split('(0x')[1].split(')')[0] , 'money':money-price , image:'unlocked'});
    widget.data.prices.remove(image);
      return true;
    }
    return false;
  }
  Widget _pick_box(String image,int num) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: (){
        print("buy");
        if((widget.data.prices.containsKey(image))){
          print(widget.data.prices[image]);
          _buy(widget.data.prices[image] ?? 0, image);
      }}
        ,
      onTap: () {
        setState(() {

          if(widget.data.mode%4==0 && widget.data.bar2==0 ){
            if(!(widget.data.prices.containsKey(image))){
            widget.data.glasses = image;}
          }
          if(widget.data.mode%4==1 && widget.data.bar2==0 ){
            String valueString = image.split('color(')[1].split(')')[0];
            int value = int.parse(valueString, radix: 16);
            widget.data.body_color = Color(value);
          }
          if(widget.data.mode%4==1 && widget.data.bar2==1 ){
            String valueString = image.split('color(')[1].split(')')[0];
            int value = int.parse(valueString, radix: 16);
            widget.data.body_color = Color(value);
          }

          widget.data.color=1+num;
        });
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
            border: Border.all(color:  widget.data.color==(1+num)?Color(0xff35258a):Color(0xffb9b8b8), width: 2, ),
            color:  widget.data.color==(1+num)?Color(0xffebdac7):Color(0xfff6f5ed),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.scaleDown

                )),
        child:Container(
          width: 25,
          height: 26,
          padding: const EdgeInsets.only(left: 4, ),
          child: widget.data.prices.containsKey(image)? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Stack(children:[
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black, width: 2, ),
                    color: Colors.white,
                  ),
                ),

                Container(
                  width: 24,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black, width: 2, ),
                    color: Colors.white,
                  ),
                ),

                Text(
                  "\n"+widget.data.prices[image].toString(),

                textAlign: TextAlign.center,
                  style: TextStyle(
                    height:0.65,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
 ])
            ],
          ):Container(),
        )
      ),
    );
  }
 Widget build_money(){
    return  Stack(children:[
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black, width: 2, ),
          color: Colors.white,
        ),
      ),

      Container(
        width: 24,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black, width: 2, ),
          color: Colors.white,
        ),
      ),

      Text(
        "\n "+widget.data.money.toString(),

        textAlign: TextAlign.center,
        style: TextStyle(
          height:0.65,
          color: Colors.black,
          fontSize: 14,
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
            left: -0.8*MediaQuery.of(context).size.width ,
            top: -1.25* MediaQuery.of(context).size.height,
            child: Container(
                width: 0.8125 * MediaQuery.of(context).size.height*2,
                height: 0.8125 * MediaQuery.of(context).size.height*1.8,
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

    //,"לכן, האפליקציה לא מאפשרת מענה חירום. n\את מה שאת מעלה בזמן אמת - n\אבל, המטפל/ת שלך לא תמיד רואה n\n\n\n\n\המועלה לאפליקציה. n\רק למטפל/ת שלך יש גישה למידע "
    ),

    ]))),

          // Figma Flutter Generator Group304Widget - GROUP

          Positioned(
              left: 22,
              top: 131.32,

              child: build_money()),
    Positioned(
      left: 45,
      top: 120,
      child: IconButton(
        icon: const Icon(Icons.settings_outlined),
        onPressed: () {

        },
      ),
    ),

          Positioned(
            left: 20,
            top: 510,
            child:  TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff35258a),
                shape: CircleBorder(),
              ),
              child: Icon(
                Icons.arrow_back ,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),


    Center(

          child: Column(
            children: <Widget>[

              Container(height:200),

              Container(
                  width: 128,
                  height: 128,
                  child: AvatarStack(
                    data: widget.data,
                  )),
              Container(height:10),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  (widget.data.mode%4==0 &&
                      widget.data.bar2==0 )?Row(children: <Widget>[
                        Container(width: 14),
                        Container(width: 14),
                        _pick_box('images/glasses1.png',1),
                        Container(width: 14),
                        _pick_box('images/glasses2.png',2),
                        Container(width: 14),
                        _pick_box('images/glasses3.png',3),
                        Container(width: 14),
                        _pick_box('images/glasses4.png',4),
                        Container(width: 14),
                        Container(width: 14),
                  ]):
                  (widget.data.mode%4==1 &&
                      widget.data.bar2==0 )?Row(children: <Widget>[
                    Container(width: 14),
                    Container(width: 14),
                    _pick_box('images/color(ff6f6ca7).png',1),
                    Container(width: 14),
                    _pick_box('images/color(ffa6d6c3).png',2),
                    Container(width: 14),
                    _pick_box('images/color(ffdabfa0).png',3),
                    Container(width: 14),
                    _pick_box('images/color(ffefb3e2).png',4),
                    Container(width: 14),
                    Container(width: 14),
                  ]):




                  Row(children: <Widget>[
                    Container(width: 14),
                    Container(width: 14),
                    _pick_box('images/glasses1.png',1),
                    Container(width: 14),
                    _pick_box('images/glasses2.png',2),
                    Container(width: 14),
                    _pick_box('images/glasses3.png',3),
                    Container(width: 14),
                    _pick_box('images/glasses4.png',4),
                    Container(width: 14),
                    Container(width: 14),
                  ])
              ),

      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[
                    Container(
                      width: 30,
                      height: 65,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffb9b8b8), width: 2, ),
                        color: Colors.white,
                        image:DecorationImage(image: AssetImage('images/left_arrow.png'), fit: BoxFit.scaleDown

                        )
                      ),
                    ),
                     Container(
                        width: 88,
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Color(0xffb9b8b8), width: 2, ),
                          color:
                          widget.data.mode%3==0 ? Color(0xfffefad8):
                          widget.data.mode%3==1 ? Color(0xffddfed8):
                          widget.data.mode%3==2 ? Color(0xffddfed8): Color(0xffddfed8),
                          image: DecorationImage(image:
                          widget.data.mode%3==0 ? AssetImage('images/face.png'):
                          widget.data.mode%3==1 ? AssetImage('images/color.png'):
                          widget.data.mode%3==2 ? AssetImage('images/color.png'):
                          AssetImage('images/color.png')
                              , fit: BoxFit.scaleDown

                        )
                        ),
                      ),
                    Container(
                      width: 30,
                      height: 65,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffb9b8b8), width: 2, ),
                          color: Colors.white,
                          image:DecorationImage(image: AssetImage('images/right_arrow.png'),fit: BoxFit.scaleDown
                          )
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.data.mode+=1;
                          });
                        },
                      ),
                    ),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: <Widget>[
                    Container(
                      width: 84,
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: widget.data.bar2==0?Color(0xff35258a) :Color(0xffb9b8b8), width:widget.data.bar2==0?4: 2, ),
                          color: Color(0xfff6f5ed),
                          image: DecorationImage(image:
                          widget.data.mode%4==0 ? AssetImage('images/eyes.png'):
                          widget.data.mode%4==1 ? AssetImage('images/body.png'):
                          widget.data.mode%4==2 ? AssetImage('images/color1.png'):
                          AssetImage('images/color1.png')
                              , fit: BoxFit.scaleDown


                          )
                      ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.data.bar2=0;
                            });
                          },
                        )
                    ), Container(
                        width: 84,
                        height: 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: widget.data.bar2==1?Color(0xff35258a) :Color(0xffb9b8b8), width:widget.data.bar2==1?4: 2, ),
                            color: Color(0xfff6f5ed),
                            image: DecorationImage(image:
                            widget.data.mode%4==0 ? AssetImage('images/brows.png'):
                            widget.data.mode%4==1 ? AssetImage('images/eyes.png'):
                            widget.data.mode%4==2 ? AssetImage('images/color2.png'):
                            AssetImage('images/color2.png')
                                , fit: BoxFit.scaleDown


                            )
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.data.bar2=1;
                            });
                          },
                        )
                    ), Container(
                        width: 84,
                        height: 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: widget.data.bar2==2?Color(0xff35258a) :Color(0xffb9b8b8), width:widget.data.bar2==2?4: 2, ),
                            color: Color(0xfff6f5ed),
                            image: DecorationImage(image:
                            widget.data.mode%4==0 ? AssetImage('images/mouth.png'):
                            widget.data.mode%4==1 ? AssetImage('images/mouth.png'):
                            widget.data.mode%4==2 ? AssetImage('images/color3.png'):
                            AssetImage('images/color3.png')
                                , fit: BoxFit.scaleDown


                            )
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.data.bar2=2;
                            });
                          },
                        )
                    ),Container(
          width: 84,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: widget.data.bar2==3?Color(0xff35258a) :Color(0xffb9b8b8), width:widget.data.bar2==3?4: 2, ),
              color: Color(0xfff6f5ed),
              image: DecorationImage(image:
              widget.data.mode%4==0 ? AssetImage('images/mouth.png'):
              widget.data.mode%4==1 ? AssetImage('images/mouth.png'):
              widget.data.mode%4==2 ? AssetImage('images/color3.png'):
              AssetImage('images/color3.png')
                  , fit: BoxFit.scaleDown


              )
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.data.bar2=3;
              });
            },
          )
      )

                  ]))
                ])),

              MaterialButton(
                onPressed: () => {
                  _save(),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Home()))
                },
                color: Colors.grey,
                child: Text("שמור"),
              ),],
          ),
        )]),
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
            //body
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  child: FittedBox(
                    child:// Image.asset(data.body)
Stack(children:<Widget>[
Container(height: 200,child:ColorFiltered(
      colorFilter: ColorFilter.mode(data.body_color??Colors.grey, BlendMode.srcATop),
        child:
           Image.asset(data.hands ?? ''  ,
             width:227,
             height: 173, ))),
                          //),
                    Positioned(
                        left:48,
                        bottom:63,
                        child:Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: data.body_color ?? Colors.grey, width: 45, ),
                      ),
                    ))]),

                    fit: BoxFit.fill,
                  ),
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                );
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
                          height: constraints.maxHeight / 8,
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight /20,
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
                    AvatarData(body: AvatarData.body_default , prices:AvatarData.prices_default)));
          } else
            return CircularProgressIndicator(
              color: Colors.green,
            );
        });
  }
}
