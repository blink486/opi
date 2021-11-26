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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
      .doc("stJJiVVO821Z2U9NVv3I")
      .get()
      .then((docSnapshot) => {
            opinion =
                Opinion.fromMap(docSnapshot.data() as Map<String, dynamic>),
            opinion.sets.forEach((set) {
              Set setInst = set as Set;
              // log("Reps :" + setInst.reps.toString());
              polloptions.add(set);
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
