import 'dart:async';
import 'package:application/screens/home/home.dart';
import 'package:application/screens/home/personal_diary.dart';
import 'package:application/screens/home/psycho.dart';
import 'package:application/screens/login/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StopWatchTimerPage extends StatefulWidget {
  @override
  _StopWatchTimerPageState createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const countdownDuration = Duration(seconds: 4);
  Duration duration = Duration();
  Timer? timer;
  int medistage = 0;
  String medi = "תלחצו על הכפתור כדי להתחיל במדיטציה";
  bool countDown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
  }

  @override
  void dispose() {
    timer?.cancel();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        medistage += 1;
        if (medistage == 1) {
          medi = "בוא נתחיל בשאיפה דרך האף";
          duration = Duration(seconds: 4);
        } else if (medistage == 2) {
          medi = "ועכשיו להחזיק את האוויר בריאות";
          duration = Duration(seconds: 6);
        } else if (medistage == 3) {
          medi = "ועכשיו לנשוף!";
          duration = Duration(seconds: 8);
        } else {
          timer?.cancel();
          medistage = 0;
          medi = "בוא נתחיל בשאיפה דרך האף";
          startTimer();
        }
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    medi = "תלחצו על הכפתור כדי להתחיל במדיטציה";
    medistage = 0;
    setState(() => timer?.cancel());
  }

  Widget medBody(){return Stack(children: [
    Positioned(
        left: -((0.8125 * MediaQuery.of(context).size.height) -
            MediaQuery.of(context).size.width) /
            2,
        top: 0 * MediaQuery.of(context).size.height,
        child: Container(
            width: 0.8125 * MediaQuery.of(context).size.height,
            height: 0.8125 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
            ))),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            medi,
            style: GoogleFonts.assistant(
                fontSize: 22, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 80,
          ),
          buildTime(),
          SizedBox(
            height: 80,
          ),
          buildButtons()
        ],
      ),
    ),
  ]);}

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
            left: -((0.8125 * MediaQuery.of(context).size.height) -
                    MediaQuery.of(context).size.width) /
                2,
            top: 0 * MediaQuery.of(context).size.height,
            child: Container(
                width: 0.8125 * MediaQuery.of(context).size.height,
                height: 0.8125 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent,
                ))),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                medi,
                style: GoogleFonts.assistant(
                    fontSize: 22, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 80,
              ),
              buildTime(),
              SizedBox(
                height: 80,
              ),
              buildButtons()
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          onTap: (int page) {
            if (page == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }
            if (page == 1) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Diary()));
            }
            if (page == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Psycho()));
            }
            if (page == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StopWatchTimerPage()));
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up_outlined),
              label: 'מפת דרכים',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_queue_rounded),
              label: 'יומן',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'פסיכוחינוך',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new_outlined),
              label: 'תרגילים',
            ),
          ]));

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: seconds, header: ''),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 12,
              ),

                 Stack(children: [
                    Container(
                        width: 200,
                        height: 39,
                        child: MaterialButton(
                            onPressed: () {
                              stopTimer();
                            },
                            minWidth: 200,
                            height: 39,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36)),
                            color: Color(0xff35258a),
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 5,
                                right: 50,
                                child: Text(
                                  "הפסק!",
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
                  ]),
            ],
          )
        :
             Stack(children: [
              Container(
                  width: 200,
                  height: 39,
                  child: MaterialButton(
                      onPressed: () {
                        medistage = 1;
                        medi = "בוא נתחיל בשאיפה דרך האף";
                        startTimer();
                      },
                      minWidth: 200,
                      height: 39,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36)),
                      color: Color(0xff35258a),
                      child: Stack(children: <Widget>[
                        Positioned(
                          top: 5,
                          right: 30,
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
            ]);
  }
}
