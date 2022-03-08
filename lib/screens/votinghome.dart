//2021-12-26 KEEP for v1
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/polltype.dart';
import 'package:moodclicks/screens/chartsandvis2.dart';
import 'package:moodclicks/screens/chartsandvis3subcoll.dart';
import 'package:moodclicks/screens/chartsandvisOriUTube.dart';
import 'package:moodclicks/services/database.dart';
import 'package:moodclicks/services/dynamiclinks.dart';
import 'package:moodclicks/services/firebase_dynamic_link.dart';
import 'package:moodclicks/services/getcurrentuser.dart';
import 'package:moodclicks/services/getdatalist.dart';
import 'package:moodclicks/services/ip_info_api.dart';

class VotingChoices extends StatefulWidget {
  final String surveyId;

  const VotingChoices({Key? key, required this.surveyId}) : super(key: key);

  @override
  _VotingChoicesState createState() => _VotingChoicesState();
}

class _VotingChoicesState extends State<VotingChoices> {
  late Future<Opinion> opik;
  late Future<String> phIp;

  @override
  void initState() {
    super.initState();
    // readNestedData();

    // polloptions.clear();
    print("Boj Opinio below:");
    // opik = OService.getOpi();
    // opik.then((value) {
    readNestedData().then((value) {
      setState(() {
        //TODO: NEED to FIX:buildSingleChoice(value);
        buildSingleChoice(value);
        printOpin(pollType);
        // oplist(value);
        // listLength(value);
        setVoteStatus();
        // phIp = await IpInfoApi.getIPAddress();
        // listLength2();
        init();
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

  List<PollTypeSingle> pollType = [];

  // List<PollTypeSingle> buildSingleChoice(Opinion survey) {
  //   var len = survey.sets.length;
  //   print(len.toInt());
  //   List<PollTypeSingle> p = [];
  //   for (int i = 0; i < len; i++) {
  //     // p.add(PollTypeSingle(id: i, name: survey.sets[i][''], description: survey.sets[i]['']);
  //     print(survey.sets[i].description);

  //     p.add(PollTypeSingle(
  //         id: i,
  //         name: survey.sets[i].description,
  //         description: survey.sets[i].description));
  //   }
  //   print('p PRINT');
  //   print(p.first.description);
  //   print(p.last.imgLink);
  //   pollType = p;
  //   return p;
  // }

  void buildSingleChoice(Opinion survey) {
    var len = survey.sets.length;
    print(len.toInt());
    List<PollTypeSingle> p = [];
    for (int i = 0; i < len; i++) {
      // p.add(PollTypeSingle(id: i, name: survey.sets[i][''], description: survey.sets[i]['']);
      print(survey.sets[i].description);

      p.add(PollTypeSingle(
          id: i,
          name: survey.sets[i].description,
          description: survey.sets[i].description));
    }
    print('p PRINT');
    print(p.first.description);
    print(p.last.imgLink);
    pollType = p;
  }

  void printOpin(List<PollTypeSingle> p) {
    print('hellof me');
    print(p[1].name);
    // print(survey.sets[1].description);
  }

  // PollTypeSingle pd = PollTypeSingle(pollType.first.id);

  // Future<String> id2 = pollType.first['id'];

  // PollTypeSingle selectedValue = pollType.[]first;

  // List<PollTypeSingle> get newMethod => pp;

  final selectedColor = Colors.pink;
  final unselectedColor = Colors.grey;

  // late PollTypeSingle pp =
  //     PollTypeSingle(id: id, name: name, description: description);

  late PollTypeSingle selectedOption = pollType.first;

  late String ipAddrn;

  Future init() async {
    final ipAddress = await IpInfoApi.getIPAddress();
    if (!mounted) return;
    print(ipAddress);
    setState(() => ipAddrn = ipAddress!);
    late String me = ipAddress.toString();
    print(me);
  }

  // PollTypeSingle(
  //     id: pollType.first.id,
  //     name: pollType.first.name,
  //     description: pollType.first.description);

  // Widget lviewB() {
  //   return ListView.separated(
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     padding: const EdgeInsets.all(8)

  late Future<bool> ipexists;
  late Future<String> ipexists2;
  UserInformation sd = UserInformation();
  Widget radioBallot() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 16),
          children: pollType
              .map(
                (poll) => RadioListTile<PollTypeSingle>(
                  value: poll,
                  groupValue: selectedOption,
                  title: OutlinedButton(
                    onPressed: () {
                      print(
                          ' ADD to Set State for Option Chosen - And Also Run Checks on User - Create Seperate SFinal Submit Button');
                      // ipexists =
                      //     sd.ipExists(widget.surveyId, '1') as Future<bool>;
                      // if (ipexists == true) {
                      //   print('object BOL');
                      // }
                      ipexists2 = sd.ipExistsPrint(widget.surveyId);

                      ;
                    },
                    child: Text(poll.description.toString()),
                  ),
                  subtitle: Text(poll.imgLink.toString()),
                  secondary: OutlinedButton(
                    child: Text('ViewPics'),
                    onPressed: () {
                      print('Hellos');
                    },
                  ),
                  // ADD {} to Set State and ADD to Set State for Option Chosen - And Also Run Checks on User - Create Seperate SFinal Submit Button
                  onChanged: (value) => setState(() {
                    selectedOption = value!;
                    AddObjectToVotingChoices2(poll.id!.toInt());
                    print(choiceList.first);
                  }),
                ),
              )
              .toList()),
    );
  }

  void AddObjectToVotingChoices2(int option) {
    print('CHOICEList Value:');
    choiceList.clear();
    print(balCst.length);
    balCst.clear();
    Ballot bal =
        Ballot(option.toString(), 1, loggedInUser, DateTime.now(), ipAddrn);

    balCst.add(bal);

    print(option);
    Choices choice = Choices(
      currUser2,
      "https://www.google.co.fr/",
      widget.surveyId,
      option,
      balCst,
    );
    if (choiceList.isEmpty) {
      choiceList.add(choice);
    } else
      () {
        choiceList.clear();
        choiceList.add(choice);
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("votinghome.dt"),
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
            // Container(
            //   // height: 400,
            //   // height: MediaQuery.of(context).size.height / 3,
            //   child: listStatus > 0
            //       ? lviewB()
            //       : Text("Error : Empty List, No Data Received"),
            // ),
            Container(
              // height: 400,
              // height: MediaQuery.of(context).size.height / 3,
              child: lviewB(),
            ),
            Divider(
              color: Colors.white,
            ),
            // buildRadios(),
            radioBallot(),
            Divider(
              color: Colors.white,
            ),
            // Text(ipAddrn),
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
                      AddToFireSubColl(),
                      setState(() {
                        voted = 'y';
                      }),
                    }),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("Vote Castv Already! $voted:"),
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
                label: Text("View Results Charts CHARTS2 SubColl"),
                onPressed: () => {
                      print('Moving to ResultsChart CHARTS23 SubColl'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultsChart2(surveyId: widget.surveyId)))
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

  AddToFireSubColl() async {
    final _fireStore = FirebaseFirestore.instance;
    Choices c = Choices(
        currUser2, "https://www.google.co.frs/", widget.surveyId, 1, balCst);
    print(c.votescast);
//NOTE: To ONLY add the votingchoices use:
    // await _fireStore.collection('opinion').add({
//NOTE: To INCLUDE orig Survey Headers PLUS the votingchoices:
    await _fireStore
        .collection('opinion')
        .doc(widget.surveyId)
        .collection('response')
        .doc()
        .set({
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

    Ballot bal =
        Ballot(option.toString(), 1, loggedInUser, DateTime.now(), ipAddrn);

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

  Future<Opinion> readNestedData() async {
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
    return survey;
  }

// ADDED 20/02/2022
// TODO: Dev Notes Tried getting from Database but kept returning null :
// ERROR:flutter/lib/ui/ui_dart_state.cc(199)] Unhandled Exception: type 'Null' is not a subtype of type 'Map<String, dynamic>' in type cast
// use readNestedData() until getOpin() - solved

  Future<void> getOpin() async {
    Opinion kc;
    DatabaseService ds = DatabaseService.docId(widget.surveyId);
    ds.getDocs2(widget.surveyId).then((docSnapshot) => {
          kc = Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
          kc.sets.forEach((set) {
            Set setInst = set as Set;
          }),
          print("Print NEWWWW TOP level Data:"),
          print(kc.description),
          print("PrintENNND Lower level Data from ARRAY of  MAPS:"),
          print(kc.sets[0].votes),
          survey = kc,
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
  late Opinion survey = Opinion();

//Search Create List Widget to make this into a Widget:
  //TODO: NEED to FIX:buildSingleChoice(value);

  List<int> castVotes = [];
  List<Choices> choiceList = [];
  List<Ballot> balCst = [];

  CollectionReference opinions =
      FirebaseFirestore.instance.collection('opinion');
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

  // void printOpin(Opinion p) {
  //   print('hellof me');
  //   print(p.description);
  //   print(survey.sets[1].description);
  // }
}
