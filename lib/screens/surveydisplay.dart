import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/screens/getcloudimages.dart';

class SurveyDisplay extends StatefulWidget {
  const SurveyDisplay({Key? key}) : super(key: key);

// ENTER THE DATA HERE
// late Future data;

  @override
  _SurveyDisplayState createState() => _SurveyDisplayState();
}

class _SurveyDisplayState extends State<SurveyDisplay> {
  late Future<Opinion> opik;
  // final _firestore = FirebaseFirestore.instance;
  // late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDoc;
  // late Future<QuerySnapshot<Map<String, dynamic>>> _futureSnapshot;

  @override
  void initState() {
    super.initState();
    readNestedData();
    polloptions.clear();
    // var kb = importData();

    print("Boj Opinio below:");

    opik = OService.getOpi();
    opik.then((value) {
      setState(() {
        oplist(value);
        listLength(value);
      });
    });

    // print(opik.then((value) => value.sets));
  }

  // late int voteTally = opList[0].sets[0].votes;
  // late int listStatus = opList[0].sets.length;

  // late int voteTally = survey.sets[0].votes;
  // late int listStatus = survey.sets.length;

  // late int voteTally = 1;
  // late int listStatus = 2;

  // late int voteTally = opList[0].sets[0].votes;

  int voteTally = 0;

  // late int listStatus = opList[0].sets.length;

  int listStatus = 0;

  Future<int> listLength(Opinion list) async {
    print("HELOOx");
    print(list.sets.length);
    return listStatus = list.sets.length;
  }

  void _castVote() {
    setState(() {
      voteTally += 1;
      voteTally = voteTally % (2);

      print("${voteTally} ONe Vote  adde d");
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
    return Scaffold(
      appBar: AppBar(
        title: Text("x. surveydisplay.dt"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text("Heres your Survey Data:"),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton.icon(
            //     icon: Icon(Icons.info),
            //     label: Text("Get Survey From Firebase"),
            //     onPressed: () => readNestedData(),
            //   ),
            // ),
            // SingleChildScrollView(
            //   physics: NeverScrollableScrollPhysics(),
            //   child: Container(
            //     height: 40,
            //     width: 400,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         Text(voteTally.toString()),
            //         ElevatedButton.icon(
            //             icon: Icon(Icons.info),
            //             label: Text("vote"),
            //             onPressed: () => {
            //                   // readNestedData(),
            //                   _castVote(),
            //                   print(voteTally),
            //                   print('Sets Length:'),
            //                 }),
            //         ElevatedButton.icon(
            //             icon: Icon(Icons.info),
            //             label: Text("Sets"),
            //             onPressed: () => {_printSets()}),
            //         ElevatedButton.icon(
            //             icon: Icon(Icons.info),
            //             label: Text("poll"),
            //             onPressed: () => {
            //                   print("BREAK"),
            //                   print(opList[0].sets[1].votes),
            //                 }),
            //       ],
            //     ),
            //   ),
            // ),
            Center(
              child: Text(" TExt Widget name"),
            ),
            ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("Print Fut Obj"),
                onPressed: () => {
                      printfut(),
                    }),
            Container(
              height: 200,
              child: listStatus > 0
                  ? lviewB()
                  : Text("Error : Empty List, No Data Received"),
            ),
            ElevatedButton.icon(
                icon: Icon(Icons.print),
                label: Text("Print Survey"),
                onPressed: () => {
                      printfut(),
                    }),

            // Center(
            //   child: Text("${opik.toString()}"),
            // ),

            // Container(
            //   height: 200,
            //   child: listStatus > 0
            //       ? lviewB()
            //       : Text("Error : Empty List, No Data Received"),
            // ),
          ],
        ),
      ),
    );
  }

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

  late Opinion survey;

  Future<Widget> buildQlistC(i) async => opik.then((value) {
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
}

// void _assign(Opinion o) {
//   var rts = o;
//   print("rts VALUE: ");
//   print(o.name);
// }

List<Set> polloptions = [];
// List<Row> optionrow = [];

List<Set> polloptionsx = [];

// TODO: CREATE FOR LOOP and SUM the Total Votes.

// int origTotalVotes = survey.sets[0].votes;

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
                  // polloptions.add(set);
                  // polloptionsx.add(setInst);
                }),
                print("Print TOP level Data:"),
                print(opinion.description),
                print("Print Lower level Data from ARRAY of  MAPS:"),
                print(opinion.sets[0].votes),
                // survey = opinion,
              });
          // return docSnapshot;
        }

        return Text("loading");
      },
    );
  }
}

void _printSetsSurvey() {
  print(survey.name);
  print(survey.description);
  for (int i = 0; i < survey.sets.length; i++) {
    // print(polloptions[i].votes);
    print(survey.sets[i].downloadUrl);
    print(survey.sets[i].votes);
  }
}

// void _printSets() {
//   for (int i = 0; i < polloptions.length; i++) {
//     // print(polloptions[i].votes);
//     print(polloptions[i].downloadUrl);
//     print(polloptions[i].votes);
//   }
// }

// void _printPoll() {
//   for (int i = 0; i < polloptionsx.length; i++) {
//     // print(polloptions[i].votes);
//     print(polloptionsx[i].downloadUrl);
//     print(polloptionsx[i].votes);
//     print("Helloo Space");
//     print(polloptionsx.length);
//   }
// }

// void _loopSets() {
//   print(polloptionsx[1].downloadUrl);
//   var lss = polloptionsx.map((set) {
//     print(set.description);
//     if (set.votes == 22) {
//       print('upating ${set.votes}...');
//       // car.name = "Tesla";
//     }
//     return set;
//   });
// }

// void _clearPoll() {
//   polloptionsx.clear();
// }

// WRONG survey SCOPE:
// void _printSurvey() {
//   for (int i = 0; i < survey.sets.length; i++) {
//     print(survey.sets[i].downloadUrl);
//     print(survey.sets[i].votes);
//   }
// }

class Opi {
  Future<Opinion?> createOpObjCl() async {
    late Opinion opiz;
    var opi = await importData().then((value) {
      opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
      opiz.sets.forEach((set) {
        Set setInst = set as Set;
      });
      print("Obj Return");
      print(opiz.name);

      return opiz;
    });
    // print(opi.toString());
    print("Other Return");
    // return opiz;
  }
}

class OService {
  static Future<Opinion> getOpi() async {
    late Opinion opiz;
    var response = await importData().then((value) {
      opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
    });

    return opiz;
  }
}

void _printSurveyFromFut(Opinion opx) {
  print(opx.name);
  print(opx.description);
  for (int i = 0; i < opx.sets.length; i++) {
    print(opx.sets[i].downloadUrl);
    print(opx.sets[i].votes);
  }
}
