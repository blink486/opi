import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodclicks/model/brew.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/user.dart';

class SurveyDataService {
  late final String? uid;
  late final String? docid;
  SurveyDataService({this.uid, this.docid});
  SurveyDataService.docId(String surveyId);
  //collection reference

  CollectionReference fireCollection() {
    final CollectionReference collectionInstance = FirebaseFirestore.instance
        .collection('opinion')
        .doc(uid)
        .collection('response');
    return collectionInstance;
  }

  DocumentReference responseDocs() {
    return fireCollection().doc(docid);
  }

  // Stream<Ballot> get surveyResponse {
  //   return collectionInstance.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }

// userData from snapshot

  final CollectionReference collectionInstance =
      FirebaseFirestore.instance.collection('opinion');

  Future updateUserData(String sugars, String name, int strength) async {
    return await collectionInstance
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew>? _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name').toString(),
        sugars: doc.get('sugars').toString(),
        strength: doc.get('strength') ?? 0,
      );
    }).toList();
  }

// userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        name: snapshot['name'].toString(),
        sugars: snapshot['sugars'].toString(),
        strength: snapshot['strength']);
  }

//get brews stream

  Stream<List<Brew>?> get brews {
    return collectionInstance.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return collectionInstance.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

// get document ADDEd 20/02/2022

  Future<Opinion?> getDocs(String docId) async {
    Opinion opi = (await FirebaseFirestore.instance
        .collection("opinion")
        .doc(docId)
        .get()) as Opinion;
    return opi;
  }

  Future<DocumentSnapshot> getDocs2(String docId) async {
    DocumentSnapshot opi =
        await FirebaseFirestore.instance.collection("opinion").doc(docId).get();
    return opi;
  }
}
