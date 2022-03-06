// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:moodclicks/model/classExercise.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('exercises');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: Text(document.get('name')),
              subtitle: Text(document.get('muscle')),
            );
          }).toList(),
        );
      },
    );
  }

  Future<String> ipExistsPrint(String docId) async {
    print(docId);
    bool ft = false;
    var data =
        await FirebaseFirestore.instance.collection("opinion").doc(docId).get();
    String dd = data.data().toString();
    print(data.data()!['votingchoices']['description']);
    print(dd);

    return dd;

    // if(data.data()!["contacts"].contains({"uid": ipAddr, "date": myDate})){
    // if (data.data()!['opinion']['votingchoices'].contains({'votes': '1'})) {
    //   print('Already Voted from this IP Address');
    //   ft = true;
    // } else {
    //   print('non');
    // }
  }

  // String get ipAddr {
  //   // return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  //   CollectionReference ipCheck =
  //       FirebaseFirestore.instance.collection('opinion').  ;

  //     DocumentSnapshot ds =  snapshot.data!.docs.map((DocumentSnapshot document) {
  //           return new ListTile(
  //             title: Text(document.get('name')),
  //             subtitle: Text(document.get('muscle')),
  //           );
  //         }).toList(),
  //       );
  // }

  Future queryData(String queryString) {
    return FirebaseFirestore.instance
        .collection('opinion')
        .where('f06service_radius', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  Future<bool> ipExists(String docId, String ipAddr) async {
    bool ft = false;
    var data =
        await FirebaseFirestore.instance.collection("opinion").doc(docId).get();

    // if(data.data()!["contacts"].contains({"uid": ipAddr, "date": myDate})){
    if (data.data()!['opinion']['votingchoices'].contains({'votes': '1'})) {
      print('Already Voted from this IP Address');
      ft = true;
      return ft;
    } else {
      ft = false;
      return ft;
    }
  }
}
