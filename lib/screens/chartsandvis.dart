// //   Script from:  Mins 7:35 @  https://www.youtube.com/watch?v=QshpV3gh708

// import 'dart:math';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:moodclicks/model/classopinion.dart';
// import 'package:moodclicks/model/testclass.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class alldata extends StatefulWidget {
//   const alldata({Key? key}) : super(key: key);

//   @override
//   _alldataState createState() => _alldataState();
// }

// class _alldataState extends State<alldata> {
//   // late Future futureDoc;

//   // _getDoc() async {
//   //   return await FirebaseFirestore.instance
//   //       .collection('opinion')
//   //       .doc('w87f6S1H6ES4PPaehWxJ')
//   //       .get();
//   // }
//   _getDoc() {
//     return FirebaseFirestore.instance
//         .collection('opinion')
//         .doc('ukYTOJ7sTkJ8S8yg38cv')
//         .get();

//     // return FirebaseFirestore.instance
//     //     .collection('opinion')
//     //     .where('votingchoices.description',
//     //         isEqualTo:
//     //             'w87f6S1H6ES4PPaehWxJUSERID') //TODO: This will eventually be the SurveyID
//     //     // .doc('stJJiVVO821Z2U9NVv3I')
//     //     // .orderBy('votingchoices.votes', descending: true) //NEED to CREATE Indexes in Firebase to use in compound queries
//     //     // .limit(1)
//     //     .get();
//   }

//   var queryrtn;

//   _getDoc2() {
//     // return FirebaseFirestore.instance

//     return FirebaseFirestore.instance
//         .collection('opinion')
//         .where('votingchoices.description',
//             isEqualTo:
//                 'w87f6S1H6ES4PPaehWxJUSERID') //TODO: This will eventually be the SurveyID
//         // .doc('stJJiVVO821Z2U9NVv3I')
//         // .orderBy('votingchoices.votes', descending: true) //NEED to CREATE Indexes in Firebase to use in compound queries
//         // .limit(1)
//         .get();
//   }

//   readgetDoc2() async {
//     // balList.clear();

//     // Ballot b = Ballot('10', 11);

//     // int blen;

//     await _getDoc2().then((snapshot) {
//       snapshot.docs.forEach((element) {
//         // chargePoints(element.id.toString());
//         String s = element.id.toString();
//         var b = element.data()['votingchoices']['Ballot'].length;
//         print("DocID:  {$s}");

//         for (int i = 0; i < b; i++) {
//           // print("blength:  $i");

//           var k = Ballot(element.data()['votingchoices']['Ballot'][i]['option'],
//               element.data()['votingchoices']['Ballot'][i]['vote']);
//           // Check Graph calc method before adding: balList below
//           // balList.add(k);
//           print(k.option);
//           print(k.vote);
//           // print(element.data()['votingchoices']['Ballot'][i]['vote']);
//         }

//         // print(b.toString());
//         // print(element.id);
//         // print(element.votingchoices.toString());
//       });
//     });
//   }

//   void printQry() {
//     print('RUNNING printQry');
//     var x = queryrtn.toString();
//     print(x);
//     print('END RUNNING printQry');
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getDoc();
//     _getDoc2();
//     readVoteData();
//     readNestedData();
//     printSample();
//     createVoteListForGraph();
//     // futureDoc = _getDoc();
//   }

//   late Choices cpx;
//   List<Ballot> balList = [];

//   stackVoteBalData() async {
//     balList.clear();

//     Ballot b = Ballot('10', 11);

//     int blen;

//     await _getDoc().then((docSnapshot) => {
//           blen = docSnapshot.data()['votescast']['Ballot'].length,
//           print("Length{$blen}"),
//           for (int i = 0; i < blen; i++)
//             {
//               b = Ballot(docSnapshot.data()['votescast']['Ballot'][i]['option'],
//                   docSnapshot.data()['votescast']['Ballot'][i]['vote']),
//               // balList.add(b.toMap());
//               print(b.option),
//               print(b.vote),
//               balList.add(b)
//             }
//         });
//   }

//   List<Ballot> balList2 = [];

//   stackVoteBalData2() async {
//     balList2.clear();

//     Ballot b = Ballot('10', 11);

//     int blen;

