// #############    KEEP for REF ###############

// late Opinion survey;
// List<Set> polloptions = [];
// List<Row> optionrow = [];

// List<Set> polloptionsx = [];

// int origVote = survey.sets[0].votes;

// // TODO: CREATE FOR LOOP and SUM the Total Votes.

// int origTotalVotes = survey.sets[0].votes;

// Future<void> readNestedData() async {
//   Opinion opinion;
//   // var bd =
//   await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("stJJiVVO821Z2U9NVv3I")
//       .get()
//       .then((docSnapshot) => {
//             opinion =
//                 Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//             opinion.sets.forEach((set) {
//               Set setInst = set as Set;
//               // log("Reps :" + setInst.reps.toString());
//               polloptions.add(set);
//               polloptionsx.add(setInst);
//             }),
//             print("Print TOP level Data:"),
//             print(opinion.description),
//             print("Print Lower level Data from ARRAY of  MAPS:"),
//             print(opinion.sets[0].votes),
//             survey = opinion,
//           });
// }

// void _printSets() {
//   for (int i = 0; i < polloptions.length; i++) {
//     // print(polloptions[i].votes);
//     print(polloptions[i].downloadUrl);
//     print(polloptions[i].votes);
//   }
// }

// #############     END ###############

// import 'package:cloud_firestore/cloud_firestore.dart';

// class opinion {
//   final String name;
//   final String muscle;
//   List<dynamic> sets = [
//     // {"reps": 10, "weight": 40},
//     // {"reps": 10, "weight": 40},
//     // {"reps": 10, "weight": 40}
//   ];

//   opinion(this.name, this.muscle);

//   Map<String, dynamic> toMap() =>
//       {"name": this.name, "muscle": this.muscle, "sets": this.sets};

// //   Food.fromMap(Map<String, dynamic> data) {
// //     id = data['id'];
// //     name = data['name'];
// //     category = data['category'];
// //     image = data['image'];
// //     subIngredients = data['subIngredients'];
// //     createdAt = data['createdAt'];
// //     updatedAt = data['updatedAt'];
// //   }

// }

// Future<void> SaveNestedData() async {
//   opinion opinion = opinion("Tricep Extension", "Triceps");
//   await FirebaseFirestore.instance
//       .collection("opinions")
//       .doc()
//       .set(opinion.toMap());
// }

// class opinion {
//   final String f01surveyname;
//   final String f02surveydescription;
//   List<dynamic> sets = [];

//   opinion(this.f01surveyname, this.f02surveydescription);

//   Map<String, dynamic> toMap() => {"f01surveyname": this.f01surveyname, "f02surveydescription": this.f02surveydescription, "sets": firestoreSets()};

//   List<Map<String,dynamic>> firestoreSets() {
//     List<Map<String,dynamic>> convertedSets = [];
//     this.sets.forEach((set) {
//       Set thisSet = set as Set;
//       convertedSets.add(thisSet.toMap();
//     });
//     return convertedSets;
//   }

//   opinion.fromMap(Map<dynamic, dynamic> map, this.f01surveyname, this.f02surveydescription)
//       : f01surveyname = map['f01surveyname'],
//         f02surveydescription = map['f02surveydescription'],
//         sets = map['sets'].map((set) {
//           return Set.fromMap(set);
//         }).toList();
// }

// class Food {
//   String id;
//   String name;
//   String category;
//   String image;
//   List subIngredients = [];
//   Timestamp createdAt;
//   Timestamp updatedAt;

//   Food();

//   Food.fromMap(Map<String, dynamic> data) {
//     id = data['id'];
//     name = data['name'];
//     category = data['category'];
//     image = data['image'];
//     subIngredients = data['subIngredients'];
//     createdAt = data['createdAt'];
//     updatedAt = data['updatedAt'];
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'image': image,
//       'subIngredients': subIngredients,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/screens/createsurvey.dart';
import 'package:moodclicks/services/createinitsurvey.dart';

class ViewSurvey extends StatefulWidget {
  const ViewSurvey({Key? key}) : super(key: key);

  @override
  _ViewSurveyState createState() => _ViewSurveyState();
}

class _ViewSurveyState extends State<ViewSurvey> {
  @override
  void initState() {
    super.initState();
    readNestedData();
    polloptions.clear();
  }

  late int voteTally = survey.sets[0].votes;

