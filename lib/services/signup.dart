//2021-12-26 KEEP for v1

// import 'package:firebase_conn/screens/register_business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodclicks/model/account.dart';
import 'package:moodclicks/screens/addquestions.dart';

// import 'anothersearch.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final loggedInUser = FirebaseAuth.instance.currentUser!.uid.toString();
  final loggedInUser = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TextEditingController searchController2;

    return
        // SingleChildScrollView(
        //   child:
        Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("2. signup.dt - Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(hintText: "email"),
                ),
                SizedBox(height: 10.09),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(hintText: "password"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.red, // foreground
                  ),
                  onPressed: () async {
                    // Map<String, dynamic> data = {
                    //   "f01email": email.text,
                    //   "f02password": password.text
                    // };
                    // FirebaseFirestore.instance.collection("register").add(data);
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email.text, password: password.text);

                      // ignore: unnecessary_null_comparison
                      if (user != null) {
                        print('Hello uid: ' + user.user!.uid);
                        print(user);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => AddQuestions(
                              // srvCreator: loggedInUser.toString(),
                              srvCreator: user.toString(),
                              // searchstr: user.user!.uid.toString(),
                              // searchstr: searchstring.text,
                            ),
                          ),
                        );
                        // Navigator.pushNamed(context, AddBusDetails); // NEED TO LEARN ABOUT NAMED ROUTES
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("LOGIN"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.red, // foreground
                  ),
                  onPressed: () async {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email.text, password: password.text);
                      // Account(uid: '') acc = Account.userid(uid: loggedInUser!.uid.toLowerCase());

                      // ignore: unnecessary_null_comparison
                      // if (newUser != null) {

                      addNewUserToReg();
                      var k = Account.userid(
                        uid: newUser.user!.uid,
                        // name: 'email.text',
                        password: password.text,
                        email: email.text,
                        userName: email.text,
                        startDate: DateTime.now(),
                      );

                      Account.createAccount(k);
                      // addNewAcctToReg();
                      {
                        print(newUser);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => AddQuestions(
                              //TODO: Maybe Parameter not necessary to pass as once logged in your session stays until log out.
                              srvCreator: newUser.toString(),
                              //  srvCreator: loggedInUser.toString(),
                              // searchstr: searchstring.text,
                            ),
                          ),
                        );
                        // Navigator.pushNamed(context, AddBusDetails); // NEED TO LEARN ABOUT NAMED ROUTES
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("CREATE New User?"),
                ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }

// TODO: Move this to create a new user class
  void addNewUserToReg() {
    Map<String, dynamic> data = {
      "f01email": email.text,
      "f02password": password.text,
      "f03userId": loggedInUser!.uid
    };
    FirebaseFirestore.instance.collection("register").add(data);
  }

  // void addNewAcctToReg() {
  //   Map<String, dynamic> data = {
  //     "f01email": email.text,
  //     "f02password": password.text,
  //     "f03userId": loggedInUser!.uid
  //   };
  //   FirebaseFirestore.instance.collection("Account").add(data);
  // }
}
