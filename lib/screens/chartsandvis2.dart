// import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/surveyo.dart';
import 'package:moodclicks/screens/chartsandvis.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StreamBuilderTest extends StatefulWidget {
  @override
  _StreamBuilderTestState createState() => _StreamBuilderTestState();
}

class _StreamBuilderTestState extends State<StreamBuilderTest> {
  @override
  void initState() {
    // stackVoteBalData2();
    // newAdd();
    // createVoteListForGraph2();

    super.initState();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDocs = FirebaseFirestore
      .instance
      .collection('opinion')
      .where('votingchoices.description',
          isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
      .snapshots();
  @override

  // List<VoteResults> voteResult2 = [];

  // void createVoteListForGraph2() {
  //   // for (int i = 0; i < balList.length; i++) {
  //   for (int i = 0; i < balList2.length; i++) {
  //     Color _randomColor =
  //         Colors.primaries[Random().nextInt(Colors.primaries.length)];
  //     print(balList2[i].option);
  //     int votes = balList2[i].vote;
  //     //  VoteResult.add() VoteResults[balList][i].option);
  //     VoteResults vr = VoteResults(balList2[i].option, votes + 1, _randomColor);
  //     print(balList2[i].vote);
  //     voteResult2.add(vr);
  //     setState(() {
  //       voteResult2;
  //     });
  //   }
  // }

  // List<VoteResults> voteResult2 = [];

  // void createVoteListForGraph2() {
  //   // for (int i = 0; i < balList.length; i++) {
  //   for (int i = 0; i < balList2.length; i++) {
  //     Color _randomColor =
  //         Colors.primaries[Random().nextInt(Colors.primaries.length)];
  //     print(balList2[i].option);
  //     int votes = balList2[i].vote;
  //     //  VoteResult.add() VoteResults[balList][i].option);
  //     VoteResults vr = VoteResults(balList2[i].option, votes + 1, _randomColor);
  //     print(balList2[i].vote);
  //     voteResult2.add(vr);
  //     setState(() {
  //       voteResult2;
  //     });
  //   }
  // }

  // List<charts.Series<VoteResults, String>> series2 = [
  //   charts.Series(
  //       data: voteResult2,
  //       id: "Voting Results",
  //       domainFn: (VoteResults pops, _) => pops.option,
  //       measureFn: (VoteResults pops, _) => pops.votes,
  //       colorFn: (VoteResults pops, _) =>
  //           charts.ColorUtil.fromDartColor(pops.barColor))
  // ];

  // List<charts.Series<VoteResults, String>> series2 = [
  //   VoteResults('2', 54, Colors.pink),
  //   VoteResults('3', 23, Colors.purple),
  //   VoteResults('5', 74, Colors.yellow),
  //   VoteResults('6', 84, Colors.amber),
  //   VoteResults('3', 94, Colors.green),
  //   VoteResults('3', 99, Colors.black),
  // ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chartsandvis2'),
      ),
      body: Column(children: <Widget>[
        Text("HELLO"),
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
                // Expanded(
                //   child: Center(
                //     child: Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: MediaQuery.of(context).size.height / 2,
                //         decoration: BoxDecoration(
                //             color: Colors.green,
                //             borderRadius: BorderRadius.circular(10)),
                //         child: charts.BarChart(series2),
                //       ),
                //     ),
                //   ),
                // );
                // return ListView(
                //   children: snapshot.data!.docs.map((document) {
                //     return Column(
                //       children: <Widget>[
                //         Text(
                //           // "${snapshot.data!['name']}",
                //           // "${snapshot.data!['sets'][2]['downloadUrl']}",
                //           "${snapshot.data!.docs}"
                //           "   ",
                //           // " ${document.data!['name']}",

                //           style: TextStyle(
                //               color: Colors.amber,
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         Center(
                //           child: Container(
                //               width: MediaQuery.of(context).size.width / 1.2,
                //               height: MediaQuery.of(context).size.height / 6,
                //               child: Text(
                //                 // document.data.toString(),
                //                 document.id,
                //               )),
                //         ),
                //         Center(
                //           child: Container(
                //               width: MediaQuery.of(context).size.width / 1.2,
                //               height: MediaQuery.of(context).size.height / 6,
                //               child: Text(
                //                 document.data.toString(),
                //                 // document.id,
                //               )),
                //         ),
                //       ],
                //     );
                //   }).toList(),
                // );

                for (int i = 0; i < snapshot.data!.size; i++) {
                  DocumentSnapshot course = snapshot.data!.docs[i];
                  print(snapshot.data!.size);
                  print(course['votingchoices']['downloadUrl']);
                  print(course['votingchoices']['Ballot'].toString());
                  // Ballot b = Ballot.fromMap(Map<String, dynamic> );
                  print("Len");
                  // len(course['votingchoices']['Ballot'][{[]}.length]);
                  print(course['votingchoices']['Ballot'][{[]}.length]);
                  print("LenEND");
                  // for (int j = 0; j < snapshot.data!.size; j++) {

                  //   print(course['votingchoices']['Ballot'].toString());
                  // }
                  ;
                  // List<Ballot>
                  ballotList = course['votingchoices']['Ballot']
                      .map<Ballot>((x) => Ballot.fromMap(x))
                      .toList();
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
                }

                ;
                // **********
                List<VoteResults> voteResult2 = [];

                void createVoteListForGraph2() {
                  // for (int i = 0; i < balList.length; i++) {
                  for (int i = 0; i < balList2.length; i++) {
                    Color _randomColor = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                    print(balList2[i].option);
                    int votes = balList2[i].vote;
                    //  VoteResult.add() VoteResults[balList][i].option);
                    VoteResults vr = VoteResults(
                        balList2[i].option, votes + 1, _randomColor);
                    print(balList2[i].vote);
                    voteResult2.add(vr);
                    // setState(() {
                    //   voteResult2;
                    // });
                  }
                }

                createVoteListForGraph2();
                List<charts.Series<VoteResults, String>> series2 = [
                  charts.Series(
                      data: voteResult2,
                      id: "Voting Results",
                      domainFn: (VoteResults pops, _) => pops.option,
                      measureFn: (VoteResults pops, _) => pops.votes,
                      colorFn: (VoteResults pops, _) =>
                          charts.ColorUtil.fromDartColor(pops.barColor))
                ];

                List<VoteResults> voteResult3 = [];

                void createVoteListForGraph3() {
                  // for (int i = 0; i < balList.length; i++) {
                  for (int i = 0; i < ballotList.length; i++) {
                    Color _randomColor = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                    print(ballotList[i].option);
                    int votes = ballotList[i].vote;
                    //  VoteResult.add() VoteResults[balList][i].option);
                    VoteResults vr = VoteResults(
                        ballotList[i].option, votes + 1, _randomColor);
                    print(ballotList[i].vote);
                    voteResult3.add(vr);
                    // setState(() {
                    //   voteResult2;
                    // });
                  }
                }

                createVoteListForGraph3();

                createVoteListForGraph2();
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

                // return Expanded(
                //   child: ListView.builder(
                //     itemCount: snapshot.data!.size,
                //     itemBuilder: (BuildContext context, int index) {
                //       DocumentSnapshot course = snapshot.data!.docs[index];

                //       print(course.data());

                //       // var bal = Ballot.fromMap(course as Map<String, dynamic>);
                //       // bal.votescast;   Ballot.forEach(allot)
                //       // Ballot bdt =

                //       // print(snapshot.data!.size);
                //       // print(bal.option);

                //       stackVoteBalData2();

                //       // **********

                //       addBallots(
                //           course['votingchoices']['Ballot'][index].toString(),
                //           course['votingchoices']['Ballot'][index]['option']
                //               .toString());

                //       // **********

                //       printBalList2();
                //       // printdata();
                //       print("G:");
                //       print(balList2[0].option.toString());

                //       // newAdd();

                //       //  map =
                //       //     snapshot.data!.docs[index];
                //       // final coinLinks =   map["votingchoices"] as List<Map<String, dynamic>>;

                //       // return ListTile(
                //       //   title: Column(
                //       //       children: coinLinks.map((coinLink) {
                //       //     return Text(coinLink["description"]);
                //       //   }).toList()),
                //       // );
                //       // return ListTile(
                //       //   title: Text(
                //       //     course['description'],
                //       //   ),
                //       //   subtitle: Text(
                //       //       course['votingchoices']['Ballot'][index]['option']),
                //       // );
                //     },
                //   ),
                // );
              }),
        ),
        // Text(await printdata().toString()),
        // Text(balList2[0].vote.toString()),
        // Text(balList2[0].option.toString()),
        // Text(balList2[0].option.toString()),
        // Text(printdata().toString());

        SizedBox(
          height: 28,
        ),
        // Center(
        //   child: Container(
        //     width: MediaQuery.of(context).size.width / 1.2,
        //     height: MediaQuery.of(context).size.height / 6,
        //     child: Text(
        //       balList2[0].option
        //       // document.data.toString(),
        //       ,
        //       // "Some text",
        //     ),
        //   ),
        // ),
      ]),
    );
  }

  // Future<Text> printdata() async {
  //   return Text(await balList2[0].vote.toString());
  //   // Text(balList2[0].option.toString());
  //   // Text(balList2[0].option.toString());
  // }

  void printdata() async {
    print("BELOW");
    print(await balList2[0].vote.toString());
    // Text(balList2[0].option.toString());
    // Text(balList2[0].option.toString());
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

  // void addBallots(option, votes) {
  //   // balList2.clear();

  //   Ballot b = Ballot(option, int.parse('$votes'));
  //   balList2.add(b);
  //   print('BOO!');
  // }

  void addBallots(option, votes) {
    // balList2.clear();

    Ballot b = Ballot(option, int.parse('$votes'));
    balList2.add(b);
    print('BOO!');
  }

  stackVoteBalData2() async {
    return await FirebaseFirestore.instance
        .collection('opinion')
        .where('votingchoices.description',
            isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
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
              b = Ballot(
                  docSnapshot.data()['votingchoices']['Ballot'][i]['option'],
                  docSnapshot.data()['votingchoices']['Ballot'][i]['vote']),
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
}
