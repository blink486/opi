//2021-12-26 KEEP for v1

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/screens/addsrvquestions.dart';
import 'package:moodclicks/screens/scrollcards.dart';
import 'package:moodclicks/services/createinitsurvey.dart';

import 'addsrvimages.dart';

class AddQuestions extends StatefulWidget {
  final String
      srvCreator; //TODO: Maybe not necessary to pass as once logged in your session stays until logg out.
  const AddQuestions({Key? key, required this.srvCreator}) : super(key: key);

  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  // late Survey surveyLocal;
  // late List<Survey> srv;
  final loggedInUser = FirebaseAuth.instance.currentUser!.uid.toString();

  TextEditingController srvName = new TextEditingController();
  TextEditingController srvDescription = new TextEditingController();
  // TextEditingController id = new TextEditingController();
  // TextEditingController userId = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String emojiHeart = '\u2764';
    // Emoji smile = Emoji.fromJson(json)   ('Grinning Face');

    late String createdDocId;

    return Scaffold(
      appBar: AppBar(
        title: Text("3.0 addquestionss .dt " /*+ widget.searchstr*/),
        // actions: <Widget>[HomeNav()],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(14.0),
            //   child: TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               // builder: (BuildContext context) => PageViewDemo())); //Go Sample Cards
            //               builder: (BuildContext context) => SignUp()));
            //       // print('${smile.name}');
            //     },
            //     child: Text(
            //       emojiHeart +
            //           "Click To Sign up and Create your first Survey USERID : " +
            //           widget.srvCreator,
            //       style: TextStyle(fontSize: 14),
            //     ),
            //     // ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Account Created User ID:' +
                  widget.srvCreator +
                  '  Enter your first Quer Questions'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: srvName,
                decoration: InputDecoration(hintText: "Enter Survey Name:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: srvDescription,
                decoration:
                    InputDecoration(hintText: "Enter Survey Description"),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: () async {
                // Generate a reference to a new location and add some data using push()
                var newPostRef = Navigator.push;
                String questionsAdded = "N";
// Get the unique ID generated by push() by accessing its key
// var postID = newPostRef.toString();
// DEV NOTES: CREATE NEW Survey Class Object - NOt necessarily required for curent program,
// but useful to create this way in furture in final version
                final mySrv = Survey(
                    name: srvName.text, description: srvDescription.text);
                // AddQuestions();
                // DocumentReference ref =
                //     FirebaseFirestore.instance.collection("test").doc();
                // String myDocId = ref.id;
                Map<String, dynamic> data = {
                  "f00user": loggedInUser,
                  "f00docid": "myDocId",
                  // "f01name": srvName.text,
                  // "f02description": srvDescription.text
                  // "f03srvId": newPostRef.toString()
                  "f01name": mySrv.name,
                  "f02description": mySrv.description,
                  "f03questionsexist": questionsAdded
                };

                // FirebaseFirestore.instance
                //     .collection("test")
                //     .add(data)
                //     .then((value) {
                //   // ignore: unnecessary_statements
                //   (print(value.id));
                //   createdDocId = value.id;
                // });

                DocumentReference docRef = await FirebaseFirestore.instance
                    .collection('questions')
                    .add(data);
                print(docRef.id);

                // var firebaseUser =  FirebaseAuth.instance.currentUser;

                FirebaseFirestore.instance
                    .collection("questions")
                    .doc(docRef.id)
                    .set({
                  "f00docid": docRef.id,
                }, SetOptions(merge: true)).then((_) {
                  print("success!");
                });

                print(" ^^ NEW DOC ADDED:  ");
                // print(x);
                print(srvDescription.toString());
                print('\u{2764}');
                print(String.fromCharCode(0xdd25));
                print(String.fromCharCode(0xdd25));
                print(
                  mySrv.description,
                );
                // Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (BuildContext context) => Logonlanding(
                //               searchstr: user.user!.uid.toString(),
                //               // searchstr: searchstring.text,
                //             ),
                //           ),
                //         );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (BuildContext context) => PageViewDemo())); //Go Sample Cards
                    builder: (BuildContext context) => AddSrvImages(
                        description: srvDescription.text,
                        name: srvName.text,
                        surveyId: docRef.id

                        // surveyId: createdDocId.toString()
                        ),
                  ),
                );
              },
              child: Text(emojiHeart +
                  " Submit New Survey and ADD Quick Survey Emojis "),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddSrvQuestions(
                        //LINKS to FULL SURVEY MAIN PAGE - Keep as Alternate Route?DELETE as Already have copy of programs
                        description: 'User',
                        name: 'Another',
                      ),
                    ),
                  ); //Go Sample Cards
                  // builder: (BuildContext context) => SignUp()));
                  // print('${smile.name}');
                },
                child: Text(
                  emojiHeart + " Add Questions to Long Survey",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(14.0),
            //   child: TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) =>
            //                   PageViewDemo())); //Go Sample Cards
            //       // builder: (BuildContext context) => SignUp()));
            //       // print('${smile.name}');
            //     },
            //     child: Text(
            //       emojiHeart + " View Sample Survey (Static):",
            //       style: TextStyle(fontSize: 14),
            //     ),
            //     // ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          // builder: (BuildContext context) => PageViewDemo())); //Go Sample Cards
                          builder: (BuildContext context) => AddSrvQuestions(
                                description: 'User',
                                name: 'Another',
                              )));
                  // print('${smile.name}');
                },
                child: Text(
                  emojiHeart + " Visit Add Question Without Create New Survey",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   void AddQuestions() {
//     Survey _newsurvey =         Survey(name: srvName.text, description: srvDescription.text);
//     print(srvDescription);
//   }
}
