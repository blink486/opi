class Survey {
  final String name;
  final String? description;
  final DateTime? creationDate;
  final int? surveyType;
  final String? createdBy; //UserID
  final DateTime? surveyEndDate;
  final bool? privateSurvey;

  Survey(this.name, this.description, this.creationDate, this.surveyType,
      this.createdBy, this.surveyEndDate, this.privateSurvey);

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "description": this.description,
        "creationDate": this.creationDate,
        "createdBy": this.createdBy,
        "surveyEndDate": this.surveyEndDate,
        "privateSurvey": this.privateSurvey
      };

  Survey.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        description = map["description"],
        creationDate = map["creationDate"],
        surveyType = map["surveyType"],
        createdBy = map["createdBy"],
        surveyEndDate = map["surveyEndDate"],
        privateSurvey = map["privateSurvey"];
}


// import 'package:flutter/material.dart';

// class Survey extends StatefulWidget {
//   final String name;
//   final String description;
//   // final String id;
//   // final String userId;

//   const Survey({
//     Key? key,
//     required this.name,
//     required this.description,
//     // required this.id,
//     // required this.userId
//   }) : super(key: key);

//   @override
//   _SurveyState createState() => _SurveyState();
// }

// class _SurveyState extends State<Survey> {
//   // late String name;
//   int _index = 0;
//   List quotes = [
//     "Hello inspire 1",
//     "HEllo Inspire 2",
//     "Hello inspire 3",
//     "HEllo Inspire 4",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Center(
//               child: Text(quotes[_index % quotes.length]),
//             ),
//             Text("3.1 createinitsurvey.dt : NEW Survey Class Object Created"),
//             Padding(
//               padding: const EdgeInsets.all(28.0),
//               child: TextButton.icon(
//                 onPressed: _showQuote,
//                 icon: Icon(Icons.wb_sunny),
//                 label: Text("Inspire Me!"),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(28.0),
//               child: TextButton.icon(
//                 onPressed: _resetIndex,
//                 icon: Icon(Icons.wb_sunny),
//                 label: Text("REset Index"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _showQuote() {
//     print(_index);
//     setState(() {
//       _index += 1;
//     });
//   }

//   void _resetIndex() {
//     print(_index);
//     setState(() {
//       _index = 0;
//     });
//   }
// }