//     await _getDoc2().then((docSnapshot) => {
//           blen = docSnapshot.data()['votescast']['Ballot'].length,
//           print("Length{$blen}"),
//           for (int i = 0; i < blen; i++)
//             {
//               b = Ballot(docSnapshot.data()['votescast']['Ballot'][i]['option'],
//                   docSnapshot.data()['votescast']['Ballot'][i]['vote']),
//               // balList.add(b.toMap());
//               print(b.option),
//               print(b.vote),
//               balList2.add(b),
//               print(balList2.length)
//             }
//         });
//   }

//   void printBalList() {
//     for (int i = 0; i < balList.length; i++) {
//       print(balList[i].option);
//       print(balList[i].vote);
//     }
//   }

//   void printSample() {
//     print("HELLOOS");
//   }

//   // Colors barColor(int i) {
//   //   int x = i % 4;

//   //   Color s = Colors.black;

//   //   if (i == 1) {
//   //     return s;
//   //   } else
//   //     throw (error) {
//   //       print(error);
//   //     };
//   // }

//   List<VoteResults> voteResult = [];

//   void createVoteListForGraph() {
//     // for (int i = 0; i < balList.length; i++) {
//     for (int i = 0; i < balList.length; i++) {
//       Color _randomColor =
//           Colors.primaries[Random().nextInt(Colors.primaries.length)];
//       print(balList[i].option);
//       int votes = balList[i].vote;
//       //  VoteResult.add() VoteResults[balList][i].option);
//       VoteResults vr = VoteResults(balList[i].option, votes + 1, _randomColor);
//       print(balList[i].vote);
//       voteResult.add(vr);
//       setState(() {
//         voteResult;
//       });
//     }
//   }

//   List<VoteResults> voteResult2 = [];

//   void createVoteListForGraph2() {
//     // for (int i = 0; i < balList.length; i++) {
//     for (int i = 0; i < balList.length; i++) {
//       Color _randomColor =
//           Colors.primaries[Random().nextInt(Colors.primaries.length)];
//       print(balList2[i].option);
//       int votes = balList2[i].vote;
//       //  VoteResult.add() VoteResults[balList][i].option);
//       VoteResults vr = VoteResults(balList2[i].option, votes + 1, _randomColor);
//       print(balList2[i].vote);
//       voteResult2.add(vr);
//       setState(() {
//         voteResult2;
//       });
//     }
//   }

//   Future<void> readVoteData() async {
//     Choices choices;

//     Ballot b = Ballot('1', 1);
//     String x;
//     int blen;

//     _getDoc().then((docSnapshot) => {
//           blen = docSnapshot.data()['votescast']['Ballot'].length,

//           for (int i = 0; i < blen; i++)
//             b = Ballot(
//                 docSnapshot.data()['votescast']['Ballot'][i]['option'],
//                 // docSnapshot.data()['votescast']['Ballot'][i]['vote'].toInt),
//                 docSnapshot.data()['votescast']['Ballot'][i]['vote']),
//           // balList.add(b.toMap());
//           print(b.option),

//           x = docSnapshot.data()['votescast']['Ballot'][0]['option'].toString(),
//           print(x),
//           print(docSnapshot.data()['votescast']['Ballot'].length),
//           print("Loading CHOICES :  "),
//           //      {$docSnapshot.data()['votescast']['item'] as String} "),
//           print(x),
//           choices = Choices.fromMap(
//               docSnapshot.data()['votescast'] as Map<String, dynamic>),
//           choices.votescast.forEach((votescast) {
//             Ballot ballotInst = votescast['Ballot'] as Ballot;
//             // choices.votescast.add(votescast);

//             //   //   // Set setInst = set as Set;
//             //   //   // log("Reps :" + setInst.reps.toString());
//             //   //   // polloptions.add(set);
//             //   //   // polloptionsx.add(setInst);
//           }),
//           print(choices.description),
//           print("Print CHOICES level Data:"),
//           // print(choices.votescast[0].option),
//           // print(choices.votescast[0].vote.toString()),
//           print("Print CHOICES Lower level Data from ARRAY of  MAPS:"),
//           // print(choices.votescast[0]),
//           cpx = choices,
//         });
//   }

//   late Opinion opx;