  void _castVote() {
    setState(() {
      voteTally += 1;
      voteTally = voteTally % (2);

      print(" ONe Vote  adde d");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("x. getcloudimages.dt"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (BuildContext context) => CreateSurvey()));
            //   },
            //   child: Text(
            //     'Start Survey',
            //   ),
            // ),
            Text("Heres your Survey Data:"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text("Get Survey From Firebase"),
                onPressed: () => readNestedData(),
              ),
            ),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: 40,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(survey.name),
                    Text(survey.sets[1].votes.toString()),
                    Text(voteTally.toString()),
                    // Text(survey.description),
                    ElevatedButton.icon(
                        icon: Icon(Icons.info),
                        label: Text("vote"),
                        onPressed: () => {
                              readNestedData(),
                              // voteTally = voteTally += 1 ,

                              _castVote(),
                              print(voteTally),
                              print('Sets Length:'),
                            }),
                    ElevatedButton.icon(
                        icon: Icon(Icons.info),
                        label: Text("Sets"),
                        onPressed: () => {
                              // print(polloptions[0].downloadUrl),
                              // print(polloptions.length.toString()),
                              // print(polloptions[0].downloadUrl),
                              _printSets()
                            }),
                    ElevatedButton.icon(
                        icon: Icon(Icons.info),
                        label: Text("poll"),
                        onPressed: () => {
                              // print(polloptions[0].downloadUrl),
                              // print(polloptions.length.toString()),
                              // print(polloptions[0].downloadUrl),
                              // _printPoll(),

                              // _clearPoll(),
                              // _loopSets(),

                              // print(survey.sets[0].votes),

                              // print(survey.sets.length),
                              _printSurvey(),
                              print("BREAK")
                            }),
                  ],
                ),
              ),
            ),
            Center(
              child: Text("Hello"),
            ),
            // Center(
            //   child: buildQlist(0),
            // ),
            Container(
              height: 200,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [buildQlist(2)],
              ),
            ),
            Container(
              height: 200,
              child: lviewB(),
            ),
            Center(
              child: Text("Hello ${voteTally}"),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildCol() {
  //   List<Row> colq = [];

  //   for (int i = 0; i < survey.sets.length; i++)
  //   colq.add(buildQlist(1));
  //    return colq;
  // }

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
}

late Opinion survey;
List<Set> polloptions = [];
List<Row> optionrow = [];

List<Set> polloptionsx = [];

int origVote = survey.sets[0].votes;

// TODO: CREATE FOR LOOP and SUM the Total Votes.

int origTotalVotes = survey.sets[0].votes;

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

void _printSets() {
  for (int i = 0; i < polloptions.length; i++) {
    // print(polloptions[i].votes);
    print(polloptions[i].downloadUrl);
    print(polloptions[i].votes);
  }
}

void _printPoll() {
  for (int i = 0; i < polloptionsx.length; i++) {
    // print(polloptions[i].votes);
    print(polloptionsx[i].downloadUrl);
    print(polloptionsx[i].votes);
    print("Helloo Space");
    print(polloptionsx.length);
  }
}

void _loopSets() {
  print(polloptionsx[1].downloadUrl);
  var lss = polloptionsx.map((set) {
    print(set.description);
    if (set.votes == 22) {
      print('upating ${set.votes}...');
      // car.name = "Tesla";
    }
    return set;
  });
}

void _clearPoll() {
  polloptionsx.clear();
}

void _printSurvey() {
  for (int i = 0; i < survey.sets.length; i++) {
    print(survey.sets[i].downloadUrl);
    print(survey.sets[i].votes);
  }
}

// List<Row> quws = [];

// Row  qStackBuild() {
//   for (int i = 0; i < survey.sets.length; i++) {
//     String dload = survey.sets[i].downloadUrl;
//     print(dload);
//     Row(
//       children: const <Widget>[
//         Expanded(child: Text('d')),
//         Expanded(
//           child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
//         ),
//         Expanded(
//           child: FittedBox(
//             fit: BoxFit.contain, // otherwise the logo will be tiny
//             child: FlutterLogo(),
//           ),
//         ),
//       ],
//     );
//   }
// }

//   //loop over mapped object collection
//   lss.forEach((car) => print("${car.name} is electric? ${car.isElectric}"));
// }

// Future<void> loopNestedSetsData() async {
//   Opinion opinion;
//   // var bd =
//   await FirebaseFirestore.instance
//       .collection("opinion")
//       .doc("stJJiVVO821Z2U9NVv3I")
//       .get()
//       .then((docSnapshot) => {
//             opinion =
//                 Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
//             opinion.sets.forEach((set) {
//               Set setInst = set as Set;
//               // log("Reps :" + setInst.reps.toString());
//               polloptions.add(set);
//             }),
//             print("Print TOP level Data:"),
//             print(opinion.description),
//             print("Print Lower level Data from ARRAY of  MAPS:"),
//             print(opinion.sets[0].votes),
//             survey = opinion,
//           });
// }
