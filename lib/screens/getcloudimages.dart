//getcloudimages.dart

// #############    KEEP for REF ###############

// late Opinion survey;
// List<Set> polloptions = [];
// List<Row> optionrow = [];

// List<Set> polloptionsx = [];

// int origVote = survey.sets[0].votes;

// // TODO: CREATE FOR LOOP and SUM the Total Votes.

// int origTotalVotes = survey.sets[0].votes;

// Future<void> readNestedData() async {
//   Opinion opinion;
//   // var bd =
//   await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("stJJiVVO821Z2U9NVv3I")
//       .get()
//       .then((docSnapshot) => {
//             opinion =
//                 Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//             opinion.sets.forEach((set) {
//               Set setInst = set as Set;
//               // log("Reps :" + setInst.reps.toString());
//               polloptions.add(set);
//               polloptionsx.add(setInst);
//             }),
//             print("Print TOP level Data:"),
//             print(opinion.description),
//             print("Print Lower level Data from ARRAY of  MAPS:"),
//             print(opinion.sets[0].votes),
//             survey = opinion,
//           });
// }

// void _printSets() {
//   for (int i = 0; i < polloptions.length; i++) {
//     // print(polloptions[i].votes);
//     print(polloptions[i].downloadUrl);
//     print(polloptions[i].votes);
//   }
// }

// #############     END ###############

// import 'package:cloud_firestore/cloud_firestore.dart';

// class opinion {
//   final String name;
//   final String muscle;
//   List<dynamic> sets = [
//     // {"reps": 10, "weight": 40},
//     // {"reps": 10, "weight": 40},
//     // {"reps": 10, "weight": 40}
//   ];

//   opinion(this.name, this.muscle);

//   Map<String, dynamic> toMap() =>
//       {"name": this.name, "muscle": this.muscle, "sets": this.sets};

// //   Food.fromMap(Map<String, dynamic> data) {
// //     id = data['id'];
// //     name = data['name'];
// //     category = data['category'];
// //     image = data['image'];
// //     subIngredients = data['subIngredients'];
// //     createdAt = data['createdAt'];
// //     updatedAt = data['updatedAt'];
// //   }

// }

// Future<void> SaveNestedData() async {
//   opinion opinion = opinion("Tricep Extension", "Triceps");
//   await FirebaseFirestore.instance
//       .collection("opinions")
//       .doc()
//       .set(opinion.toMap());
// }

// class opinion {
//   final String f01surveyname;
//   final String f02surveydescription;
//   List<dynamic> sets = [];

//   opinion(this.f01surveyname, this.f02surveydescription);

//   Map<String, dynamic> toMap() => {"f01surveyname": this.f01surveyname, "f02surveydescription": this.f02surveydescription, "sets": firestoreSets()};

//   List<Map<String,dynamic>> firestoreSets() {
//     List<Map<String,dynamic>> convertedSets = [];
//     this.sets.forEach((set) {
//       Set thisSet = set as Set;
//       convertedSets.add(thisSet.toMap();
//     });
//     return convertedSets;
//   }

//   opinion.fromMap(Map<dynamic, dynamic> map, this.f01surveyname, this.f02surveydescription)
//       : f01surveyname = map['f01surveyname'],
//         f02surveydescription = map['f02surveydescription'],
//         sets = map['sets'].map((set) {
//           return Set.fromMap(set);
//         }).toList();
// }

// class Food {
//   String id;
//   String name;
//   String category;
//   String image;
//   List subIngredients = [];
//   Timestamp createdAt;
//   Timestamp updatedAt;

//   Food();

//   Food.fromMap(Map<String, dynamic> data) {
//     id = data['id'];
//     name = data['name'];
//     category = data['category'];
//     image = data['image'];
//     subIngredients = data['subIngredients'];
//     createdAt = data['createdAt'];
//     updatedAt = data['updatedAt'];
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'image': image,
//       'subIngredients': subIngredients,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt
//     };
//   }
// }

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/screens/createsurvey.dart';
import 'package:moodclicks/services/createinitsurvey.dart';

