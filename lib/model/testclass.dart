import 'dart:convert';

class Testt {
  final String name;
  final List<Prefs> prefs;
  Testt({
    required this.name,
    required this.prefs,
  });

  Testt copyWith({
    required String name,
    required List<Prefs> prefs,
  }) {
    return Testt(
      name: name,
      prefs: prefs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'prefs': prefs.map((x) => x.toMap()).toList(),
    };
  }

  factory Testt.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      print("no data");
    }

    return Testt(
      name: map['name'],
      prefs: List<Prefs>.from(map['prefs']?.map((x) => Prefs.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
  factory Testt.fromJson(String source) => Testt.fromMap(json.decode(source));

  @override
  String toString() => 'Testt(name: $name, prefs: $prefs)';
}

class Prefs {
  final String first;
  final String second;
  Prefs({
    required this.first,
    required this.second,
  });

  Prefs copyWith({
    required String first,
    required String second,
  }) {
    return Prefs(
      first: first,
      second: second,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'second': second,
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) print("Null data dsdf");

    return Prefs(
      first: map['first'],
      second: map['second'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Prefs.fromJson(String source) => Prefs.fromMap(json.decode(source));

  @override
  String toString() => 'Prefs(first: $first, second: $second)';
}
