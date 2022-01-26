// import 'package:firebase_auth/firebase_auth.dart';

// class GetUser {
//   final loggedInUser = FirebaseAuth.instance.currentUser!.uid;

//   final loggedInUserEmail = FirebaseAuth.instance.currentUser!.email;

//   @override
//   String getUserId() {
//     return loggedInUser;
//   }
// }


// class FirestoreApiException implements Exception {
//   final String message;
//   final String? devDetails;
//   final String? prettyDetails;

//   FirestoreApiException({
//     required this.message,
//     this.devDetails,
//     this.prettyDetails,
//   });

//   @override
//   String toString() {
//     return 'FirestoreApiException: $message ${devDetails != null ? '- $devDetails' : ''}';
//   }
// }