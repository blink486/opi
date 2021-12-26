// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class FireToObj extends StatefulWidget {
//   const FireToObj({Key? key}) : super(key: key);

//   @override
//   _FireToObjState createState() => _FireToObjState();
// }

// class _FireToObjState extends State<FireToObj> {
//   late Stream<QuerySnapshot<Map<String, dynamic>>> dataList;

//   @override
//   void initState() {
//     // stackVoteBalData2();
//     // newAdd();
//     // createVoteListForGraph2();

// //  Stream<QuerySnapshot<Map<String, dynamic>>>
//     dataList = FirebaseFirestore.instance
//         .collection('opinion')
//         .where('votingchoices.description',
//             isEqualTo: 'w87f6S1H6ES4PPaehWxJUSERID')
//         .snapshots();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("chartsandvis3"),
//       ),
//       body: Center(
//         child: StreamBuilder(
//             stream: dataList,
//             builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
//               if (asyncSnapshot.hasError)
//                 return Text('Error: ${asyncSnapshot.error}');

//               switch (asyncSnapshot.connectionState) {
//                 case ConnectionState.none:
//                   return Text('No data');
//                 case ConnectionState.waiting:
//                   return Text('Awaiting...');
//                 case ConnectionState.active:
//                   // return ListView(
//                   //   children: asyncSnapshot.data
//                   //       .map((document) => Text(document['value'])),
//                   // );

//                   // for (int i = 0; i < 3; i++)
//                   //   DocumentSnapshot course = asyncSnapshot.data!;
//                   // print(asyncSnapshot.data());
//                   return ListView.builder(
//                     itemCount: asyncSnapshot.data!.size,
//                     itemBuilder: (BuildContext context, int index) {
//                       DocumentSnapshot course = asyncSnapshot.data!.docs[index];

//                       return ListTile(
//                         title: Text(
//                           course['description'],
//                         ),
//                         subtitle: Text(
//                             course['votingchoices']['Ballot'][index]['option']),
//                       );
//                     },
//                   );

//                 case ConnectionState.done:
//                   // return ListView(
//                   //   children: asyncSnapshot.data
//                   //       .map((document) => Text(document['value'])),
//                   // );
//                   print("Done");
//                   break;
//               }
//               return Text("DNO data");
//             }),
//       ),
//     );
//   }
// }
