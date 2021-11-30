// import 'package:moodclicks/model/surveyo.dart';
// import 'package:moodclicks/services/coins.dart';

// class CoinServices {
//   static Future<Coins> getCoins() async {
//     late Coins smpcoin;

//     var snapshot = await FirebaseFireStore.collection("sample")
//         .docs('iQkfaDnPAag5nK22Z2QH')
//         .get();
// smpcoin = smpcoin.toJson(snapshot) as Coins;
//         return(smpcoin);

//     var documentsm = val.documents;
//     if (documentsm.hasData) {
//       try {
//         print("DATA Exits");
//         print("Active ${documentsm.length}");
//         return documentsm.map((document) {
//           Sample bookingList =

//           smpcoin = Coins.fromJson(Map<String, dynamic>.from(document.data));
//           smpcoin = coinsFromJson(document);

//           print(smpcoin);
//           print(document.documentID);

//           return smpcoin;
//           }).toList();
//         });
//       } catch (e) {
//         print("Exception $e");
//         print(val.toString());

//         return smpcoin;
//       }
//     }

//     return smpcoin;
//   }
// }




// class CoinServices {
//   static Future<Coins> getCoins() async {
//     var val = await FirebaseFireStore.collection("questions")
//         .docs('2HeifNo8JqL5R39U4n3y')
//         .snapshots;
//     var documentsm = val.documents;
//     if (documentsm.hasData) {
//       try {
//         print("Active ${documentsm.length}");
//         return documentsm.Json((document) {
//     Sample bookingList =

//     smpcoin = Coins.fromJson(Map<String, dynamic>.from(documentsm));

//           print(smpcoin);
//           print(document.documentID);

//           return smpcoin;
//         }).toList();
//       } catch (e) {
//         print("Exception $e");
//         print(val.toString());
//         return smpcoin;
//       }
//     }
//     return smpcoin;
//   }
// }