class ViewSurvey extends StatefulWidget {
  const ViewSurvey({Key? key}) : super(key: key);

// ENTER THE DATA HERE
// late Future data;

  @override
  _ViewSurveyState createState() => _ViewSurveyState();
}

class _ViewSurveyState extends State<ViewSurvey> {
  late Future data;

  late Future<Opinion> opinc;

  late Future<Opinion> opix;
  late Future<Opinion> opih;

  late Future<Opinion> opik;
  late Future<Opinion> opid;

  final _firestore = FirebaseFirestore.instance;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDoc;
  late Future<QuerySnapshot<Map<String, dynamic>>> _futureSnapshot;

  // @override
  // void initState() {
  //   super.initState();
  //   _futureDoc = _getDoc();
  //   _futureSnapshot = _getDocs();
  // }

  // late Future<dynamic> kb;

  @override
  void initState() {
    super.initState();
    data = readNestedData();
    polloptions.clear();
    var kb = importData();
    // print("Initstare result");

    // print(kb.then((value) {
    //   print(value.toString());
    // }));
    // print("Boj Opinio below:");
    // createOpObj();
    // Future<Opinion?> op = createOpObj();
    // print(op.toString());
    //  opih = createOpObj().then((value) => null);
    // data = Opi().createOpObjCl();
    print("Boj Opinio below:");
    // Opi().createOpObjCl();
    // print("Boj Opinio below:");
    // print(data.toString());
    opik = OService.getOpi();
    opik.then((value) {
      print(value.name);
      print(value.description);
      _assign(value);
      Opinion x = value;
      print("X value:");
      print(x.description);
      oplist(value);
    });

    // print(opik.then((value) => value.sets));
  }

  late int voteTally = survey.sets[0].votes;
  late int listStatus = survey.sets.length;

  void _castVote() {
    setState(() {
      voteTally += 1;
      voteTally = voteTally % (2);

      print(" ONe Vote  adde d");
    });
  }

  void printfut() {
    opik.then((value) {
      Opinion x;
      x = value;
      print("X value:");
      // print(x.sets[0].downloadUrl);
      _printSurveyFromFut(x);
    });
  }

  List<Opinion> opList = [];

  List<Opinion> oplist(Opinion o) {
    List<Opinion> opiList = [];

    opiList.add(o);
    opList = opiList;
    return opiList;
  }

