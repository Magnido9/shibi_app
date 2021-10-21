library home;
import 'dart:math';
import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';
import 'package:flutter/services.dart';

class CareHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CareHome> {
  bool createPass = false;
  tiles(context,data) {
    List<Widget> list=[];
    for(int g=0;g<data.length;g++){

      final Map<String, dynamic> item = data[g].data();
      var b=(item['name'] !=null && item['name'] !='');

      var t=  FirebaseFirestore.instance
          .collection("users")
          .doc(item['uid']).get();
      list.add( (b)?
      Column(children:[Text(
          "מטופל " +item['name'],
          style: GoogleFonts.assistant(color: Colors.black,fontSize:20,fontWeight: FontWeight.w800)),


        (item.keys.contains('expos'))?
        Column(children:exposL(item)):Container(),

        (item.keys.contains('expos'))?
        MaterialButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36)),
            child:Text("שינוי חשיפות"),
            onPressed: (() async {
              var exp=[];

              var t= await FirebaseFirestore.instance
                  .collection("users")
                  .doc(item['uid']).get();
              exp=t['expos'];
              for(int h=0;h<expos.length;h++)
                exp[h]['expo']=expos[h].text;
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(item['uid'])
                  .set({'expos': exp},
                  SetOptions(merge: true));
              setState((){});
            }
            )):Container(),
        TextFormField(
          controller: newExp,
          decoration: InputDecoration(
            hintText: "חשיפה חדשה",
          ),
        ),
        MaterialButton(
            color: Colors.orange,
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36)),
            child:Text("הוספת חשיפה"),
            onPressed: (() async {

              var exp=[];
              if(item.keys.contains('expos')){
                var exp=[];

                var t= await FirebaseFirestore.instance
                    .collection("users")
                    .doc(item['uid']).get();
                exp=t['expos'];
                exp.add({'expo':newExp.text,
                  'feelings':[0,0,0],
                  'after':""
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(item['uid'])
                    .set({'expos': exp},
                    SetOptions(merge: true));}  else{FirebaseFirestore.instance
                  .collection("users")
                  .doc(item['uid'])
                  .set({'expos': [{'expo':newExp.text,
                'feelings':[0,0,0],
                'after':""
              }]},
                  SetOptions(merge: true));}




            }


            )),
        FutureBuilder(
            future: t,
            builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Column(children:[

                  for(int i=0;i<snapshot.data.data()['expos'].length;i++)
                    Container( width:MediaQuery.of(context).size.width*0.5,
                        child:Column(children:[Text(snapshot.data.data()['expos'][i]['expo'].toString()+":", textDirection: TextDirection.rtl,),
                          Text(" דירוג  רגשות:", textDirection: TextDirection.rtl,),
                          Text("לפני:  "+snapshot.data.data()['expos'][i]['feelings'][0].toString(),textDirection:TextDirection.rtl),
                          Text("זיהוי רגשות:  "+snapshot.data.data()['expos'][i]['feelings'][1].toString(),textDirection:TextDirection.rtl),
                          Text("אחרי ביצוע:  "+snapshot.data.data()['expos'][i]['feelings'][2].toString(),textDirection:TextDirection.rtl),
                          Text("הרגשה בחשיפה:  "+snapshot.data.data()['expos'][i]['after'].toString(),textDirection:TextDirection.rtl),

                          Text("",textDirection:TextDirection.rtl)
                        ]),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(color: Colors.indigo, width: 9),
                        ))


                ]); } else
                return CircularProgressIndicator();
            })

      ],
      )
          :LayoutBuilder(
        builder: (BuildContext context, BoxConstraints con){
          return Container(
              color: Colors.white30,
              width: con.maxWidth*1,
              child: Builder(
                builder: (context){
                  TextEditingController controller =  TextEditingController();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: con.maxWidth*0.5,
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "שם הפציינט",
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (){
                            final String name = controller.text.trim();
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(item['uid'])
                                .set({'name': name},
                                SetOptions(merge: true));
                          },
                          child: Icon(Icons.arrow_forward_rounded))
                    ],
                  );
                },
              )
          );
        },
      ) );}
    return list;

  }
  List<TextEditingController> expos=[];
  TextEditingController password = TextEditingController(text: Random().nextInt(99999).toString(),);
  TextEditingController newExp = TextEditingController(text: "",);
  List<Widget> exposL(item){
    List<Widget> arr=[];
    expos=[];
    for(int i=0;i<item['expos'].length;i++){
      expos.add(TextEditingController(text: item['expos'][i]['expo']));
      arr.add(TextFormField(
          controller: expos[i]
      ));
    }
    return arr;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(),
            body: StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('caretakeId',
                  isEqualTo: AuthRepository.instance().user?.uid)
                  .snapshots()
                  .map((value) => value.docs),
              builder: (BuildContext context,
                  AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                // ...
                if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot> data = snapshot.data!;
                  return SingleChildScrollView(child:Column(children: tiles(context,  data)),

                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.person_add),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("caretakers")
                    .doc(AuthRepository.instance().user?.uid)
                    .set({'time': FieldValue.serverTimestamp()},
                    SetOptions(merge: true));
              },
            ),
            drawer: Builder(
              builder: (context) => Drawer(
                child: ListView(padding: EdgeInsets.zero, children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('CareTaker'),
                  ),
                  ListTile(
                    title: const Text("התנתק"),
                    onTap: () {
                      Future<void> _signOut() async {
                        await FirebaseAuth.instance.signOut();
                      }

                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => Login()));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));

                      ///Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text("מפה!"),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => MapPage()));

                      ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                      ///Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    selected: createPass,
                    title: const Text("סיסמא"),
                    onTap: () {
                      setState(() {
                        createPass = !createPass;
                      });
                    },
                  ),
                  if (createPass)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(color: Colors.green, width: 10,height: 10,),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ], //
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "PASSWORD...",
                              ),
                            )),
                        Container(
                            height: MediaQuery.of(context).size.width * 0.2,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: TextButton(
                              onPressed: () {
                                final String pass = password.text.trim();
                                FirebaseFirestore.instance
                                    .collection("caretakers")
                                    .doc(AuthRepository.instance().user?.uid)
                                    .set({'usedId': pass},
                                    SetOptions(merge: true));
                                setState(() {
                                  createPass = !createPass;
                                });
                              },
                              child: Icon(Icons.view_in_ar),
                            )),
                      ],
                    )
                ]),
              ),
            )));
  }
}

