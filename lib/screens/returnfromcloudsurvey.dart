import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classsample.dart';
import 'package:moodclicks/model/surveyo.dart';
import 'package:moodclicks/services/coins.dart';
import 'package:moodclicks/services/fectch_coins_service.dart';

class DisplaySurvey extends StatefulWidget {
  const DisplaySurvey({Key? key}) : super(key: key);

  @override
  _DisplaySurveyState createState() => _DisplaySurveyState();
}

// final _db = FirebaseFirestore.instance;

// Stream<List<Coins>> getDocObj() {
//   try {
//     return _db.collection("sample").snapshots.map((notes) {
//       final List<Coins> notesFromFirestore = <Coins>[];
//       for (final DocumentSnapshot<Map<String, dynamic>> doc in notes.docs) {
//         notesFromFirestore.add(Coins.fromDocumentSnapshot(doc: doc));
//       }
//       return notesFromFirestore;
//     });
//   } catch (e) {
//     rethrow;
//   }
// }

class _DisplaySurveyState extends State<DisplaySurvey> {
  // late Future<Coins> coins;

  // @override
  // void initState() {
  //   super.initState();

  //   coins = CoinServices.getCoins();
  //   print("Initialiinsing");
  //   print(coins.toString());
  // }
  List<Coins> _CoinsFromJson(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coins(
        name: doc['name'],
        surveyDesc: doc['surveyDesc'],
      );
    }).toList();
  }

  @override

  //   void initState() {
  //   super.initState();

  //   _CoinsFromJson();  setState(() {});
  //  }
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Survey From Cloud'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "SHOW Json TO and From",
                      style: TextStyle(fontSize: 18, color: Colors.pink),
                    ),
                  ),
                ),
              ),
              // FutureBuilder(
              //     future: coins,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Text("Success future");
              //       } else if (snapshot.hasError) {
              //         return Text("error");
              //       } else {
              //         return CircularProgressIndicator();
              //       }
              //     }),
              // Padding(
              //   padding: const EdgeInsets.all(18.0),
              //   child: Center(
              //     child: Padding(
              //         padding: const EdgeInsets.all(18.0),
              //         child: Text(coins.toString())),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text("Add picture from  Gallery to Firebase"),
                    onPressed: () => FirebaseFireStore.collection('sample')
                        // .where('name', isEqualTo: 'Ivan')
                        .snapshots()
                        .map((qSnap) => {
                              qSnap.docs
                                  .map((doc) => _CoinsFromJson(doc.data()))
                                  .toList(),
                              print(qSnap.data.toString()),
                              // Sample smp =  smp.fromSnapshot(sSnap),
                            }) //(ImageSource.gallery),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Expanded(
                    child: Text(
                        "KEEP: Upload AddObjectToArray to Fire: Attach SETS array to existing"),
                  ),
                  onPressed: () =>
                      _getDocsFromFireList(), //(ImageSource.gallery),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Expanded(
                    child: Text(
                        "KEEP: Upload AddObjectToArray to Fire: Attach SETS array to existing   CHANGE TO LIST STREAM TO GET DATA!!"),
                  ),
                  onPressed: () => _CoinsFromJson, //(ImageSource.gallery),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Sample> sm = [];

  // Stream<List<Sample>> getSomeoneCommentsList({@required String sellerId}) {
  Stream<List<Sample>> getSomeoneCommentsList() {
    return FirebaseFireStore.collection('sample')
        .where('name', isEqualTo: 'Ivan')
        .snapshots()
        .map((qSnap) =>
            qSnap.docs.map((doc) => Sample.fromJson(doc.data())).toList());
  }

  Future<List<Sample>> getSomeoneCommentsList2() async {
    var data = await FirebaseFireStore.collection('sample')
        .where('name', isEqualTo: 'Ivan')
        .snapshots()
        .map((qSnap) => {
              qSnap.docs.map((doc) => Sample.fromJson(doc.data())).toList(),
              print(qSnap.data.toString()),
              // Sample smp =  smp.fromSnapshot(sSnap),
            });

    sm = data;
    return sm;
  }
}

late Sample smp;

// Future<Sample> _loadAStudentAsset() async {
Future<Sample> _getDocsFromFire() async {
  Sample smpnull;
  var val = await FirebaseFireStore.collection("sample")
      .docs('iE5dR2daVHv7BZ8LSvCh')
      .snapshots;
  var documentsm = val.documents;
  if (documentsm.hasData) {
    try {
      print("Active ${documentsm.length}");
      return documentsm.map((document) {
        // Sample bookingList =

        smp = Sample.fromJson(Map<String, dynamic>.from(document.data));

        print(smp);
        print(document.documentID);

        return smp;
      }).toList();
    } catch (e) {
      print("Exception $e");
      return smp;
    }
  }
  return smp;
}

List<Sample> sa = [];

Future<List<Sample>> _getDocsFromFireList() async {
  Sample smpnull;
  var val = await FirebaseFireStore.collection("sample")
      .docs('iE5dR2daVHv7BZ8LSvCh')
      .snapshots;
  var documentsm = val.documents;
  if (documentsm.hasData) {
    try {
      print("Active ${documentsm.length}");
      return documentsm.map((document) {
        // Sample bookingList =

        smp = Sample.fromJson(Map<String, dynamic>.from(document.data));

        print(smp);
        print(document.documentID);
        sa.add(smp);
        return smp;
      }).toList();
    } catch (e) {
      print("Exception $e");
      return sa;
    }
  }
  return sa;
}

// Future uploadListToFire() async {
//   // FirebaseFirestore.instance.collection("questions").doc().update(
//   final _fireStore = FirebaseFirestore.instance;
//   List surveyItem = [];

//   print(widget.name);

//   // for (int j = 0; j < imgMapList.length; j++) print(j);
//   for (int i = 0; i < imgMapList.length; i++)
//     surveyItem.add({
//       "votes": imgMapList.toList()[i]['votes'],
//       "downloadUrl": imgMapList.toList()[i]['downloadUrl'].toString(),
//     });

//   // var snapshot =
//   await _fireStore.collection('questions').doc(widget.surveyId).set({
//     'f01surveyname': widget.name,
//     "f02surveydescription": widget.description,
//     "items": FieldValue.arrayUnion(surveyItem),
//     // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
//   }, SetOptions(merge: true)).then((_) {
//     print("IMAGES added to Survey!!");
//   });
// }

// void getDocObj() async {
//   FirebaseFirestore rootRef = await FirebaseFirestore.instance;
//   CollectionReference applicationsRef = rootRef.collection("sample");
//   DocumentReference applicationIdRef =
//       applicationsRef.doc('iQkfaDnPAag5nK22Z2QH');
//   applicationIdRef.get().then((value) {
//     // DocumentSnapshot ds = applicationIdRef.get();
//     // if (document.exists()) {
//     // List<Map<String, Object>> users = (List<Map<String, Object>>) document.get("users");
//     Coins jake =  Coins.fromJson(Map<String, dynamic> value););
//     print(value.data());
//   });
// }

// List<Coins> employees = [];

// Future<void> buildData(AsyncSnapshot snapshot) async {
//   if (snapshot.data.documents.length == 0) {
//     employees = [];
//   }

//   employees = [];
//   await Future.forEach(snapshot.data.documents, (element) {
//     employees.add(Coins.fromDocumentSnapshot(element, doc: 'xczdcz'));
//   });
// }