  @override
  Widget build(BuildContext context) {
    Future<Opinion> rts;
    rts = opik;

    return Scaffold(
      appBar: AppBar(
        title: Text("x. getcloudimages.dt"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text("Heres your Survey Data:"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("Get Survey From Firebase"),
                onPressed: () => readNestedData(),
              ),
            ),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: 40,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(survey.name),
                    Text(survey.sets[1].votes.toString()),
                    Text(voteTally.toString()),
                    // Text(survey.description),
                    ElevatedButton.icon(
                        icon: Icon(Icons.info),
                        label: Text("vote"),
                        onPressed: () => {
                              readNestedData(),
                              // voteTally = voteTally += 1 ,

                              _castVote(),
                              print(voteTally),
                              print('Sets Length:'),
                            }),
                    ElevatedButton.icon(
                        icon: Icon(Icons.info),
                        label: Text("Sets"),
                        onPressed: () => {
                              // print(polloptions[0].downloadUrl),
                              // print(polloptions.length.toString()),
                              // print(polloptions[0].downloadUrl),
                              _printSets()
                            }),
                    ElevatedButton.icon(
                        icon: Icon(Icons.info),
                        label: Text("poll"),
                        onPressed: () => {
                              // print(polloptions[0].downloadUrl),
                              // print(polloptions.length.toString()),
                              // print(polloptions[0].downloadUrl),
                              // _printPoll(),

                              // _clearPoll(),
                              // _loopSets(),

                              // print(survey.sets[0].votes),

                              // print(survey.sets.length),
                              _printSurvey(),
                              print("BREAK"),
                              print(opList[0].sets[1].votes),
                            }),
                  ],
                ),
              ),
            ),
            Center(
              child: Text(" TExt Widget name"),
            ),
            ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("Print Fut Obj"),
                onPressed: () => {
                      printfut(),
                    }),

            // Single Row Item from List ->
            // Container(
            //   height: 200,
            //   child: ListView(
            //     padding: EdgeInsets.all(16),
            //     children: [buildQlist(2)],
            //   ),
            // ),
            // Container(
            //   height: 200,
            //   child: lviewB(),
            // ),
            // Center(
            //   child: Text("Hello ${voteTally}"),
            // ),
            Container(
              height: 200,
              child: listStatus > 0
                  ? lviewB()
                  : Text("Error : Empty List, No Data Received"),
            ),

            Center(
              child: Text("${opik.toString()}"),
            ),
            // FutureBuilder(
            //   future: buildQlistC(1),
            //   builder: (BuildContext context, AsyncSnapshot<Row> text) {
            //     return new Row()(text.data);
            //   },
            // ),
            // FutureBuilder<dynamic>(
            //   future: importData(),
            //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //     if (snapshot.hasData) {
            //       // opix = snapshot as Future<Opinion>;
            //       // return Text('Number Of completed : ${snapshot.data}');
            //       // return Text('Number Of completed : XXX ');
            //       print(snapshot.toString());
            //       return Text("${snapshot.toString()}");
            //     }
            //     return Container(child: Text('Hello no data'));
            //   },
            // ),
            // FutureBuilder<dynamic>(
            //   future: Opi().createOpObjCl(),
            //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //     if (snapshot.hasData) {
            //       // opix = snapshot as Future<Opinion>;
            //       // return Text('Number Of completed : ${snapshot.data}');
            //       // return Text('Number Of completed : XXX ');
            //       print(snapshot.toString());
            //       return Text("${snapshot.toString()}");
            //     }
            //     return Container(child: Text('Hello no data'));
            //   },
            // ),
            // FutureBuilder<Opinion>(
            //   future: opik,
            //   builder: (context, DocumentSnapshot) {
            //     if (DocumentSnapshot.hasData) {
            //       // Text( opik. );        // For root objects
            //       Text(DocumentSnapshot.data.toString()); // For child objects
            //     } else if (DocumentSnapshot.hasError) {
            //       return Center(
            //           child: Text(
            //               "Error fetching data ${DocumentSnapshot.error} "));
            //     }
            //     return CircularProgressIndicator();
            //   },
            // )
          ],
        ),
      ),
    );
  }

  // Widget buildCol() {
  //   List<Row> colq = [];

  //   for (int i = 0; i < survey.sets.length; i++)
  //   colq.add(buildQlist(1));
  //    return colq;
  // }

  Widget lviewB() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: survey.sets.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          // color: Colors.amber[colorCodes[index]],
          child: Center(child: buildQlist(index)),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildQlist(i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Choice: ${i + 1} "),
        Container(
          height: 120,
          width: 80,
          child: Image.network(survey.sets[i].downloadUrl),
        ),
        Container(
          height: 50,
          width: 50,
          child: Text(
            "Votes: ${survey.sets[i].votes.toString()}",
            // textAlign: TextAlign.center,
          ),
        ),
        InkWell(
            onTap: () {
              print("Container ${i} clicked");
              _castVote();
            },
            child: new Container(
              height: 50,
              width: 50,
              child: Text(
                "Votes: ${survey.sets[i].votes.toString()}",
                // textAlign: TextAlign.center,
              ),
            ))
      ],
    );
  }

