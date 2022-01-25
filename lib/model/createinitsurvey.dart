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
        "surveyType": this.surveyType,
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
