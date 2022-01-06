//2021-12-26 KEEP for v1
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/screens/chartsandvis2.dart';
import 'package:moodclicks/screens/chartsandvisOriUTube.dart';

class SurveyDisplay2 extends StatefulWidget {
  final String surveyId;
  const SurveyDisplay2({Key? key, required this.surveyId}) : super(key: key);

// ENTER THE DATA HERE
// late Future data;

  @override
  _SurveyDisplay2State createState() => _SurveyDisplay2State();
}

class _SurveyDisplay2State extends State<SurveyDisplay2> {
  late Future<Opinion> opik;
  // final _firestore = FirebaseFirestore.instance;
  // late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDoc;
  // late Future<QuerySnapshot<Map<String, dynamic>>> _futureSnapshot;

  @override
  void initState() {
    super.initState();
    readNestedData();
    // polloptions.clear();

    print("Boj Opinio below:");

    opik = OService.getOpi();
    opik.then((value) {
      setState(() {
        // oplist(value);
        listLength(value);
        setVoteStatus();
        // listLength2();
      });
    });

    // print(opik.then((value) => value.sets));
  }

  int voteTally = 0;
  int listStatus = 0;
  // int listStatus2 = 0;

  Future<int> listLength(Opinion list) async {
    print("HELOOx");
    print(list.sets.length);
    return listStatus = list.sets.length;
  }

  // Future<int> listLength2() async {
  //   print("HELOOx");
  //   print(survey.sets.length);
  //   return listStatus2 = survey.sets.length;
  // }

  late Future<Opinion> survey2;

  Future<void> getDocs() async {
    Opinion opinion;
    await FirebaseFirestore.instance
        .collection("opinion")
        .doc(widget.surveyId)
        .get();
  }
  // List<Opinion> opList = [];

  // List<Opinion> oplist(Opinion o) {
  //   List<Opinion> opiList = [];
  //   opiList.add(o);
  //   opList = opiList;
  //   return opiList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("x. surveydisplay2.dt"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text("Heres your Survey Data:"),
            Center(
              child: Text(widget.surveyId),
            ),

            ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("Print CurrentUserID"),
                onPressed: () => {
                      print(currUser2),
                    }),

            ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("Signout CurrentUserID"),
                onPressed: () => {
                      print(currUser2),
                      signOut(),
                    }),

            Container(
              // height: 400,
              // height: MediaQuery.of(context).size.height / 3,
              child: listStatus > 0
                  ? lviewB()
                  : Text("Error : Empty List, No Data Received"),
            ),
            // lviewB(),

            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("Submit Vote:"),
                onPressed: () => {
                      // dummyAddList(1),
                      submitChoices(),
                      setState(() {
                        voted = 'y';
                      }),
                      Navigator.pop(context)
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("Vote Cast Already! $voted:"),
                onPressed: () => {
                      print('HEllo'),
                      print(choiceList[0].votescast.toString()),
                      print(choiceList.length.toString()),
                      Text('${choiceList[0].votescast[0]}')
                    }),

            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("View Results Charts NEW"),
                onPressed: () => {
                      print('Moving to ResultsChart CHARTS'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (BuildContext context) => ImpCharts()))
                              builder: (BuildContext context) =>
                                  ResultsChart()))
                      // FireToObj()))
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("View Results Charts ORIG UTube"),
                onPressed: () => {
                      print('Moving to ImpCharts CHARTS'),
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
                    }),
          ],
        ),
      ),
    );
  }

  AddToFire() async {
    final _fireStore = FirebaseFirestore.instance;

    List<dynamic> d = [];
    Ballot bb = Ballot('7', 5);
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
        currUser2, "https://www.google.co.frs/", widget.surveyId, 1, balCst);

    print(c.votescast);

// To ONLY add the votingchoices use:
    // await _fireStore.collection('opinion').add({
// To INCLUDE orig Survey Headers PLUS the votingchoices:
    await _fireStore.collection('opinion').doc(widget.surveyId).update({
      // "item": c.item,
      // "downloadUrl": c.downloadUrl,
      // "description": c.description,
      // "votes": c.votes,
      // "Ballot": FieldValue.arrayUnion(voteList),
      "votingchoices": c.toMap(),

      // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
    });
    // }, SetOptions(merge: true)).then((_) {
    //   print("IMAGES added to Survey!!");
    // });

    d.clear();
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
            .doc(widget.surveyId)
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

  void AddObjectToVotingChoices(int option) {
    choiceList.clear();
    // Map<String, dynamic> data = {
    //   "option": option,
    //   "vote": 1,
    // };

    Ballot bal = Ballot(option.toString(), 1);

    balCst.add(bal);

    print(option);
    Choices choice = Choices(
      currUser2,
      "https://www.google.co.fr/",
      // "w87f6S1H6ES4PPaehWxJ", option, toListVotes());
      widget.surveyId,
      option,
      // VostCst,
      balCst,

      // ball.toMap();
    );
    // castBallots.toList()[0]['votes'].toString());

    choiceList.add(choice);
    // VostCst.clear();
  }

  Future<void> readNestedData() async {
    Opinion opinion;
    await FirebaseFirestore.instance
        .collection("opinion")
        .doc(widget.surveyId)
        .get()
        .then((docSnapshot) => {
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
              survey = opinion,
            });
  }

  Widget lviewB() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
          Text("${i + 1} "),
          Text(survey.sets[i].description),
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
}

List<int> castVotes = [];
List<Choices> choiceList = [];
// List<Map> ballotMapList = [];
// List<Map> castBallots = [];
// List<Ballot> Ballots = [];
// Future<List<Map>> ballotMapListft = [] as Future<List<Map>>;
// List<dynamic> VostCst = [];
List<Ballot> balCst = [];
// List<Choices> choiceList2 = [];
// Future<Ballot> balls = [] as Future<Ballot>;
// Future<List<Map<dynamic, dynamic>>> jd = [] as Future<List<Map>>;
// List<Set> polloptions = [];
// List<Set> polloptionsx = [];

CollectionReference opinions = FirebaseFirestore.instance.collection('opinion');
final currUser2 = FirebaseAuth.instance.currentUser!.uid.toString();
var voted;

void setVoteStatus() {
  String voted = 'n';
  print(voted);
}

final _auth = FirebaseAuth.instance;
signOut() async {
  await _auth.signOut();
}

// TODO: CREATE FOR LOOP and SUM the Total Votes.

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
  Opinion op = Opinion('heldfo', 'dfdfe');
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

List<int> toListVotes() {
  List<int> sendVotes = [];
  castVotes.forEach((item) {
    sendVotes.add(item);
  });
  return sendVotes.toList();
}
