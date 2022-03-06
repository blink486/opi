import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoteCheck {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

// // My Addition 12/02/2020
//   User? get currentUser => _auth.currentUser;
//   Future<User?> getOrCreateUser() async {
//     if (currentUser == null) {
//       await _auth.signInAnonymously();
//       print("Printing Cuser :" + currentUser!.uid.toString());
//     }
//     return currentUser;
//   }

  // Future<Opinion?> getDocs(String docId) async {
  //   Opinion opi = (await FirebaseFirestore.instance
  //       .collection("opinion")
  //       .doc(docId)
  //       .get()) as Opinion;
  //   return opi;
  // }

  // Future<DocumentSnapshot> getBallotDetails(String docId , String ip) async {
  //   DocumentSnapshot opi =
  //       await FirebaseFirestore
  //       .instance
  //       .collection("opinion")
  //       .where(ip== ip)
  //       .doc(docId).get();
  //   return opi;
  // }

}
