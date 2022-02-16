import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodclicks/model/brew.dart';
import 'package:moodclicks/model/user.dart';

class DatabaseService {
  late final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
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
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
