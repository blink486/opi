class Exercise {
  final String name;
  final String surveyDesc;
  List<dynamic> sets = [];

  Exercise(this.name, this.surveyDesc);

  // factory Exercise.fromJson(dynamic json) {
  //   return Exercise(json['name'] as String, json['surveyDesc'] as String, Set.fromJson(json['sets']));
  // }

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "surveyDesc": this.surveyDesc,
        "sets": firestoreSets()
      };

  List<Map<String, dynamic>> firestoreSets() {
    List<Map<String, dynamic>> convertedSets = [];

    this.sets.forEach((set) {
      Set thisSet = set as Set;
      convertedSets.add(thisSet.toMap());
    });
    return convertedSets;
  }

  Exercise.fromMap(Map<dynamic, dynamic> map)
      : name = map['name'],
        surveyDesc = map['surveyDesc'],
        sets = map['sets'].map((set) {
          return Set.fromMap(set);
        }).toList();

// Added 20/11/2021:

  // Exercise.fromJson(Map<String, dynamic> json)
  //     : name = json["name"],
  //       surveyDesc = json["surveyDesc"],
  //       sets = json['sets'].json((set) {
  //         return Set.fromJson(set);
  //       }).toList();
}

class Set {
  // final String downloadUrl;
  // final int votes;
  String downloadUrl;
  int votes;

  Set(this.downloadUrl, this.votes);

//  Set.fromJson(Map<String, dynamic> jsonMap) {
//     // this.amount = double.parse(jsonMap['amount']);
//     this.downloadUrl = jsonMap['downloadUrl'];
//     this.votes = jsonMap['votes'];
//     // this.executedTime = DateTime.parse(jsonMap['executed_time']);
//   }

  Map<String, dynamic> toMap() =>
      {"downloadUrl": this.downloadUrl, "votes": this.votes};

  Set.fromMap(Map<dynamic, dynamic> map)
      : downloadUrl = map["downloadUrl"].toString(),
        votes = map["votes"].toInt();

// Added 20/11/2021:

  // factory Set.fromJson(dynamic json) {
  //   return Set(json['downloadUrl'] as String, json['votes'] as int);
  // }

}




// class Task {
//   String title;
//   bool completed;

//   Task({
//     required this.title,
//     this.completed = false,
//   });

//   Task.fromMap(Map<String, dynamic> map): title = map['title'],completed = map['completed'];

//   updateTitle(title) {
//     this.title = title;
//   }

//   Map toMap() {
//     return {
//       'title': title,
//       'completed': completed,
//     };
//   }
// }





// Future<String> _loadPhotoAsset() async {
//   return await rootBundle.loadString('assets/photo.json');
// }

// Future loadPhotos() async {
//   String jsonPhotos = await _loadPhotoAsset();
//   final jsonResponse = json.decode(jsonPhotos);
//   PhotosList photosList = PhotosList.fromJson(jsonResponse);
//   print("photos " + photosList.photos[0].title);
// }