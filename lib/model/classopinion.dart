// *************** CLASS OPINION ***********************//

// ADD: user, date, surveyEndDate, private, multipleChoice

class Opinion {
  String? name;
  String? description;
  String? pollType;
  List<dynamic> sets = [];

  Opinion({this.name, this.description, this.pollType});
  Opinion.empty();
  Map<String, dynamic> toMap() => {
        "name": this.name,
        "description": this.description,
        "pollType": this.pollType,
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
        pollType = map['pollType'],
        sets = map['sets'].map((set) {
          return Set.fromMap(set);
        }).toList();

  Opinion.fromJson(Map<String, dynamic> json, param1)
      : name = json['name'],
        description = json['description'],
        pollType = json['pollType'],
        sets = json['sets'].json((set) {
          return Set.fromMap(set);
        }).toList();
}

// *************** CLASS SET ***********************//

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
        "votes": this.votes,
      };

  Set.fromMap(Map<String, dynamic> map)
// Can pass default value  '?? ""' otherwise get NULL error
      : item = map["item"] ?? "",
        downloadUrl = map["downloadUrl"],
        description = map["description"] ?? "",
        votes = map["votes"].toInt() ?? 0;
}

// *************** CLASS CHOICES ***********************//

class Choices {
  final String item;
  final String downloadUrl;
  final String description;
  final int votes;
  List<dynamic> votescast = [];

  Choices(this.item, this.downloadUrl, this.description, this.votes,
      this.votescast);

  Map<String, dynamic> toMap() => {
        "item": this.item,
        "downloadUrl": this.downloadUrl,
        "description": this.description,
        "votes": this.votes,
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
      // Can pass default value  '?? ""' otherwise get NULL error
      : item = map["item"] ?? "",
        downloadUrl = map["downloadUrl"],
        description = map["description"] ?? "",
        votes = map["votes"].toInt(),
        votescast = map['votescast'].map((votescast) {
          return Ballot.fromMap(votescast);
        }).toList();
}

// *************** CLASS BALLOT ***********************//

class Ballot {
  final String option;
  final int vote;
  String? voterid;
  DateTime? voteDate;

  Ballot(this.option, this.vote, this.voterid, this.voteDate);
  Ballot.voteSum(this.option, this.vote);

  Map<String, dynamic> toMap() => {
        "option": this.option,
        "vote": this.vote,
        "voterid": this.voterid,
        "voteDate": this.voteDate,
      };

  Ballot.fromMap(Map<String, dynamic> map)
      // Can pass default value  '?? ""' otherwise get NULL error
      : option = map["option"] ?? "",
        vote = map["vote"].toInt(),
        voterid = map["voterid"],
        voteDate = map["voteDate"].toDate();
}
