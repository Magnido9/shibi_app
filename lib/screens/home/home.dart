library home;
import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Avatar/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import '../../services/auth_services.dart';


class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  Future<AvatarData>? _adata;
  Future<String>? _name;


  @override
  void initState() {
    super.initState();
    _adata = AvatarData.load();
    _name =  _getname();
  }

  Future<String> _getname() async{
    return (await FirebaseFirestore.instance.collection("users").doc(AuthRepository.instance().user?.uid).get())['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: null),
        body: const Center(
          child: Text('My Page!'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                  decoration: BoxDecoration(
                  color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                  FutureBuilder<String>(
                    future: _name,
                    builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
            // ...
                        if (snapshot.connectionState == ConnectionState.done) {
                          String data = snapshot.data ?? '';
                          return Text('Hello $data');
                        }
                        return CircularProgressIndicator();
                      },
                  ),
                  FutureBuilder<AvatarData>(
                        future: _adata,
                        builder:
                            (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
                          // ...
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AvatarStack(data:( snapshot.data ?? AvatarData(body: AvatarData.body_default)) );

                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  )
                  ),
                  ListTile(
                  title: const Text("עצב דמות"),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Avatar()));
                    ///Navigator.push(context, MaterialPageRoute(builder: (context) => Avatar()));
                    ///Navigator.pop(context);
                  },
                  ),
                  ListTile(
                    title: const Text("התנתק"),
                    onTap: () {
                      Future<void> _signOut() async {
                        await FirebaseAuth.instance.signOut();
                      }
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                      ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                      ///Navigator.pop(context);
                      },
                  ),
                  ListTile(
                    title: const Text("מפה!"),
                    onTap: () {
                      Future<void> _signOut() async {
                        await FirebaseAuth.instance.signOut();
                      }
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => MapPage()));
                      ///Navigator.push(context, MaterialPageRoute(builder: (context) => Login(isInit: false)));
                      ///Navigator.pop(context);
                    },
                  ),

                    ]
                  ),
                ),

            );

      }
}