//   Future<void> readNestedData() async {
//     Opinion opinion;
//     _getDoc().then((docSnapshot) => {
//           opinion = Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//           opinion.sets.forEach((set) {
//             Set setInst = set as Set;
//             // log("Reps :" + setInst.reps.toString());
//             // polloptions.add(set);
//             // polloptionsx.add(setInst);
//           }),
//           print("Print TOP level Data:"),
//           print(opinion.description),
//           print("Print Lower level Data from ARRAY of  MAPS:"),
//           print(opinion.sets[0].votes),
//           opx = opinion,
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<VoteResults, String>> series = [
//       charts.Series(
//           data: voteResult,
//           id: "Voting Results",
//           domainFn: (VoteResults pops, _) => pops.option,
//           measureFn: (VoteResults pops, _) => pops.votes,
//           colorFn: (VoteResults pops, _) =>
//               charts.ColorUtil.fromDartColor(pops.barColor))
//     ];
//     List<charts.Series<VoteResults, String>> series2 = [
//       charts.Series(
//           data: voteResult2,
//           id: "Voting Results",
//           domainFn: (VoteResults pops, _) => pops.option,
//           measureFn: (VoteResults pops, _) => pops.votes,
//           colorFn: (VoteResults pops, _) =>
//               charts.ColorUtil.fromDartColor(pops.barColor))
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("chartsandvis.dart"),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: _getDoc(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError)
//             return Center(
//               child: Text(snapshot.hasError.toString()),
//             );
//           return snapshot.hasData
//               ?
//               // Text("${printSnap2(snapshot)}")

//               Column(children: <Widget>[
//                   Center(
//                     child: Text(
//                       // "${snapshot.data!['name']}",
//                       // "${snapshot.data!['sets'][2]['downloadUrl']}",
//                       "${snapshot.data!['sets'].length}"
//                       "   "
//                       " ${snapshot.data!['name']}",

//                       style: TextStyle(
//                           color: Colors.amber,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Text(
//                     // "${snapshot.data!['name']}",
//                     // "${snapshot.data!['sets'][2]['downloadUrl']}",
//                     "${opx.sets[1].votes}"
//                     "   "
//                     " Huloo",
//                     style: TextStyle(
//                         color: Colors.amber,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height / 2,
//                           decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: charts.BarChart(series),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height / 2,
//                           decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: charts.BarChart(series2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     // "${snapshot.data!['name']}",
//                     // "${snapshot.data!['sets'][2]['downloadUrl']}",
//                     "${snapshot.data!['votescast']['Ballot'][0]['option']}"
//                     "   "
//                     "${snapshot.data!['votescast']['Ballot'][0]['vote']}",

//                     style: TextStyle(
//                         color: Colors.amber,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton.icon(
//                       icon: Icon(Icons.ac_unit),
//                       label: Text("RUN stackVoteBalData()"),
//                       onPressed: () => {
//                             print('Bravo!'),
//                             // createVoteListForGraph(),
//                             stackVoteBalData2(),
//                             print(balList.length),
//                           }),
//                   ElevatedButton.icon(
//                       icon: Icon(Icons.ac_unit),
//                       label: Text("Add to createVoteListForGraph"),
//                       onPressed: () => {
//                             print('Bravo!'),
//                             createVoteListForGraph2(),
//                             // stackVoteBalData(),
//                             print(balList.length),
//                           }),
//                   ElevatedButton.icon(
//                       icon: Icon(Icons.ac_unit),
//                       label: Text("View Results Charts Contents:"),
//                       onPressed: () => {
//                             print('Bravo2!'),
//                             print(voteResult
//                                 .length), //   cpx.votescast[1].option),
//                             print('Bravo2!  printBalList()'),
//                             printBalList()
//                           }),
//                   ElevatedButton.icon(
//                       icon: Icon(Icons.ac_unit),
//                       label: Text("Print Deep Query"),
//                       onPressed: () => {
//                             // print('Bravo2!'),
//                             // print(voteResult
//                             //     .length), //   cpx.votescast[1].option),
//                             // print('Bravo2!  printBalList()'),
//                             // printBalList(),
//                             printQry(),
//                             readgetDoc2()
//                           }),
//                   ElevatedButton.icon(
//                       icon: Icon(Icons.ac_unit),
//                       label: Text("TEXT Text"),
//                       onPressed: () => {
//                             // print('Bravo2!'),
//                             // print(voteResult
//                             //     .length), //   cpx.votescast[1].option),
//                             // print('Bravo2!  printBalList()'),
//                             // printBalList(),

//                             print(_getDoc().toString())
//                           }),
//                 ])
//               : Container();
//         },
//       ),
// //       StreamBuilder(
// //         stream: FirebaseFirestore.instance.collection('opinion').snapshots(),
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (!snapshot.hasData) {
// //             return Text('No Value');
// //           }
// // // 'return script below from bottom sections:
// // // https://stackoverflow.com/questions/67564852/flutter-firestore-i-have-a-streambuilder-that-returns-a-certain-field-from-al
// //           return ListView.builder(
// //               itemCount: snapshot.data!.docs.length,
// //               itemBuilder: (context, index) {
// //                 DocumentSnapshot course = snapshot.data!.docs[index];
// //                 return ListTile(title: Text(course['name']));
// //               });
// //         },
// //       ),
//     );
//   }
// }

// // void printSnap(AsyncSnapshot<DocumentSnapshot> snapshot) {
// //   for (int i = 0; i < snapshot.data!['sets'].length; i++);

// //   print('AsyncSnapshot<DocumentSnapshot> snapshot)');
// // }

// // Future<Text> printSnap2(AsyncSnapshot<DocumentSnapshot> snapshot) async {
// //   try {
// //     String words;
// //     if (snapshot.hasData) ;
// //     {
// //       for (int i = 0; i < snapshot.data!['sets'].length; i++)
// //         return Text(snapshot.data!['sets'].length.toString());
// //     }
// //   } catch (e) {
// //     print(e.toString());
// //   }
// //   throw Text('Nodata');
// //   // print('AsyncSnapshot<DocumentSnapshot> snapshot)');
// // }

// // void print_Opi() {
// //   print(opp.sets[0].votes);
// // }

// // late Opinion opp;

// // Future<dynamic> importData() async {
// //   var surveyData = await FirebaseFirestore.instance
// //       .collection("opinion")
// //       .doc("ukYTOJ7sTkJ8S8yg38cv")
// //       .get();
// //   try {
// //     if (surveyData.exists) ;
// //     {
// //       return surveyData;
// //     }
// //   } catch (e) {
// //     return Text(e.toString());
// //   }
// // }

// // class B {
// //   Future<Opinion?> createOpObjCl() async {
// //     late Opinion opiz;
// //     var opi = await importData().then((value) {
// //       opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
// //       opiz.sets.forEach((set) {
// //         Set setInst = set as Set;
// //       });
// //       print("Obj Return");
// //       print(opiz.name);
// //       opp = opiz;
// //       return opiz;
// //     });
// //     // print(opi.toString());
// //     print("Other Return");
// //     // return opiz;
// //   }
// // }

// class VoteResults {
//   late final String option;
//   late final int votes;
//   late final Color barColor;

//   VoteResults(this.option, this.votes, this.barColor);
// }

// // List<Choices> results = [];
// // List<VoteResults> voteResults = [];

// // void addResults(Opinion dataSet){
// //   List<Set> voteResults = [];
// //   Set voteLoop ;
// // for (int i = 0 ; i < dataSet.sets.length; i++)

// // voteResults.add(Set(dataSet.sets[i].item, dataSet.sets[i].downloadUrl, dataSet.sets[i].description, dataSet.sets[i].votecast[i].  votes));

// //     WorldPopulation('2016', 54, Colors.pink),
// //     WorldPopulation('2017', 23, Colors.purple),
// //     WorldPopulation('2018', 74, Colors.yellow),
// //     WorldPopulation('2019', 84, Colors.amber),
// //     WorldPopulation('2020', 94, Colors.green),
// //     WorldPopulation('2021', 99, Colors.black),

// // }
// //   ;

// // List<Set> results = [];
// // List<VoteResults> voteResults = [];

// // void addResults(Opinion dataSet){
// //   List<Set> voteResults = [];
// //   Set voteLoop ;
// // for (int i = 0 ; i < dataSet.sets.length; i++)

// // voteResults.add(Set(dataSet.sets[i].item, dataSet.sets[i].downloadUrl, dataSet.sets[i].description, dataSet.sets[i].votecast[i].  votes));

// //     WorldPopulation('2016', 54, Colors.pink),
// //     WorldPopulation('2017', 23, Colors.purple),
// //     WorldPopulation('2018', 74, Colors.yellow),
// //     WorldPopulation('2019', 84, Colors.amber),
// //     WorldPopulation('2020', 94, Colors.green),
// //     WorldPopulation('2021', 99, Colors.black),

// // }
// //   ;

