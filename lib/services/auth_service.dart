import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodclicks/model/account.dart';
import 'package:moodclicks/services/database.dart';

// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   User? get currentUser => _firebaseAuth.currentUser;

//   Future<User?> getOrCreateUser() async {
//     if (currentUser == null) {
//       await _firebaseAuth.signInAnonymously();
//       print("Printing Cuser :" + currentUser!.uid.toString());
//     }
//     return currentUser;
//   }
// }

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// My Addition 12/02/2020
  User? get currentUser => _auth.currentUser;
  Future<User?> getOrCreateUser() async {
    if (currentUser == null) {
      await _auth.signInAnonymously();
      print("Printing Cuser :" + currentUser!.uid.toString());
    }
    return currentUser;
  }

//END

//create user obj based on FirebaseUser

  Account? _userFromFirebaseUser(User? user) {
    if (user == null) {
      return null;
    } else {
      return Account.userid(uid: user.uid, userName: "exampleUserName");
    }
  }

  // Account? _userFromFirebaseUser2(User? user) {
  //   if (user == null) {
  //     return null;
  //   } else {
  //     return Account(uid: user.uid);
  //   }
  // }
//auth change user stream

  Stream<Account?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

// Sign in anon

  Future signInAnon() async {
    try {
      //AuthResult now  UserCredential
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // print(user);
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(
        e.toString(),
      );
      return null;
    }
  }
// Sign in email & p/w

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with email & password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new mwmber', 100);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with google

// register with facebook

// Sign out
  Future signOut() async {
    try {
      print('HEREd');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
