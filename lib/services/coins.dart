// // // // To parse this JSON data, do
// // // //
// // // //     final coins = coinsFromJson(jsonString);

// // // import 'dart:convert';

// // // Coins coinsFromJson(String str) => Coins.fromJson(json.decode(str));

// // // String coinsToJson(Coins data) => json.encode(data.toJson());

// // // class Coins {
// // //   Coins({
// // //     this.f00Docid = "",
// // //     this.f00User = "",
// // //     this.f01Surveyname = "",
// // //     this.f02Surveydescription = "",
// // //     this.f01Name = "",
// // //     this.f02Description = "",
// // //     this.f03Questionsexist = "",
// // //     this.items = const [],
// // //   });

// // //   String f00Docid;
// // //   String f00User;
// // //   String f01Surveyname;
// // //   String f02Surveydescription;
// // //   String f01Name;
// // //   String f02Description;
// // //   String f03Questionsexist;
// // //   List<Item> items;

// // //   factory Coins.fromJson(Map<String, dynamic> json) => Coins(
// // //         f00Docid: json["f00docid"],
// // //         f00User: json["f00user"],
// // //         f01Surveyname: json["f01surveyname"],
// // //         f02Surveydescription: json["f02surveydescription"],
// // //         f01Name: json["f01name"],
// // //         f02Description: json["f02description"],
// // //         f03Questionsexist: json["f03questionsexist"],
// // //         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
// // //       );

// // //   Map<String, dynamic> toJson() => {
// // //         "f00docid": f00Docid,
// // //         "f00user": f00User,
// // //         "f01surveyname": f01Surveyname,
// // //         "f02surveydescription": f02Surveydescription,
// // //         "f01name": f01Name,
// // //         "f02description": f02Description,
// // //         "f03questionsexist": f03Questionsexist,
// // //         "items": List<dynamic>.from(items.map((x) => x.toJson())),
// // //       };
// // // }

// // // class Item {
// // //   Item({
// // //     this.downloadUrl = "",
// // //     this.votes = "",
// // //   });

// // //   String downloadUrl;
// // //   String votes;

// // //   factory Item.fromJson(Map<String, dynamic> json) => Item(
// // //         downloadUrl: json["downloadUrl"],
// // //         votes: json["votes"],
// // //       );

// // //   Map<String, dynamic> toJson() => {
// // //         "downloadUrl": downloadUrl,
// // //         "votes": votes,
// // //       };
// // // }
// // // To parse this JSON data, do
// // //
// // //     final coins = coinsFromJson(jsonString);

// // import 'dart:convert';

// // Coins coinsFromJson(String str) => Coins.fromJson(json.decode(str));

// // String coinsToJson(Coins data) => json.encode(data.toJson());

// // class Coins {
// //   Coins({
// //     required this.f00Docid,
// //     required this.f00User,
// //     required this.f01Surveyname,
// //     required this.f02Surveydescription,
// //     required this.f01Name,
// //     required this.f02Description,
// //     required this.f03Questionsexist,
// //     required this.items,
// //   });

// //   String f00Docid;
// //   String f00User;
// //   String f01Surveyname;
// //   String f02Surveydescription;
// //   String f01Name;
// //   String f02Description;
// //   String f03Questionsexist;
// //   List<Item> items;

// //   factory Coins.fromJson(Map<String, dynamic> json) => Coins(
// //         f00Docid: json["f00docid"],
// //         f00User: json["f00user"],
// //         f01Surveyname: json["f01surveyname"],
// //         f02Surveydescription: json["f02surveydescription"],
// //         f01Name: json["f01name"],
// //         f02Description: json["f02description"],
// //         f03Questionsexist: json["f03questionsexist"],
// //         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "f00docid": f00Docid,
// //         "f00user": f00User,
// //         "f01surveyname": f01Surveyname,
// //         "f02surveydescription": f02Surveydescription,
// //         "f01name": f01Name,
// //         "f02description": f02Description,
// //         "f03questionsexist": f03Questionsexist,
// //         "items": List<dynamic>.from(items.map((x) => x.toJson())),
// //       };
// // }

// // class Item {
// //   Item({
// //     required this.downloadUrl,
// //     required this.votes,
// //   });

// //   String downloadUrl;
// //   String votes;

// //   factory Item.fromJson(Map<String, dynamic> json) => Item(
// //         downloadUrl: json["downloadUrl"],
// //         votes: json["votes"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "downloadUrl": downloadUrl,
// //         "votes": votes,
// //       };
// // }

// // To parse this JSON data, do
// //
// //     final coins = coinsFromJson(jsonString);

// // Coins coinsFromJson(String str) => Coins.fromJson(json.decode(str));

// // String coinsToJson(Coins data) => json.encode(data.toJson());

// import 'package:cloud_firestore/cloud_firestore.dart';

// class Coins {
//   Coins({
//     required this.surveyDesc,
//     required this.name,
//   });

//   String surveyDesc;
//   String name;

//   // factory Coins.fromJson(Map<String, dynamic> json) => Coins(
//   //       surveyDesc: json["surveyDesc"],
//   //       name: json["name"],
//   //     );

//   // Map<String, dynamic> toJson() => {
//   //       "surveyDesc": surveyDesc,
//   //       "name": name,
//   //     };

//   factory Coins.fromDocumentSnapshot(
//       {required DocumentSnapshot<Map<String, dynamic>> doc}) {
//     return Coins(
//       surveyDesc: doc.data()!["surveyDesc"],
//       name: doc.data()!["name"],
//     );
//   }

// // #######   NEw Method    #######

//   // DocumentReference reference;

//   // factory Coins.fromSnapshot(DocumentSnapshot snapshot) {

//   //   Coins newCoins = Coins.fromJson(snapshot.docs);
//   //   newCoins.reference = snapshot.reference;
//   //   return newCoins;
//   // }

//   // factory Coins.fromJson(Map<String, dynamic> json) => _CoinsFromJson(json);

//   Map<String, dynamic> toJson() => _CoinsToJson(this);

//   @override
//   String toString() => 'CoinsName $name';
// }

// Future<Coins> _CoinsFromJson(Map<String, dynamic> data) async {
//   return Coins(
//     name: data['name'] ?? '',
//     surveyDesc: data['surveyDesc'] ?? '',
//   );
// }

// Map<String, dynamic> _CoinsToJson(Coins instance) {
//   return {
//     'surveyDesc': instance.surveyDesc,
//     'name': instance.name,
//   };
// }