// ADD NEW  FUTURE METHOD Version:

  // Future<Widget> lviewC() async => opik.then((value) {
  //       return ListView.separated(
  //         padding: const EdgeInsets.all(8),
  //         itemCount: value.sets.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Container(
  //             height: 50,
  //             // color: Colors.amber[colorCodes[index]],
  //             // child: Center(child: await buildQlistC(index).whenComplete(() {buildQlistC(index);})),
  //             child: Center(child: FutureBuilder(builder: builder))
  //           );
  //         },
  //         separatorBuilder: (BuildContext context, int index) =>
  //             const Divider(),
  //       );
  //     });

  Future<Widget> buildQlistC(i) async => opik.then((value) {
        // Opinion x;
        // x = value;
        // print("X value:");
        // print(x.sets[0].downloadUrl);
        // _printSurveyFromFut(x);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Choice: ${i + 1} "),
            Container(
              height: 120,
              width: 80,
              child: Image.network(value.sets[i].downloadUrl),
              // child: Image.network(v.sets[0].downloadUrl),
            ),
            Container(
              height: 50,
              width: 50,
              child: Text(
                "Votes: ${value.sets[i].votes.toString()}",
                // textAlign: TextAlign.center,
              ),
            ),
            InkWell(
                onTap: () {
                  print("Container ${i} clicked");
                  _castVote();
                },
                child: new Container(
                  height: 50,
                  width: 50,
                  child: Text(
                    "Votes: ${value.sets[i].votes.toString()}",
                    // textAlign: TextAlign.center,
                  ),
                ))
          ],
        );
      });
}

Future<Column> buildQlistZCol(List<Opinion> opList) async {
  for (int i = 0; i < opList[0].sets.length; i++) buildQlistZ(i);

  return Column();
}

Widget buildQlistZ(i) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text("Choice: ${i + 1} "),
      Container(
        height: 120,
        width: 80,
        child: Image.network(survey.sets[i].downloadUrl),
      ),
      Container(
        height: 50,
        width: 50,
        child: Text(
          "Votes: ${survey.sets[i].votes.toString()}",
          // textAlign: TextAlign.center,
        ),
      ),
      InkWell(
          onTap: () {
            print("Container ${i} clicked");
          },
          child: new Container(
            height: 50,
            width: 50,
            child: Text(
              "Votes: ${survey.sets[i].votes.toString()}",
              // textAlign: TextAlign.center,
            ),
          ))
    ],
  );
}

void _assign(Opinion o) {
  var rts = o;
  print("rts VALUE: ");
  print(o.name);
}

late Opinion survey;
List<Set> polloptions = [];
List<Row> optionrow = [];

List<Set> polloptionsx = [];

int origVote = survey.sets[0].votes;

// TODO: CREATE FOR LOOP and SUM the Total Votes.

int origTotalVotes = survey.sets[0].votes;

Future<void> readNestedData() async {
  Opinion opinion;
  // var bd =
  await FirebaseFirestore.instance
      .collection("opinion")
      .doc("2zHmv5oqetOQixD1OJBw")
      .get()
      .then((docSnapshot) => {
            opinion =
                Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
            opinion.sets.forEach((set) {
              Set setInst = set as Set;
              // log("Reps :" + setInst.reps.toString());
              polloptions.add(set);
              polloptionsx.add(setInst);
            }),
            print("Print TOP level Data:"),
            print(opinion.description),
            print("Print Lower level Data from ARRAY of  MAPS:"),
            print(opinion.sets[0].votes),
            survey = opinion,
          });
}

Future<dynamic> importData() async {
  var surveyData = await FirebaseFirestore.instance
      .collection("opinion")
      .doc("2zHmv5oqetOQixD1OJBw")
      .get();
  try {
    if (surveyData.exists) ;
    {
      return surveyData;
    }
  } catch (e) {
    return Text(e.toString());
  }
}

Future<Opinion?> createOpObj() async {
  Opinion op = Opinion('heldo', 'dfdfe');
  Opinion opiz;
  var opi = await importData().then((value) {
    opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
    opiz.sets.forEach((set) {
      Set setInst = set as Set;
      // // log("Reps :" + setInst.reps.toString());
      // polloptions.add(set);
      // polloptionsx.add(setInst);
    });
    print(opiz.name);

    return opiz;
  });
  // print(opi.toString());
  // return op;
}

