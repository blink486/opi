// ADD: user, date, surveyEndDate, private, multipleChoice
class Opinion {
  final String name;
  final String description;
  List<dynamic> sets = [];
  // TODO: ADD VOTES List<dynamic> votes = [];

// TODO: ADD PRIVATE METHOD TO KEEP ORIGINAL VOTE SCORE AND INCREMENT ONLY BY ONE

  Opinion(this.name, this.description);

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "description": this.description,
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

  Opinion.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        sets = map['sets'].map((set) {
          return Set.fromMap(set);
        }).toList();

  Opinion.fromJson(Map<String, dynamic> json, param1)
      : name = json['name'],
        description = json['description'],
        sets = json['sets'].json((set) {
          return Set.fromMap(set);
        }).toList();
}

// class Set {
//   final String downloadUrl;
//   final String item;
//   final int votes;

//   Set(this.downloadUrl, this.item, this.votes);

//   Map<String, dynamic> toMap() =>
//       {"downloadUrl": this.downloadUrl, "votes": this.votes};

//   Set.fromMap(Map<String, dynamic> map)
//       : downloadUrl = map["downloadUrl"],
//         item = map["item"] ?? "",
//         votes = map["votes"].toInt();
// }

class Set {
  final String item;
  final String downloadUrl;
  final String description;
  final int votes;

  Set(this.item, this.downloadUrl, this.description, this.votes);

  Map<String, dynamic> toMap() => {
        "item": this.item,
        "downloadUrl": this.downloadUrl,
        "description": this.description,
        "votes": this.votes
      };

  Set.fromMap(Map<String, dynamic> map)
      : item = map["item"] ??
            "", // Can pass default value  '?? ""' otherwise get NULL error
        downloadUrl = map["downloadUrl"],
        description = map["description"] ?? "",
        votes = map["votes"].toInt();
}

// Future<Opinion> Opinion.fromJson(Map<String, dynamic> data) async {
//   return Opinion(
//     name: data['name'] ?? '',
//     surveyDesc: data['description'] ?? '',
//      sets: data[firestoreSets()]

//   );
// }



  // TODO: ADD CLASS: VOTES List<dynamic> votes = [];
  // ADD: user, date, anonVote, vote Array[] (1:n possible votes )