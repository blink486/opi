import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  // final String? uid;
  // late final String? name;
  // late final String? surname;
  // late final String? email;
  // late final String? password;
  // late final String? acctType;
  // late final int? age;
  // late final DateTime? startDate;

  String uid;
  String? name;
  String? surname;
  String? email;
  String? password;
  String? acctType;
  String? gender;
  int? age;
  DateTime? startDate;

  // int? bank;

  // Account({this.uid});

  Account({
    required this.uid,
    this.name = "",
    this.surname = "",
    this.email = "",
    this.password = "",
    this.acctType = "",
    this.age = 0,
    this.startDate = null,
  });

  Account.userid({required this.uid, this.name, this.email, this.password});
// Account.userid(this.uid);

  Map<String, dynamic> toJson() => {
        'uid': ['uid'],
        'name': ['name'],
        'surname': ['surname'],
        'email': ['email'],
        'password': ['password'],
        'acctType': ['acctType'],
        'gender': ['gender'],
        'age': ['age'],
        'startDate': ['startDate'],
      };

  Map<String, dynamic> toMap() => {
        "uid": this.uid,
        "name": this.name,
        "surname": this.surname,
        "email": this.email,
        "password": this.password,
        "acctType": this.acctType,
        "gender": this.gender,
        "age": this.age,
        "startDate": this.startDate,
      };

  Account.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        surname = map['surname'],
        email = map['email'],
        password = map['password'],
        acctType = map['acctType'],
        gender = map['gender'],
        age = map['age'],
        startDate = map['startDate'];

  Account.fromJson(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        surname = map['surname'],
        email = map['email'],
        password = map['password'],
        acctType = map['acctType'],
        gender = map['gender'],
        age = map['age'],
        startDate = map['startDate'];

  // factory Account.fromDocument(DocumentSnapshot doc){
  //   return Account(
  //       uid: doc.data()!["uid"],
  //       name: doc.data()!['name'],
  //       surname: doc.data()['surname'],

  //       email: doc.data()['email'],
  //               password: doc.data()['password'],
  //               acctType: doc.data()['acctType'],
  //               age: doc.data()['age'],
  //               startDate: doc.data()['startDate'],

  //   );
  // }

// From onemapStartUP: https://www.youtube.com/watch?v=8v4V62GTQNs

}
