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
  String? userName;
  String? email;
  String? password;
  String? acctType;
  String? gender;
  int? age;
  DateTime? startDate;
  DateTime? endDate;

  // int? bank;

  // Account({this.uid});

  Account({
    required this.uid,
    this.name = "",
    this.surname = "",
    this.userName = "",
    this.email = "",
    this.password = "",
    this.acctType = "",
    this.age = 0,
    this.startDate = null,
    this.endDate = null,
  });

  Account.userid(
      {required this.uid,
      this.userName,
      this.email,
      this.password,
      this.startDate});
// Account.userid(this.uid);

  Map<String, dynamic> toJson() => {
        'uid': ['uid'],
        'name': ['name'],
        'surname': ['surname'],
        'userName': ['userName'],
        'email': ['email'],
        'password': ['password'],
        'acctType': ['acctType'],
        'gender': ['gender'],
        'age': ['age'],
        'startDate': ['startDate'],
        'endDate': ['endDate'],
      };

  Map<String, dynamic> toMap() => {
        "uid": this.uid,
        "name": this.name,
        "surname": this.surname,
        "userName": this.userName,
        "email": this.email,
        "password": this.password,
        "acctType": this.acctType,
        "gender": this.gender,
        "age": this.age,
        "startDate": this.startDate,
        "endDate": this.endDate,
      };

  Account.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        surname = map['surname'],
        userName = map['userName'],
        email = map['email'],
        password = map['password'],
        acctType = map['acctType'],
        gender = map['gender'],
        age = map['age'],
        startDate = map['startDate'].toDate(),
        endDate = map['endDate'].toDate();

  Account.fromJson(Map<String, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        surname = map['surname'],
        userName = map['userName'],
        email = map['email'],
        password = map['password'],
        acctType = map['acctType'],
        gender = map['gender'],
        age = map['age'],
        startDate = map['startDate'].toDate(),
        endDate = map['endDate'].toDate();

  static void createAccount(Account k) async {
    Map<String, dynamic> data = k.toMap();
    print(k.uid.toString());
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('account').add(data);
    print(docRef.id);
  }

// TODO: DELETE Account

// TODO: Get Sum of Mb already used before uploading images.

// TODO: Phase2:
// CREATE Group Lookup for Account (Group Name, Contact List)
// Delete Group
// Add to Group

// From onemapStartUP: https://www.youtube.com/watch?v=8v4V62GTQNs
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
}
