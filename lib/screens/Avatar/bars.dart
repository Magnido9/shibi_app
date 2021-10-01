import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';
import 'avatar.dart';
import 'package:tuple/tuple.dart';

class AvatarBar extends StatefulWidget {
  AvatarBar(
      {Key? key, required this.shop, required this.tap, required this.dtap})
      : super(key: key);

  Function(int i, int j, int n) tap;
  Function(int i, int j, int n) dtap;
  AvatarShop shop;
  @override
  _AvatarBarState createState() => _AvatarBarState();
}

class _AvatarBarState extends State<AvatarBar> {
  List<List<String>> lowerVals = AvatarShop.sub_groups;
  List<List<List<Tuple2<String, int>>>> upperVals = AvatarShop.merch;
  int mode_first = 0, mode_second = 0;
  int first_max = 1, second_max = -1;

  @override
  Widget build(BuildContext context) {
    // first_max = lowerVals.length;
    first_max = AvatarShop.groups.length;
    print(mode_first);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.height,
          child: ListView.separated(
            separatorBuilder: (_, __) => Divider(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.tap(mode_first, mode_second, index);
                  print('kjfd');
                },
                onDoubleTap: () {
                  widget.dtap(mode_first, mode_second, index);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 14),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xfff6f5ed),
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(
                        color: Color(0xffb9b8b8),
                        width: 2,
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                              upperVals[mode_first][mode_second][index].item1),
                          fit: BoxFit.scaleDown)),
                  child:
                  (widget.shop.acquired_items[mode_first][mode_second][index])
                      ? Container()
                      :build_money(upperVals[mode_first][mode_second][index].item2),
                ),
              );
            },
            itemCount: upperVals[mode_first][mode_second].length,
          ),
        ),
        Container(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                print('left');
                setState(() {
                  mode_first -= 1;
                  mode_second = 0;
                  if (mode_first == -1) mode_first = mode_first - 1;
                });
              },
              child: Container(
                width: 30,
                height: 65,
                child: Icon(Icons.arrow_left),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xffb9b8b8),
                    width: 2,

                  ),
                ),
              ),
            ),
            Container(
                width: 88,
                height: 65,

                child: mode_first == 0
                    ? Image.asset('images/face.png')
                    : mode_first == 1
                        ? Image.asset('images/color.png')
                        : mode_first == 2
                            ? Icon(Icons.style)
                            : Icon(Icons.account_balance_outlined),
                decoration: BoxDecoration(
                  color: mode_first == 0
                      ? Color(0xfffefad8)
                      : mode_first == 1
                      ? Color(0xffddfed8)
                      : mode_first == 2
                      ? Colors.grey
                      : Colors.blue,
                  border: Border.all(
                    color: Color(0xffb9b8b8),
                    width: 2,
                  ),
                )),
            GestureDetector(
              onTap: () {
                setState(() {
                  mode_first += 1;
                  mode_second = 0;
                  if (mode_first == first_max) mode_first = 0;
                });
              },
              child: Container(
                width: 30,
                height: 65,
                child: Icon(Icons.arrow_right),
                decoration: BoxDecoration(
                  color: Colors.white,

                  border: Border.all(
                    color: Color(0xffb9b8b8),
                    width: 2,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 148,
              height: 65,
              child: ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                      width: 84,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Color(0xfff6f5ed),

                          border: Border.all(
                            color: (mode_second == index)
                                ? Colors.blue
                                : Colors.black,
                            width: (mode_second == index) ? 4 : 2,
                          ),
                          image: DecorationImage(
                              image: AssetImage(lowerVals[mode_first][index]),
                              fit: BoxFit.scaleDown)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mode_second = index;
                          });
                        },
                      ));
                },
                itemCount: lowerVals[mode_first].length,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget build_money(int num) {
    if(num==0) return Container();
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
            num.toString(),
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
}