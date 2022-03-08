// ###########  NEW Verion BELOW: 20220305  ##################
//chartsandvis2.dart amended to read data from sub collections

// import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultsChart2 extends StatefulWidget {
  final String surveyId;
  const ResultsChart2({Key? key, required this.surveyId}) : super(key: key);
  @override
  _ResultsChart2State createState() => _ResultsChart2State();
}

class _ResultsChart2State extends State<ResultsChart2> {
  @override
  void initState() {
    super.initState();
    printBallot();
  }

  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamDocs =
        // FirebaseFirestore.instance
        _fireStore
            .collection('opinion')
            .doc(widget.surveyId)
            .collection('response')
            // .where('votingchoices.description',
            //     isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
            .where('votingchoices.description', isEqualTo: widget.surveyId)
            // isEqualTo: 'bSTqWjT0a4vRQfYU6ZJE')
            .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('chartsandvis3subcoll'),
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
                  print('SnapshotSize:');
                  print(snapshot.data!.size);
                  // print(course['votingchoices']['downloadUrl']);
                  // print(course['votingchoices']['Ballot'].toString());
                  //* See what being Added ^ */
                  // Ballot b = Ballot.fromMap(Map<String, dynamic> );
                  print("Len");
                  // len(course['votingchoices']['Ballot'][{[]}.length]);
                  // print(course['votingchoices']['Ballot'][{[0]}.length]);
                  print(course['votingchoices']['Ballot'].length);
                  print("LenEND");
                  // for (int j = 0; j < snapshot.data!.size; j++) {
                  //   print(course['votingchoices']['Ballot'].toString());
                  // };
                  // List<Ballot>
                  // ballotList = course['votingchoices']['Ballot']
                  List<Ballot> bl;
                  bl = course['votingchoices']['Ballot']
                      .map<Ballot>((x) => Ballot.fromMap(x))
                      .toList();
                  // ballotList.addAll(bl);
                  if (ballotList.isNotEmpty) {
                    print('ENOT ballotList EMpty!');
                    print(ballotList.length);
                  }
                  ballotList.addAll(bl);
                  print(ballotList.length);
                  bl.clear();
                  if (bl.isNotEmpty) {
                    print('ENOT EMpty!');
                  } else if (bl.isEmpty) {
                    print('empty');
                  }
                  print("Ballist Length");
                  print(ballotList.length);
                  printBallot();

                  // print(ballotList[0].option);

                  print("Adding Ballots i:");
                  print(i);
                  // stackVoteBalData2();
                  print('See BELOW:');
                }
                _getSumByProduct();
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

  List<Ballot> ballotList = [];

  void printBallot() {
    print("Pringint Ballot List : Length=");
    print(ballotList.length);
    for (int i = 0; i < ballotList.length; i++) {
      print("Option $i : " + ballotList[i].option);
      print("Vote $i : " + ballotList[i].vote.toString());
    }
  }

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
    print('Printing Carmap: $carMap');
  }

  List<Ballot> ballotSummary = [];

  _createSummaryList() {
    Ballot b;
    print('Adding following to ballotSummary');
    print('Printing Carmap: $carMap');
    carMap.forEach((k, v) {
      print('LOOP $k, $v ');
      print("Key : $k, Value : $v");
      b = Ballot.voteSum(k, v);
      ballotSummary.add(b);
    });
    print('BALLOT SUmmay Added');
    _printSummary();
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
}

class VoteResults {
  late final String option;
  late final int votes;
  late final Color barColor;

  VoteResults(this.option, this.votes, this.barColor);
}
