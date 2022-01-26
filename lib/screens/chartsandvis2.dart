// //2021-12-26 KEEP for v1
// //chartsandvis2.dart

// // import 'package:firebase_database/firebase_database.dart';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:moodclicks/model/classopinion.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class ResultsChart extends StatefulWidget {
//   @override
//   _ResultsChartState createState() => _ResultsChartState();
// }

// class _ResultsChartState extends State<ResultsChart> {
//   @override
//   void initState() {
//     // stackVoteBalData2();
//     // newAdd();
//     // createVoteListForGraph2();
//     super.initState();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> streamDocs = FirebaseFirestore
//       .instance
//       .collection('opinion')
//       .where('votingchoices.description',
//           isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
//       // isEqualTo: 'bSTqWjT0a4vRQfYU6ZJE')
//       .snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('chartsandvis2'),
//       ),
//       body: Column(children: <Widget>[
//         Text("HELLO"),
//         Expanded(
//           child: StreamBuilder(
//               stream: streamDocs,
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 for (int i = 0; i < snapshot.data!.size; i++) {
//                   DocumentSnapshot course = snapshot.data!.docs[i];
//                   print(snapshot.data!.size);
//                   print(course['votingchoices']['downloadUrl']);
//                   print(course['votingchoices']['Ballot'].toString());
//                   // Ballot b = Ballot.fromMap(Map<String, dynamic> );
//                   print("Len");
//                   // len(course['votingchoices']['Ballot'][{[]}.length]);
//                   print(course['votingchoices']['Ballot'][{[]}.length]);
//                   print("LenEND");
//                   // for (int j = 0; j < snapshot.data!.size; j++) {

//                   //   print(course['votingchoices']['Ballot'].toString());
//                   // }
//                   ;
//                   // List<Ballot>
//                   // ballotList = course['votingchoices']['Ballot']
//                   List<Ballot> bl;
//                   bl = course['votingchoices']['Ballot']
//                       .map<Ballot>((x) => Ballot.fromMap(x))
//                       .toList();

//                   // ballotList.addAll(bl);
//                   ballotList.addAll(bl);
//                   bl.clear();
//                   print("Ballist Length");
//                   print(ballotList.length);
//                   printBallot();

//                   // print(ballotList[0].option);

//                   print("Adding Ballots");
//                   print(i);

//                   addBallots(
//                       course['votingchoices']['Ballot'][i].toString(),
//                       course['votingchoices']['Ballot'][i]['option']
//                           .toString());
//                   stackVoteBalData2();
//                 }

//                 ;
//                 // **********
//                 // List<VoteResults> voteResult2 = [];

//                 // void createVoteListForGraph2() {
//                 //   // for (int i = 0; i < balList.length; i++) {
//                 //   for (int i = 0; i < balList2.length; i++) {
//                 //     Color _randomColor = Colors
//                 //         .primaries[Random().nextInt(Colors.primaries.length)];
//                 //     print(balList2[i].option);
//                 //     int votes = balList2[i].vote;
//                 //     //  VoteResult.add() VoteResults[balList][i].option);
//                 //     VoteResults vr = VoteResults(
//                 //         balList2[i].option, votes + 1, _randomColor);
//                 //     print(balList2[i].vote);
//                 //     voteResult2.add(vr);
//                 //     // setState(() {
//                 //     //   voteResult2;
//                 //     // });
//                 //   }
//                 // }

//                 // createVoteListForGraph2();
//                 // List<charts.Series<VoteResults, String>> series2 = [
//                 //   charts.Series(
//                 //       data: voteResult2,
//                 //       id: "Voting Results",
//                 //       domainFn: (VoteResults pops, _) => pops.option,
//                 //       measureFn: (VoteResults pops, _) => pops.votes,
//                 //       colorFn: (VoteResults pops, _) =>
//                 //           charts.ColorUtil.fromDartColor(pops.barColor))
//                 // ];

//                 List<VoteResults> voteResult3 = [];

//                 void createVoteListForGraph3() {
//                   // for (int i = 0; i < balList.length; i++) {
//                   for (int i = 0; i < ballotList.length; i++) {
//                     Color _randomColor = Colors
//                         .primaries[Random().nextInt(Colors.primaries.length)];
//                     print(ballotList[i].option);
//                     int votes = ballotList[i].vote;
//                     //  VoteResult.add() VoteResults[balList][i].option);
//                     VoteResults vr =
//                         VoteResults(ballotList[i].option, votes, _randomColor);
//                     print(ballotList[i].vote);
//                     voteResult3.add(vr);
//                     // setState(() {
//                     //   voteResult2;
//                     // });
//                   }
//                 }

//                 createVoteListForGraph3();

//                 // createVoteListForGraph2();
//                 List<charts.Series<VoteResults, String>> series3 = [
//                   charts.Series(
//                       data: voteResult3,
//                       id: "Voting Results",
//                       domainFn: (VoteResults pops, _) => pops.option,
//                       measureFn: (VoteResults pops, _) => pops.votes,
//                       colorFn: (VoteResults pops, _) =>
//                           charts.ColorUtil.fromDartColor(pops.barColor))
//                 ];
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height / 2,
//                       decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: charts.BarChart(series3),
//                     ),
//                   ),
//                 );
//               }),
//         ),
//         SizedBox(
//           height: 28,
//         ),
//       ]),
//     );
//   }

//   void printdata() async {
//     print("BELOW");
//     print(await balList2[0].vote.toString());
//   }

//   List<Ballot> ballotList = [];

//   void printBallot() {
//     print("Pringint Ballot List");
//     for (int i = 0; i < ballotList.length; i++) {
//       print("Option $i : " + ballotList[i].option);
//       print("Vote $i : " + ballotList[i].vote.toString());
//     }
//   }

//   List<Ballot> balList2 = [];

//   void addBallots(option, votes) {
//     // balList2.clear();

//     Ballot b = Ballot(option, int.parse('$votes'));
//     balList2.add(b);
//     print('BOO!');
//   }

//   stackVoteBalData2() async {
//     return await FirebaseFirestore.instance
//         .collection('opinion')
//         .where('votingchoices.description',
//             isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
//         // isEqualTo: 'bSTqWjT0a4vRQfYU6ZJE')

//         // .orderBy('votingchoices.description')
//         .snapshots();
//   }

//   void newAdd() async {
//     // balList2.clear();

//     // Ballot b = Ballot('10', 11);

//     var b;

//     int blen;

//     await stackVoteBalData2().then((docSnapshot) => {
//           blen = docSnapshot.data()['votingchoices']['Ballot'].length,
//           print("Length{$blen}"),
//           for (int i = 0; i < blen; i++)
//             {
//               b = Ballot(
//                   docSnapshot.data()['votingchoices']['Ballot'][i]['option'],
//                   docSnapshot.data()['votingchoices']['Ballot'][i]['vote']),
//               // balList.add(b.toMap());
//               print(b.option),

//               print(b.vote),
//               balList2.add(b),
//               print(balList2.length)
//             }
//         });
//   }

//   void printBalList2() {
//     print("DOC Data ADDED to balList2: ");
//     print(balList2.length);
//     print("LEN");
//     for (int i = 0; i < balList2.length; i++) {
//       print("i value" + "$i");
//       print(balList2[i].option);

//       // print(balList2[i].vote);
//     }
//     print('POO!');
//   }

//   // void len(course) {
//   //   int k = (course['votingchoices']['Ballot'][{[]}.length]);
//   //   print(k);
//   // }
// }

// class VoteResults {
//   late final String option;
//   late final int votes;
//   late final Color barColor;

//   VoteResults(this.option, this.votes, this.barColor);
// }
// ###########  NEW Verion BELOW: 20210106  ##################

//2021-12-26 KEEP for v1
//chartsandvis2.dart

// import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultsChart extends StatefulWidget {
  final String surveyId;
  const ResultsChart({Key? key, required this.surveyId}) : super(key: key);
  @override
  _ResultsChartState createState() => _ResultsChartState();
}

