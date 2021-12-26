// //2021-12-26 KEEP for v1 - Maybe useful for sample code

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:moodclicks/model/classExercise.dart';
// import 'package:moodclicks/screens/crd.dart';

// class LastAt extends StatefulWidget {
//   const LastAt({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<LastAt> {
//   @override
//   Widget build(BuildContext context) {
//     String emojiSymb = '\u2765';
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Question Start"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(children: [
//           Center(
//             child: TextButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => Card(),
//                 //   ),
//                 // );

//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => Qcards()));
//               },
//               child: Text(
//                 'Start Survey 4rd',
//               ),
//               // ),
//             ),
//           ),
//           Center(
//             child: TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => Qcards()));
//                 readNestedData();
//                 print(ex.name);
//               },
//               child: Text(
//                 'Start Survey 4rd',
//               ),
//               // ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 height: 100,
//               ),
//               Container(
//                 child: Expanded(
//                   child: Text(
//                     '1. Taking into account the accommodation and services that Lochfield Park provides, do you think the rent for the property provides good value for money?',
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.left,
//                     softWrap: true,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(emojiSymb, style: TextStyle(fontSize: 44)),
//               Text(emojiSymb, style: TextStyle(fontSize: 44)),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(emojiSymb, style: TextStyle(fontSize: 44)),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(emojiSymb, style: TextStyle(fontSize: 44)),
//               Text(emojiSymb, style: TextStyle(fontSize: 44)),
//               Text(emojiSymb, style: TextStyle(fontSize: 44)),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Text(
//             "<<<<<<",
//             style: TextStyle(fontSize: 44, color: Colors.grey),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//         ]),
//       ),
//     );
//   }
// }

// // void AddObjectToArray() {
// //     Set set = Set(12, 40);
// //     Exercise exercise;
// //     Set newSet;
// //     FirebaseFirestore.instance
// //         .collection("exercises")
// //         .doc("OWXsZjJRy3jjWmaM3Rup")
// //         .get()
// //         .then((docSnapshot) => {
// //       newSet = Set(10, 30),
// //       exercise = Exercise.fromMap(docSnapshot),
// //       exercise.sets.add(newSet),
// //       FirebaseFirestore.instance.collection("exercises")
// //       .doc("OWXsZjJRy3jjWmaM3Rup")
// //       .set(exercise.toMap())});
// //   }

// // Future<void> ReadNestedData() async {
// //   Exercise exercise;
// //   var bd = await FirebaseFirestore.instance.collection("exercises").doc("OWXsZjJRy3jjWmaM3Rup").get().then((docSnapshot) =>
// //   {
// //     exercise = Exercise.fromMap(docSnapshot.data()),
// //     exercise.sets.forEach((set) {
// //       Set setInst = set as Set;
// //       // log("Reps :" + setInst.reps.toString());
// //     })
// //   });
// // }

// late Exercise ex;

// Future<void> readNestedData() async {
//   Exercise exercise;
//   var bd = await FirebaseFirestore.instance
//       .collection("exercises")
//       .doc("pc4rmnEUhziXZmvkAwSq")
//       .get()
//       .then((docSnapshot) => {
//             exercise =
//                 Exercise.fromMap(docSnapshot.data() as Map<String, dynamic>),
//             exercise.sets.forEach((set) {
//               Set setInst = set as Set;
//               // log("Reps :" + setInst.reps.toString());
//             }),
//             print("Print TOP level Data:"),
//             print(exercise.muscle),
//             print("Print Lower level Data from ARRAY of MAPS:"),
//             print(exercise.sets[0].reps),
//             ex = exercise
//           });
// }
      
      
      
      
//       // then((value) => {
//       //       print(value.data())
//       //       exercise = Exercise.fromJson(value as Map<String, dynamic>),
//       //       exercise.sets.forEach((set) {
//       //         Set setInst = set as Set;})
            
//       //     });
//   // ) =>
//   // {
//   //   exercise = Exercise.fromMap(docSnapshot.data()),
//   //   exercise.sets.forEach((set) {
//   //     Set setInst = set as Set;
//   //     // log("Reps :" + setInst.reps.toString());
//   //   })

