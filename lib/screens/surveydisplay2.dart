//2021-12-26 KEEP for v1
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/screens/chartsandvis2.dart';
import 'package:moodclicks/screens/chartsandvisOriUTube.dart';
import 'package:moodclicks/services/dynamiclinks.dart';
import 'package:moodclicks/services/firebase_dynamic_link.dart';
import 'package:moodclicks/services/getcurrentuser.dart';

class SurveyDisplay2 extends StatefulWidget {
  final String surveyId;

  const SurveyDisplay2({Key? key, required this.surveyId}) : super(key: key);

  @override
  _SurveyDisplay2State createState() => _SurveyDisplay2State();
}

class _SurveyDisplay2State extends State<SurveyDisplay2> {
  late Future<Opinion> opik;

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

  Future<int> listLength(Opinion list) async {
    print("HELOOx");
    print(list.sets.length);
    return listStatus = list.sets.length;
  }

  late Future<Opinion> survey2;

  Future<void> getDocs() async {
    Opinion opinion;
    await FirebaseFirestore.instance
        .collection("opinion")
        .doc(widget.surveyId)
        .get();
  }

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
            Text("Survey ID:"),
            Center(
              child: Text(widget.surveyId),
            ),
            Text("Survey Creator UserID:"),
            Center(
              child: Text(currUser2),
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
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("+submitChoices():Adds new 'Ballot' to FireList[]"),
                onPressed: () => {
                      submitChoices(),
                      setState(() {
                        voted = 'y';
                      }),
                      Navigator.pop(context)
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label:
                    Text("+AddToFire():Adds Votes to EXISTING 'Ballot' object"),
                onPressed: () => {
                      print("ADDING UPDATED to FIREbase:"),
                      AddToFire(),
                      setState(() {
                        voted = 'y';
                      }),
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
                              builder: (BuildContext context) =>
                                  ResultsChart(surveyId: widget.surveyId)))
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("View Results Charts ORIG UTube"),
                onPressed: () => {
                      print('Moving to ImpCharts CHARTS'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ImpCharts()))
                    }),
            GestureDetector(
              onTap: () async {
                // TODO: Generate DeepLink for Share WhatsApp / Contacts etc
                String generatedDeepLink =
                    await FirebaseDynamicLinkService.createDynamicLinkService(
                        widget.surveyId);
                print(generatedDeepLink);
                print(widget.surveyId);
              },
              child: Container(
                height: 18,
                child:
                    Text('Click to Share Link to Contacts for their Opinion:'),
              ),
            ),
            OutlinedButton(
              child: const Text('Create Link'),
              onPressed: () {
                DynamicLinkService.createDynamicLink(widget.surveyId);
              },
            ),
            OutlinedButton(
              child: const Text('Refresh Page'),
              onPressed: () {
                setState(() {});
                ;
              },
            ),
          ],
        ),
      ),
    );
  }

  AddToFire() async {
    final _fireStore = FirebaseFirestore.instance;

    // List<dynamic> d = [];
    // Ballot bb = Ballot('7',  5);
    // d.add(bb);
    // Ballot cc = Ballot('1', 1);
    // d.add(cc);
    // Ballot dd = Ballot('4', 1);
    // d.add(dd);
    // Ballot ee = Ballot('3', 1);
    // d.add(ee);

    Choices c = Choices(
        currUser2, "https://www.google.co.frs/", widget.surveyId, 1, balCst);

    print(c.votescast);

//NOTE: To ONLY add the votingchoices use:
    // await _fireStore.collection('opinion').add({
//NOTE: To INCLUDE orig Survey Headers PLUS the votingchoices:
    await _fireStore.collection('opinion').doc(widget.surveyId).update({
      "votingchoices": c.toMap(),
    });
//From Dummy List d above line 190
    // d.clear();
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

  final loggedInUser = FirebaseAuth.instance.currentUser!.uid;

  void AddObjectToVotingChoices(int option) {
    choiceList.clear();
    Ballot bal = Ballot(option.toString(), 1, loggedInUser, DateTime.now(), '');

    balCst.add(bal);

    print(option);
    Choices choice = Choices(
      currUser2,
      "https://www.google.co.fr/",
      widget.surveyId,
      option,
      balCst,
    );

    choiceList.add(choice);
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
      itemCount: survey!.sets.length,
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
          Text(survey!.sets[i].description),
          Container(
            height: 120,
            width: 80,
            child: Image.network(survey!.sets[i].downloadUrl),
          ),
          // Container(
          //   height: 50,
          //   width: 50,
          //   child: Text(
          //     "Votes: ${survey.sets[i].votes.toString()}",
          //     // textAlign: TextAlign.center,
          //   ),
          // ),
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
                  "Votes: ${survey!.sets[i].votes.toString()}",
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
  Opinion? survey;
}

List<int> castVotes = [];
List<Choices> choiceList = [];
List<Ballot> balCst = [];

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
      .doc("FeYHmHsHzbeKGNMG9gCI")
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
  // Opinion op = Opinion();
  Opinion opiz;
  var opi = await importData().then((value) {
    opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
    opiz.sets.forEach((set) {
      Set setInst = set as Set;
    });
    print(opiz.name);

    return opiz;
  });
}

Future<Opinion> createOpObjFut() async {
  Opinion op = Opinion();
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

    print("Other Return");
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