class _ResultsChartState extends State<ResultsChart> {
  @override
  void initState() {
    // stackVoteBalData2();
    // newAdd();
    // createVoteListForGraph2();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamDocs =
        FirebaseFirestore.instance
            .collection('opinion')
            // .where('votingchoices.description',
            //     isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
            .where('votingchoices.description', isEqualTo: widget.surveyId)
            // isEqualTo: 'bSTqWjT0a4vRQfYU6ZJE')
            .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('chartsandvis2'),
      ),
      body: Column(children: <Widget>[
        Text("Results for surveyID:"),
        Text(widget.surveyId),
        Expanded(
          child: StreamBuilder(
              stream: streamDocs,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                for (int i = 0; i < snapshot.data!.size; i++) {
                  DocumentSnapshot course = snapshot.data!.docs[i];
                  print(snapshot.data!.size);
                  print(course['votingchoices']['downloadUrl']);
                  print(course['votingchoices']['Ballot'].toString());
                  // Ballot b = Ballot.fromMap(Map<String, dynamic> );
                  print("Len");
                  // len(course['votingchoices']['Ballot'][{[]}.length]);
                  print(course['votingchoices']['Ballot'][{
                    [2]
                  }.length]);
                  print("LenEND");
                  // for (int j = 0; j < snapshot.data!.size; j++) {

                  //   print(course['votingchoices']['Ballot'].toString());
                  // }
                  ;
                  // List<Ballot>
                  // ballotList = course['votingchoices']['Ballot']
                  List<Ballot> bl;
                  bl = course['votingchoices']['Ballot']
                      .map<Ballot>((x) => Ballot.fromMap(x))
                      .toList();

                  // ballotList.addAll(bl);
                  ballotList.addAll(bl);
                  bl.clear();
                  print("Ballist Length");
                  print(ballotList.length);
                  printBallot();

                  // print(ballotList[0].option);

                  print("Adding Ballots");
                  print(i);

                  addBallots(
                      course['votingchoices']['Ballot'][i].toString(),
                      course['votingchoices']['Ballot'][i]['option']
                          .toString());
                  stackVoteBalData2();
                  print('See BELOW:');
                  _getSumByProduct();
                }

                ;
                // **********
                // List<VoteResults> voteResult2 = [];

                // void createVoteListForGraph2() {
                //   // for (int i = 0; i < balList.length; i++) {
                //   for (int i = 0; i < balList2.length; i++) {
                //     Color _randomColor = Colors
                //         .primaries[Random().nextInt(Colors.primaries.length)];
                //     print(balList2[i].option);
                //     int votes = balList2[i].vote;
                //     //  VoteResult.add() VoteResults[balList][i].option);
                //     VoteResults vr = VoteResults(
                //         balList2[i].option, votes + 1, _randomColor);
                //     print(balList2[i].vote);
                //     voteResult2.add(vr);
                //     // setState(() {
                //     //   voteResult2;
                //     // });
                //   }
                // }

                // createVoteListForGraph2();
                // List<charts.Series<VoteResults, String>> series2 = [
                //   charts.Series(
                //       data: voteResult2,
                //       id: "Voting Results",
                //       domainFn: (VoteResults pops, _) => pops.option,
                //       measureFn: (VoteResults pops, _) => pops.votes,
                //       colorFn: (VoteResults pops, _) =>
                //           charts.ColorUtil.fromDartColor(pops.barColor))
                // ];
                print('PRINTING SUM:');
                // _getSumByProduct();
                _printMap();
                print('Carmap Element');
                _swapLists();

                List<VoteResults> voteResult3 = [];

                void createVoteListForGraph3() {
                  // for (int i = 0; i < balList.length; i++) {
                  for (int i = 0; i < ballotList.length; i++) {
                    Color _randomColor = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                    print(ballotList[i].option);
                    int votes = ballotList[i].vote;
                    //  VoteResult.add() VoteResults[balList][i].option);
                    VoteResults vr =
                        VoteResults(ballotList[i].option, votes, _randomColor);
                    print(ballotList[i].vote);
                    voteResult3.add(vr);
                    // setState(() {
                    //   voteResult2;
                    // });
                  }
                }

                createVoteListForGraph3();
                _printSummary();
                _clearMap();

                // createVoteListForGraph2();
                List<charts.Series<VoteResults, String>> series3 = [
                  charts.Series(
                      data: voteResult3,
                      id: "Voting Results",
                      domainFn: (VoteResults pops, _) => pops.option,
                      measureFn: (VoteResults pops, _) => pops.votes,
                      colorFn: (VoteResults pops, _) =>
                          charts.ColorUtil.fromDartColor(pops.barColor))
                ];

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: charts.BarChart(series3),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 28,
        ),
      ]),
    );
  }

  void printdata() async {
    print("BELOW");
    print(await balList2[0].vote.toString());
  }

  List<Ballot> ballotList = [];

  void printBallot() {
    print("Pringint Ballot List");
    for (int i = 0; i < ballotList.length; i++) {
      print("Option $i : " + ballotList[i].option);
      print("Vote $i : " + ballotList[i].vote.toString());
    }
  }

  List<Ballot> balList2 = [];
  final loggedInUser = FirebaseAuth.instance.currentUser!.uid;

  void addBallots(option, votes) {
    // balList2.clear();

    // Ballot b = Ballot(option, int.parse('$votes'), loggedInUser);
    Ballot b = Ballot.voteSum(option, int.parse('$votes'));
    balList2.add(b);
    print('BOO!');
  }

  stackVoteBalData2() async {
    return await FirebaseFirestore.instance
        .collection('opinion')
        .where('votingchoices.description',
            isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
        // isEqualTo: 'bSTqWjT0a4vRQfYU6ZJE')

        // .orderBy('votingchoices.description')
        .snapshots();
  }

  void newAdd() async {
    // balList2.clear();

    // Ballot b = Ballot('10', 11);

    var b;

    int blen;

    await stackVoteBalData2().then((docSnapshot) => {
          blen = docSnapshot.data()['votingchoices']['Ballot'].length,
          print("Length{$blen}"),
          for (int i = 0; i < blen; i++)
            {
              b = Ballot.voteSum(
                docSnapshot.data()['votingchoices']['Ballot'][i]['option'],
                docSnapshot.data()['votingchoices']['Ballot'][i]['vote'],
                // docSnapshot.data()['votingchoices']['Ballot'][i]['voterid'],
              ),
              // balList.add(b.toMap());

              print(b.option),

              print(b.vote),
              balList2.add(b),
              print(balList2.length)
            }
        });
  }

  void printBalList2() {
    print("DOC Data ADDED to balList2: ");
    print(balList2.length);
    print("LEN");
    for (int i = 0; i < balList2.length; i++) {
      print("i value" + "$i");
      print(balList2[i].option);

      // print(balList2[i].vote);
    }
    print('POO!');
  }

  // void len(course) {
  //   int k = (course['votingchoices']['Ballot'][{[]}.length]);
  //   print(k);
  // }

  var carMap = {};
  List<Map> lm = [];

  _getSumByProduct() {
    print("Length of Ballist");
    print(ballotList.length);
    ballotList.forEach((ballot) {
      print(ballot.toMap());
      print("Length of Ballist END");
      String option = ballot.option;
      if (carMap.containsKey(option)) {
        carMap[option] += ballot.vote;
        // lm[option] += ballot.vote;
      } else {
        carMap[option] = ballot.vote;
      }
    });
    // print(carMap);
  }

  List<Ballot> ballotSummary = [];

  _createSummaryList() {
    Ballot b;
    carMap.forEach((k, v) {
      print("Key : $k, Value : $v");
      b = Ballot.voteSum(k, v);
      ballotSummary.add(b);
    });
  }

  _printMap() {
    Ballot b;
    print("Heres the full List AGG:");
    print(carMap);
    print('Sepecific at 1');
    // print(carMap[[1]]);
    // carMap.clear();
    carMap.keys.forEach((k) => print("Key : $k"));
    carMap.values.forEach((v) => print("Value: $v"));
    carMap.forEach((k, v) => print("Key : $k, Value : $v"));
    _createSummaryList();
  }

  _printSummary() {
    print("PRINTING SUMMARY BAllot Loop");
    for (int i = 0; i < ballotSummary.length; i++) {
      print(ballotSummary[i].option);
      print(ballotSummary[i].vote);
    }
  }

  _swapLists() {
    print("ballotlisLengthPRE");
    print(ballotList.length);
    ballotList = ballotSummary;
    print("ballotlisLengthPOST");
    print(ballotList.length);
  }

  _clearMap() {
    print("Clearing MAP:");
    // print(carMap);
    carMap.clear();
    ballotList.clear();
    ballotSummary.clear();
  }

// _rtnMap(){
// carMap.asMap().entries.map((entry) {
//     int idx = entry.key;
//     String val = entry.value;

//     return something;

// }

// }

}

class VoteResults {
  late final String option;
  late final int votes;
  late final Color barColor;

  VoteResults(this.option, this.votes, this.barColor);
}
