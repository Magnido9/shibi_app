library home;
import 'dart:math';
import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController password = TextEditingController(text: Random().nextInt(999999).toString(),);

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
                  print(data);
                  print(AuthRepository.instance().user?.uid);
                  return SizedBox(
                    height: 200.0,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> item = data[index].data();
                          var b=(item['name'] !=null && item['name'] !='');
                          return (b)
                              ?ListTile(
                            title: Text(
                                item['name'],
                              style: TextStyle(color: Colors.black),
                            ),

                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {},
                            ),
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
                          ) ;
                        },
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: data.length),
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

