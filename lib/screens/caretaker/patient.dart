library home;

import 'dart:io';
import 'dart:math';
import 'package:application/screens/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_services.dart';
import 'package:flutter/services.dart';

class PatientPage extends StatefulWidget {
  PatientPage({
    required this.pid,
    required this.name,
  });

  final String pid, name;
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<PatientPage> {
  int current = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.name,
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.name),
          ),
          body: StreamBuilder<List<QueryDocumentSnapshot>>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .where('pid', isEqualTo: widget.pid)
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
                        final Map<String, dynamic> item = data[index].data() as Map<String, dynamic>;
                        String docId = data[index].reference.id;
                        return ListTile(
                          title: Text(
                            item['name'],
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {FirebaseFirestore.instance
                                .collection("tasks")
                                .doc(docId).delete();
                            setState(() {

                            });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: data.length),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