Future<Opinion> createOpObjFut() async {
  Opinion op = Opinion('heldo', 'dfdfe');
  var opi = await importData();
  print(opi.toString());
  return op;
}

// Future<Map<String, dynamic>> getDoc() async {
//   Map opinion;
//   var docSnap = await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("2zHmv5oqetOQixD1OJBw")
//       .get();
//       // .then((docSnapshot) => {
//       //       opinion =
//       //           Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//       //       opinion.sets.forEach((set) {
//       //         Set setInst = set as Set;
//       //         // log("Reps :" + setInst.reps.toString());
//       //         polloptions.add(set);
//       //         polloptionsx.add(setInst);
//       //       }),
//       //       print("Print TOP level Data:"),
//       //       print(opinion.description),
//       //       print("Print Lower level Data from ARRAY of  MAPS:"),
//       //       print(opinion.sets[0].votes),

//       return Map(docSnap) ;

// }

// class FirestoreService {

//    Future getPostsOnceOff() async {
//     try {
//       var postDocuments = await await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("2zHmv5oqetOQixD1OJBw")
//       .get();
//       if (postDocuments.data()!.isNotEmpty) {
//         return postDocuments.then((document))
//             .map((snapshot) => Post.fromMap(snapshot.data))
//             .where((mappedItem) => mappedItem.title != null)
//             .toList();
//       }
//     } catch (e) {
//       if (e is PlatformException) {
//         return e.message;
//       }
//       return e.toString();
//     }
//   }
// }

//       .then((docSnapshot) => {
//             opinion =
//                 Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//             opinion.sets.forEach((set) {
//               Set setInst = set as Set;
//               // log("Reps :" + setInst.reps.toString());
//               polloptions.add(set);
//               polloptionsx.add(setInst);
//             }),
//             print("Print TOP level Data:"),
//             print(opinion.description),
//             print("Print Lower level Data from ARRAY of  MAPS:"),
//             print(opinion.sets[0].votes),
//             survey = opinion,
//           });
// }

class GetUserName extends StatelessWidget {
  // final String documentId;

  // GetUserName(this.documentId);

  late Opinion opinion;
  @override
  Widget build(BuildContext context) {
    CollectionReference opinion_src =
        FirebaseFirestore.instance.collection('opinion');

    return FutureBuilder<DocumentSnapshot>(
      future: opinion_src.doc('2zHmv5oqetOQixD1OJBw').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          opinion_src.doc('2zHmv5oqetOQixD1OJBw').get().then((docSnapshot) => {
                opinion =
                    Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
                opinion.sets.forEach((set) {
                  Set setInst = set as Set;
                  // log("Reps :" + setInst.reps.toString());
                  polloptions.add(set);
                  polloptionsx.add(setInst);
                }),
                print("Print TOP level Data:"),
                print(opinion.description),
                print("Print Lower level Data from ARRAY of  MAPS:"),
                print(opinion.sets[0].votes),
                survey = opinion,
              });
          // return docSnapshot;
        }

        return Text("loading");
      },
    );
  }
}

void _printSets() {
  for (int i = 0; i < polloptions.length; i++) {
    // print(polloptions[i].votes);
    print(polloptions[i].downloadUrl);
    print(polloptions[i].votes);
  }
}

void _printPoll() {
  for (int i = 0; i < polloptionsx.length; i++) {
    // print(polloptions[i].votes);
    print(polloptionsx[i].downloadUrl);
    print(polloptionsx[i].votes);
    print("Helloo Space");
    print(polloptionsx.length);
  }
}

void _loopSets() {
  print(polloptionsx[1].downloadUrl);
  var lss = polloptionsx.map((set) {
    print(set.description);
    if (set.votes == 22) {
      print('upating ${set.votes}...');
      // car.name = "Tesla";
    }
    return set;
  });
}

void _clearPoll() {
  polloptionsx.clear();
}

void _printSurvey() {
  for (int i = 0; i < survey.sets.length; i++) {
    print(survey.sets[i].downloadUrl);
    print(survey.sets[i].votes);
  }
}

// List<Row> quws = [];

