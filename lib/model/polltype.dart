import 'package:flutter/material.dart';

class PollType {
  final int id;
  final String name;
  final String description;

  const PollType(
      {required this.id, required this.name, required this.description});

// TODO: add addional code from
// https://www.youtube.com/watch?v=WPge1ZuEeCQ
//@ time 9.18

}

class PollTypeSingle {
  final int? id;
  final String? name;
  final String? description;
  final String? imgLink;

  const PollTypeSingle(
      {required this.id,
      required this.name,
      required this.description,
      this.imgLink});

  // const PollTypeSingle.empty();

// TODO: add addional code from
// https://www.youtube.com/watch?v=WPge1ZuEeCQ
//@ time 9.18

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollTypeSingle &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          imgLink == other.imgLink;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ imgLink.hashCode;

// DELETE getId
  // Future<String> getId(PollTypeSingle p) async {
  //   String id = p.id.toString();
  //   return id;
  // }

}
