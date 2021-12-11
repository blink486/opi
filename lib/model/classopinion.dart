import 'dart:convert';

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
  // final int choice;
  // final List<int> votescast;

  Set(this.item, this.downloadUrl, this.description, this.votes
      // , this.choice
      //     // this.votescast
      );

  Map<String, dynamic> toMap() => {
        "item": this.item,
        "downloadUrl": this.downloadUrl,
        "description": this.description,
        "votes": this.votes,
        // "choice": this.choice
        // "votescast": this.votescast
      };

  Set.fromMap(Map<String, dynamic> map)
      : item = map["item"] ?? "",
        // Can pass default value  '?? ""' otherwise get NULL error
        downloadUrl = map["downloadUrl"],
        description = map["description"] ?? "",
        votes = map["votes"].toInt() ?? 0;
  // choice = map["choice"].toInt() ?? 0;

  // votescast = map["votescast"];
}

// class Choices {
//   final String item;
//   final String downloadUrl;
//   final String description;
//   final int votes;
//   // final int choice;
//   final List<int> votescast;

//   Choices(
//       this.item,
//       this.downloadUrl,
//       this.description,
//       this.votes,
//       // this.choice
//       this.votescast);

//   Map<String, dynamic> toMap() => {
//         "item": this.item,
//         "downloadUrl": this.downloadUrl,
//         "description": this.description,
//         "votes": this.votes,
//         // "choice": this.choice
//         "votescast": this.votescast
//       };

//   Choices.fromMap(Map<String, dynamic> map)
//       : item = map["item"] ??
//             "", // Can pass default value  '?? ""' otherwise get NULL error
//         downloadUrl = map["downloadUrl"],
//         description = map["description"] ?? "",
//         votes = map["votes"].toInt(),
//         // choice = map["choice"].toInt();

//         votescast = map["votescast"];
// }

// //MY ATTEMPT

// *************** CLASS CHOICES ***********************//

class Choices {
  final String item;
  final String downloadUrl;
  final String description;
  final int votes;
  // final int choice;
  // List<dynamic> votescast;
  List<dynamic> votescast = [];

  Choices(
      this.item,
      this.downloadUrl,
      this.description,
      this.votes,
      // Future<List<Map>> addBallot,
      // this.choice
      this.votescast);

  Map<String, dynamic> toMap() => {
        "item": this.item,
        "downloadUrl": this.downloadUrl,
        "description": this.description,
        "votes": this.votes,
        // "choice": this.choice
        "Ballot": getBallot(),
      };

  List<Map<String, dynamic>> getBallot() {
    List<Map<String, dynamic>> convertedBallots = [];
    this.votescast.forEach((votescast) {
      Ballot thisvotescast = votescast as Ballot;
      convertedBallots.add(thisvotescast.toMap());
    });
    return convertedBallots;
  }

  Choices.fromMap(Map<String, dynamic> map)
      : item = map["item"] ??
            "", // Can pass default value  '?? ""' otherwise get NULL error
        downloadUrl = map["downloadUrl"],
        description = map["description"] ?? "",
        votes = map["votes"].toInt(),
        votescast = map['votescast'].map((votescast) {
          // return Set.fromMap(votescast);
          return Ballot.fromMap(votescast);
        }).toList();
}

// *************** CLASS BALLOT ***********************//

class Ballot {
  final String option;
  final int vote;

  Ballot(this.option, this.vote);

  Map<String, dynamic> toMap() => {
        "option": this.option,
        "vote": this.vote,
      };

  Ballot.fromMap(Map<String, dynamic> map)
      : option = map["option"] ??
            "", // Can pass default value  '?? ""' otherwise get NULL error
        // vote = map["vote"].toInt();
        vote = map["vote"].toInt();
}

  // List<Map<String, dynamic>> firestoreVotes() {
  //  List<Map<String, dynamic>> convertedVotes = [];
  //  this.votescast.forEach((votescast) {
  //        convertedVotes.add(votescast.toMap());
  //   });
  //   return convertedVotes;
  // }


// Choices choicesFromJson(String str) => Choices.fromJson(json.decode(str));

// String choicesToJson(Choices data) => json.encode(data.toJson());

// class Choices {
//     Choices(
//         this.item,
//         this.downloadUrl,
//         this.description,
//         this.votes,
//         this.votescast,
//     );

//    final String item;
//    final String downloadUrl;
//    final String description;
//    final String votes;
//    final List<dynamic> votescast;


//     factory Choices.fromJson(Map<String, dynamic> json) => Choices(
//         item: json["item"],
//         downloadUrl: json["downloadUrl"],
//         description: json["description"],
//         votes: json["votes"],
//         votescast: List<dynamic>.from(json["votescast"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "item": item,
//         "downloadUrl": downloadUrl,
//         "description": description,
//         "votes": votes,
//         "votescast": List<dynamic>.from(votescast.map((x) => x)),
//     };
// }



// ##################   OLD DELETE: ###########################

// Future<Opinion> Opinion.fromJson(Map<String, dynamic> data) async {
//   return Opinion(
//     name: data['name'] ?? '',
//     surveyDesc: data['description'] ?? '',
//      sets: data[firestoreSets()]

//   );
// }



  // TODO: ADD CLASS: VOTES List<dynamic> votes = [];
  // ADD: user, date, anonVote, vote Array[] (1:n possible votes )