// Row  qStackBuild() {
//   for (int i = 0; i < survey.sets.length; i++) {
//     String dload = survey.sets[i].downloadUrl;
//     print(dload);
//     Row(
//       children: const <Widget>[
//         Expanded(child: Text('d')),
//         Expanded(
//           child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
//         ),
//         Expanded(
//           child: FittedBox(
//             fit: BoxFit.contain, // otherwise the logo will be tiny
//             child: FlutterLogo(),
//           ),
//         ),
//       ],
//     );
//   }
// }

//   //loop over mapped object collection
//   lss.forEach((car) => print("${car.name} is electric? ${car.isElectric}"));
// }

// Future<void> loopNestedSetsData() async {
//   Opinion opinion;
//   // var bd =
//   await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("stJJiVVO821Z2U9NVv3I")
//       .get()
//       .then((docSnapshot) => {
//             opinion =
//                 Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//             opinion.sets.forEach((set) {
//               Set setInst = set as Set;
//               // log("Reps :" + setInst.reps.toString());
//               polloptions.add(set);
//             }),
//             print("Print TOP level Data:"),
//             print(opinion.description),
//             print("Print Lower level Data from ARRAY of  MAPS:"),
//             print(opinion.sets[0].votes),
//             survey = opinion,
//           });
// }
class Opi {
  Future<Opinion?> createOpObjCl() async {
    // late Opinion op ;
    late Opinion opiz;
    var opi = await importData().then((value) {
      opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
      opiz.sets.forEach((set) {
        Set setInst = set as Set;
        // // log("Reps :" + setInst.reps.toString());
        // polloptions.add(set);
        // polloptionsx.add(setInst);
      });
      print("Obj Return");
      // print(opiz.name);

      return opiz;
    });
    // print(opi.toString());
    print("Other Return");
    // return opiz;
  }
}

// class OpinServices {
//   static Future<Opinion> getCoinsb() async {
//     late Opinion smpcoinb;
//     var val = await FirebaseFirestore.instance
//         .collection("opinion")
//         .doc('2zHmv5oqetOQixD1OJBw');

//     var documentsm = val.get().then((value) => null);
//     if (documentsm.hasData) {
//       try {
//         print("Active ${documentsm.length}");
//         return documentsm.Json((document) {
//           // Sample bookingList =

//           smpcoinb = Opinion.fromJson(Map<String, dynamic>.from(documentsm));

//           print(smpcoinb);
//           print(document.documentID);

//           return smpcoinb;
//         }).toList();
//       } catch (e) {
//         print("Exception $e");
//         print(val.toString());
//         return smpcoinb;
//       }
//     }
//     return smpcoinb;
//   }
// }

// Future<dynamic> importData() async {
//   var surveyData = await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("2zHmv5oqetOQixD1OJBw")
//       .get();
//   try {
//     if (surveyData.exists) ;
//     {
//       return surveyData;
//     }
//   } catch (e) {
//     return Text(e.toString());
//   }
// }

// class ProductService {
//   static Future<Opinion> getProducts() async {
//     var response = await http.get(Uri.parse(
//         "https://raw.githubusercontent.com/ankitjamuar/flutter_json_to_UI/master/lib/services/products.json"));
//     return response.statusCode == 200
//         ? Coins.fromJson(json.decode(response.body)[0])
//         : Exception("Failed to get data");
//   }
// }

class OService {
  static Future<Opinion> getOpi() async {
    late Opinion opiz;
    var response = await importData().then((value) {
      opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
    });

    return opiz;
    //   opiz.sets.forEach((set) {
    //     Set setInst = set as Set;
    // return opiz;
    //     // ? Coins.fromJson(json.decode(response.body)[0])
    //     // : Exception("Failed to get data");
    //   }   return opiz; }  return opiz;}  return opiz;}
  }
}

void _printSurveyFromFut(Opinion opx) {
  for (int i = 0; i < opx.sets.length; i++) {
    print(opx.sets[i].downloadUrl);
    print(opx.sets[i].votes);
  }
}
