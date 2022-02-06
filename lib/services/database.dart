import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodclicks/model/brew.dart';

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
//get brews stream

  Stream<List<Brew>?> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

// DELETE Example:
  // Future<Sample> getUser(String id) async {
  //   return Sample.fromSnapshot(
  //       await usersCollection.doc('iQkfaDnPAag5nK22Z2QH').get());
  // }

}
