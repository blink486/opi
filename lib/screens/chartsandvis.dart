// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';

// class ImpCharts extends StatefulWidget {
//   const ImpCharts({Key? key}) : super(key: key);

//   @override
//   _ImpChartsState createState() => _ImpChartsState();
// }

// class _ImpChartsState extends State<ImpCharts> {
//   static final List<WorldPopulation> populationData = [
//     WorldPopulation('2016', 54, Colors.pink),
//     WorldPopulation('2017', 23, Colors.purple),
//     WorldPopulation('2018', 74, Colors.yellow),
//     WorldPopulation('2019', 84, Colors.amber),
//     WorldPopulation('2020', 94, Colors.green),
//     WorldPopulation('2021', 99, Colors.black),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<WorldPopulation, String>> series = [
//       charts.Series(
//           data: populationData,
//           id: "World Population",
//           domainFn: (WorldPopulation pops, _) => pops.year,
//           measureFn: (WorldPopulation pops, _) => pops.population,
//           colorFn: (WorldPopulation pops, _) =>
//               charts.ColorUtil.fromDartColor(pops.barColor))
//     ];

//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 2,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(10)),
//             child: charts.BarChart(series),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WorldPopulation {
//   final String year;
//   final int population;
//   final Color barColor;

//   WorldPopulation(this.year, this.population, this.barColor);
// }

//   Script from:  Mins 7:35 @  https://www.youtube.com/watch?v=QshpV3gh708

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/testclass.dart';

class alldata extends StatefulWidget {
  const alldata({Key? key}) : super(key: key);

  @override
  _alldataState createState() => _alldataState();
}

class _alldataState extends State<alldata> {
  // late Future futureDoc;

  // _getDoc() async {
  //   return await FirebaseFirestore.instance
  //       .collection('opinion')
  //       .doc('w87f6S1H6ES4PPaehWxJ')
  //       .get();
  // }
  _getDoc() {
    return FirebaseFirestore.instance
        .collection('opinion')
        .doc('w87f6S1H6ES4PPaehWxJ')
        .get();
  }

  @override
  void initState() {
    super.initState();
    _getDoc();

    readNestedData();

    // futureDoc = _getDoc();
  }

  late Opinion opx;

  Future<void> readNestedData() async {
    Opinion opinion;
    _getDoc().then((docSnapshot) => {
          opinion = Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
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
          opx = opinion,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("all data"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getDoc(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          return snapshot.hasData
              ?
              // Text("${printSnap2(snapshot)}")

              Column(children: <Widget>[
                  Center(
                    child: Text(
                      // "${snapshot.data!['name']}",
                      // "${snapshot.data!['sets'][2]['downloadUrl']}",
                      "${snapshot.data!['sets'].length}"
                      "   "
                      " ${snapshot.data!['name']}",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    // "${snapshot.data!['name']}",
                    // "${snapshot.data!['sets'][2]['downloadUrl']}",
                    "${opx.sets[2].votes}"
                    "   "
                    " Huloo",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ])
              : Container();
        },
      ),
//       StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('opinion').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Text('No Value');
//           }
// // 'return script below from bottom sections:
// // https://stackoverflow.com/questions/67564852/flutter-firestore-i-have-a-streambuilder-that-returns-a-certain-field-from-al
//           return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot course = snapshot.data!.docs[index];
//                 return ListTile(title: Text(course['name']));
//               });
//         },
//       ),
    );
  }
}

void printSnap(AsyncSnapshot<DocumentSnapshot> snapshot) {
  for (int i = 0; i < snapshot.data!['sets'].length; i++);

  print('AsyncSnapshot<DocumentSnapshot> snapshot)');
}

// Future<Text> printSnap2(AsyncSnapshot<DocumentSnapshot> snapshot) async {
//   try {
//     String words;
//     if (snapshot.hasData) ;
//     {
//       for (int i = 0; i < snapshot.data!['sets'].length; i++)
//         return Text(snapshot.data!['sets'].length.toString());
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//   throw Text('Nodata');
//   // print('AsyncSnapshot<DocumentSnapshot> snapshot)');
// }

Future<Text> printSnap2(AsyncSnapshot<DocumentSnapshot> snapshot) async {
  try {
    String words;
    if (snapshot.hasData) ;
    {
      for (int i = 0; i < snapshot.data!['sets'].length; i++)
        return Text(snapshot.data!['sets'].length.toString());
    }
  } catch (e) {
    print(e.toString());
  }
  throw Text('Nodata');
  // print('AsyncSnapshot<DocumentSnapshot> snapshot)');
}

void print_Opi() {
  print(opp.sets[0].votes);
}

late Opinion opp;

Future<dynamic> importData() async {
  var surveyData = await FirebaseFirestore.instance
      .collection("opinion")
      .doc("w87f6S1H6ES4PPaehWxJ")
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

class B {
  Future<Opinion?> createOpObjCl() async {
    late Opinion opiz;
    var opi = await importData().then((value) {
      opiz = Opinion.fromMap(value.data() as Map<String, dynamic>);
      opiz.sets.forEach((set) {
        Set setInst = set as Set;
      });
      print("Obj Return");
      print(opiz.name);
      opp = opiz;
      return opiz;
    });
    // print(opi.toString());
    print("Other Return");
    // return opiz;
  }
}




// class GetChoices extends StatefulWidget {
//   // final String documentId;

//   // GetChoices(this.documentId);

//   @override
//   _GetChoicesState createState() => _GetChoicesState();
// }

// class _GetChoicesState extends State<GetChoices> {
//   late Opinion opinion;

//   @override
//   Future<Widget> build(BuildContext context) async {
//     CollectionReference opinion_src =
//         FirebaseFirestore.instance.collection('opinion');

//     // return FutureBuilder<DocumentSnapshot>(
//     //   future: opinion_src.doc('2zHmv5oqetOQixD1OJBw').get(),
//     //   builder:
//     //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//     //     if (snapshot.hasError) {
//     //       return Text("Something went wrong");
//     //     }

//     //     if (snapshot.hasData && !snapshot.data!.exists) {
//     //       return Text("Document does not exist");
//     //     }

//     //     if (snapshot.connectionState == ConnectionState.done) {
//     //       // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//     //       // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//     //       opinion_src.doc('2zHmv5oqetOQixD1OJBw').get().then((docSnapshot) => {
//     //             opinion =
//     //                 Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//     //             opinion.sets.forEach((set) {
//     //               Set setInst = set as Set;
//     //               // log("Reps :" + setInst.reps.toString());
//     //               // polloptions.add(set);
//     //               // polloptionsx.add(setInst);
//     //             }),
//     //             print("Print TOP level Data:"),
//     //             print(opinion.description),
//     //             print("Print Lower level Data from ARRAY of  MAPS:"),
//     //             print(opinion.sets[0].votes),
//     //             // survey = opinion,
//     //           });
//     //       // return docSnapshot;
//     //     }

//     //     return Text("loading");
//     //   },
//     // );
//     FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance
//           .collection('opinion')
//           .doc('2zHmv5oqetOQixD1OJBw')
//           .get(),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError)
//           return Center(
//             child: Text(snapshot.hasError.toString()),
//           );
//         return snapshot.hasData
//             ? Text(
//                 "${snapshot.data!['name']}",
//                 style: TextStyle(
//                     color: Colors.amber,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               )
//             : Container();
//       },
//     );
//   }
// }
