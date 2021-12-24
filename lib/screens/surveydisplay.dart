import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/screens/addsrvimages.dart';
import 'package:moodclicks/screens/chartsandvis.dart';
import 'package:moodclicks/screens/chartsandvis2.dart';
import 'package:moodclicks/screens/chartsandvis3.dart';
import 'package:moodclicks/screens/chartsandvisOriUTube.dart';
import 'package:moodclicks/screens/getcloudimages.dart';
import 'package:moodclicks/screens/test.dart';

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

    print("Boj Opinio below:");

    opik = OService.getOpi();
    opik.then((value) {
      setState(() {
        oplist(value);
        listLength(value);
        setVoteStatus();
      });
    });

    // print(opik.then((value) => value.sets));
  }

//Orig Sample Doc was : w87f6S1H6ES4PPaehWxJ
  String docId = "ukYTOJ7sTkJ8S8yg38cv";

  int voteTally = 0;

  int listStatus = 0;

  Future<int> listLength(Opinion list) async {
    print("HELOOx");
    print(list.sets.length);
    return listStatus = list.sets.length;
  }

  // void _castVote() {
  //   setState(() {
  //     voteTally += 1;
  //     voteTally = voteTally % (2);

  //     print("${voteTally} ONe Vote  adde d");
  //   });
  // }

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
            Center(
              child: Text(" Document: $docId "),
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
                icon: Icon(Icons.ac_unit),
                label: Text("Submit Vote:"),
                onPressed: () => {
                      dummyAddList(1),
                      submitChoices(),
                      setState(() {
                        voted = 'y';
                      }),
                      Navigator.pop(context)
                    }),
            // ElevatedButton.icon(
            //     icon: Icon(Icons.ac_unit),
            //     label: Text("Print Stuff:"),
            //     onPressed: () => {
            //           print('HEllo'),
            //           print(choiceList[0].votescast.toString()),
            //           print(choiceList.length.toString()),
            //           Text('${choiceList[0].votescast[0]}')
            //         }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("Vote CAst Already! $voted:"),
                onPressed: () => {
                      print('HEllo'),
                      print(choiceList[0].votescast.toString()),
                      print(choiceList.length.toString()),
                      Text('${choiceList[0].votescast[0]}')
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("View Results Charts"),
                onPressed: () => {
                      print('Moving to CHARTS'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (BuildContext context) => ImpCharts()))
                              builder: (BuildContext context) => alldata()))
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("View Results Charts NEW"),
                onPressed: () => {
                      print('Moving to CHARTS'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (BuildContext context) => ImpCharts()))
                              builder: (BuildContext context) =>
                                  StreamBuilderTest()))
                      // FireToObj()))
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("View Results Charts ORIG UTube"),
                onPressed: () => {
                      print('Moving to CHARTS'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (BuildContext context) => ImpCharts()))
                              builder: (BuildContext context) => ImpCharts()))
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("Add Choices TO Firebase:"),
                onPressed: () => {
                      print("ADDING UPDATED to FIREbase:"),
                      // AddObjectToVotingChoices2(),
                      AddToFire(),
                      // print(choiceList[0].votescast.toString()),
                      // print(choiceList.length.toString()),
                      // Text('${choiceList[0].votescast[0]}')
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("Update Choices: ADD Ballots"),
                onPressed: () => {
                      print("BALLOT:"),
                      addBallot2('1'),
                      // print(choiceList[0].votescast.toString()),
                      // print(choiceList.length.toString()),
                      // Text('${choiceList[0].votescast[0]}')
                    }),
          ],
        ),
      ),
    );
  }

  Future<void> readNestedData() async {
    Opinion opinion;
    await FirebaseFirestore.instance
        .collection("opinion")
        .doc(docId)
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

// CHANGE COLOR ON SELECTION : START
  Color _colorContainer = Colors.blue;
  var choice;
  void selectedChoice(int i) {
    setState(() {
      choice = i;
    });
  }

  Color clicked(int i) {
    // if (voted == 'n') {
    if (i == choice) {
      return Colors.pink;
    }
    // if (voted == 'y') {
    //   return Colors.grey;
    // }
    return Colors.green;
  }

//TODO: Change to bool

// CHANGE COLOR ON SELECTION : END

  Widget buildQlist(i) {
    return Container(
      // color: _colorContainer,
      height: 123,
      child: Row(
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
          Row(children: [
            InkWell(
              onTap: () {
                print("Container ${i} clicked");
                // _castVote();
                AddObjectToVotingChoices(i);
                selectedChoice(i);
              },
              child: new Container(
                color: _colorContainer = clicked(i),
                height: 50,
                width: 50,
                child: Text(
                  "Votes: ${survey.sets[i].votes.toString()}",
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
          ])
        ],
      ),
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
                  // _castVote();
                  AddObjectToVotingChoices(i);
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

List<Set> polloptions = [];
// List<Row> optionrow = [];

List<Set> polloptionsx = [];

// TODO: CREATE FOR LOOP and SUM the Total Votes.

// int origTotalVotes = survey.sets[0].votes;

Future<dynamic> importData() async {
  var surveyData = await FirebaseFirestore.instance
      .collection("opinion")
      .doc("ukYTOJ7sTkJ8S8yg38cv")
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
      future: opinion_src.doc('ukYTOJ7sTkJ8S8yg38cv').get(),
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
          opinion_src.doc('ukYTOJ7sTkJ8S8yg38cv').get().then((docSnapshot) => {
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

// CollectionReference opinions = FirebaseFirestore.instance.collection('opinion');

// Future<void> _addVote(int i, int v) {
//   return opinions
//       .doc('2zHmv5oqetOQixD1OJBw')
//       .update({'sets[${i}].votes': v})
//       .then((value) => print("User Voted"))
//       .catchError((error) => print("Failed to update user: $error"));
// }

CollectionReference opinions = FirebaseFirestore.instance.collection('opinion');

Future<void> _addVote(int i, int v) {
  return opinions
      .doc('ukYTOJ7sTkJ8S8yg38cv')
      .update({'[[sets][1].votes]': v})
      .then((value) => print("User Voted"))
      .catchError((error) => print("Failed to update user: $error"));
}

// ADD VOTES CAST 1...n Votes where there is a choice of > 1  START

void dummyAddList(int n) {
  if (castVotes.length > 0) castVotes.clear();

  castVotes.add(n);
}

List<int> castVotes = [];

List<int> toListVotes() {
  List<int> sendVotes = [];
  castVotes.forEach((item) {
    sendVotes.add(item);
  });
  return sendVotes.toList();
}

// void _castVotes() {
//   setState(() {
//     voteTally += 1;
//     voteTally = voteTally % (2);

//     print("${voteTally} ONe Vote  adde d");
//   });
// }

final currUser2 = FirebaseAuth.instance.currentUser!.uid.toString();

List<Choices> choiceList = [];

void AddObjectToVotingChoices(int option) {
  choiceList.clear();
  print(option);
  Choices choice = Choices(
    currUser2,
    "https://www.google.co.fr/",
    // "w87f6S1H6ES4PPaehWxJ", option, toListVotes());
    "ukYTOJ7sTkJ8S8yg38cv",
    option,
    VostCst,
    // ball.toMap();
  );
  // castBallots.toList()[0]['votes'].toString());

  choiceList.add(choice);
}

void submitChoices() {
  print("VOted?? ${choiceList.length}");
  // if (voted == 'y')
  //   print('VOTED COMPLETED');
  // else {
  if (choiceList.length > 0) {
    try {
      FirebaseFirestore.instance
          .collection("opinion")
          // .doc(widget.surveyId)
          // .doc('2HeifNo8JqL5R39U4n3y')
          .doc('ukYTOJ7sTkJ8S8yg38cv')
          .update({
        "votingchoices": FieldValue.arrayUnion([choiceList[0].toMap()]),
      });
      choiceList.clear();
    } catch (e) {
      print('Error Uploading to Cloud: ${e}');
    }
  } else if (choiceList.isEmpty) {
    print('Votes Not Cast. Please vote before clicking Submit ');
  } else if (choiceList.length == 0) {
    print(
        'Choice Length List 0 ; Votes Not Cast. Please vote before clicking Submit ');
  } else
    print("Non of the above");
  // voted = 'y';
  // }
}

var voted;

void setVoteStatus() {
  String voted = 'n';
  print(voted);
}

List<Map> ballotMapList = [];
List<Map> castBallots = [];
List<Ballot> Ballots = [];
Future<List<Map>> ballotMapListft = [] as Future<List<Map>>;

List<dynamic> VostCst = [];

Future<List<Map>> addBallot(String options) async {
  if (options.isNotEmpty) {
    Ballot b;
    try {
      Map<String, dynamic> data = {
        "option": options,
        "vote": 1,
      };

      ballotMapList.add(data);

      // b = data;
    } catch (e) {
      print(e.toString());
    }
  }
  return List.empty();
}

// Future<List<Map>> addBallot(String options) async {
void addBallot2(String options) {
  if (options.isNotEmpty) {
    // Ballot b;
    try {
      Map<String, dynamic> data = {
        "option": options,
        "vote": 1,
      };
      // Ballot b  =  Ballot(options, 1)  ,

      Ballots.add(Ballot(options, 1));

      ballotMapList.add(data);
      castBallots.add(data);
      VostCst.clear();
      VostCst.add(data);
      print("THIS HEREE");
      print(VostCst.toString());
      // b = data;
    } catch (e) {
      print(e.toString());
    }
  }
  // return List.empty();
}

List<Choices> choiceList2 = [];

Future<Ballot> balls = [] as Future<Ballot>;

Future<List<Map<dynamic, dynamic>>> jd = [] as Future<List<Map>>;

Future AddObjectToVotingChoices2() async {
  Ballot ball;
  final _fireStore = FirebaseFirestore.instance;

  List voteList = [];
  choiceList.clear();
  for (int i = 0; i < castBallots.length; i++)
    voteList.add({
      "option": castBallots.toList()[i]['option'],
      "vote": castBallots.toList()[i]['vote'],
    });
  for (int i = 0; i < castBallots.length; i++)
    ball = Ballot(voteList[i]['option'], voteList[i]['vote']);

  jd = castBallots as Future<List<Map>>;

  print(voteList[0]['option']);

  // print(ball[0].vote);

  Choices mychoice = Choices(
      currUser2,
      "https://www.google.co.fr/",
      // "w87f6S1H6ES4PPaehWxJ", option, toListVotes());
      "ukYTOJ7sTkJ8S8yg38cv",
      1,
      // ballotMapList.toList(forEac),
      // "hello".toString()
      VostCst);

  await _fireStore.collection('opinion').doc('ukYTOJ7sTkJ8S8yg38cv').set({
    "item": currUser2,
    "downloadUrl": "https://www.google.co.frs/",
    "description": "ukYTOJ7sTkJ8S8yg38cv",
    "votes": 1,
    // "Ballot": FieldValue.arrayUnion(voteList),
    "votingchoices": FieldValue.arrayUnion(voteList[0].toMap()),
    // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
  }, SetOptions(merge: true)).then((_) {
    print("IMAGES added to Survey!!");
  });
}

AddToFire() async {
  final _fireStore = FirebaseFirestore.instance;

  // await _fireStore.collection('opinion').doc('w87f6S1H6ES4PPaehWxJ').set({
  //   // "item": currUser2,
  //   // "downloadUrl": "https://www.google.co.frs/",
  //   // "description": "w87f6S1H6ES4PPaehWxJ",
  //   // "votes": 1,
  //   // // "Ballot": FieldValue.arrayUnion(voteList),
  //   // "votingchoices": FieldValue.arrayUnion(voteList[0].toMap()),
  //   // // "f0xdloadUerl": imgMapList[i]['downloadUrl'],

  // VostCst.add('1');
  // VostCst.add('0');
  List<dynamic> d = [];
  Ballot bb = Ballot('2', 1);
  d.add(bb);
  Ballot cc = Ballot('1', 1);
  d.add(cc);
  Ballot dd = Ballot('4', 1);
  d.add(dd);
  Ballot ee = Ballot('3', 1);
  d.add(ee);
  //  Map<String, dynamic> data = {
  //       "option": options,
  //       "vote": 1,
  //     };

  Choices c = Choices(
      currUser2, "https://www.google.co.frs/", "ukYTOJ7sTkJ8S8yg38cv", 1, d);

  print(c.votescast);

// To ONLY add the votingchoices use:
  // await _fireStore.collection('opinion').add({
// To INCLUDE orig Survey Headers PLU the votingchoices:
  await _fireStore.collection('opinion').doc('ukYTOJ7sTkJ8S8yg38cv').update({
    // "item": c.item,
    // "downloadUrl": c.downloadUrl,
    // "description": c.description,
    // "votes": c.votes,
    // "Ballot": FieldValue.arrayUnion(voteList),
    "votescast": c.toMap(),

    // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
  });
  // }, SetOptions(merge: true)).then((_) {
  //   print("IMAGES added to Survey!!");
  // });
}

// void manualAdd(){
// var k = Future<List<Map<dynamic, dynamic>>> bb(String 1);
// Ballot b = Ballot('2', 1);
// Choices c = Choices(item, downloadUrl, description, votes, addBallot)

// }

// // print(option);
// Choices choice = Choices(
//     currUser2,
//     "https://www.google.co.fr/",
//     // "w87f6S1H6ES4PPaehWxJ", option, toListVotes());
//     "w87f6S1H6ES4PPaehWxJ",
//     1,
//     castBallots.asMap());
//     // castBallots.toList()[0]['votes'].toString());

// choiceList.add(choice);

// Map<String, dynamic> toMap() => {
//       "option": this.option,
//       "vote": this.vote,
//     };

// Future<List<Map>> addBallot(String options) async {
//   if (options.isNotEmpty) {
//    var Ballot B ;

// B.toMap();

//       ballotMapList.add(Ballot);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//   return List.empty();
// }

// List<int> toListVotes() {
//   List<int> sendVotes = [];
//   castVotes.forEach((item) {
//     sendVotes.add(item);
//   });
//   return sendVotes.toList();
// }
