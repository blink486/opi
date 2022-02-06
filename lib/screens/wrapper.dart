import 'package:flutter/material.dart';
import 'package:moodclicks/main.dart';
import 'package:moodclicks/model/account.dart';
import 'package:moodclicks/screens/authenticate/authenticate.dart';
import 'package:moodclicks/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return HomeScreen();
    final user = Provider.of<Account?>(context);
    // print(user!.uid);
    // return either Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
    // OR return CreateSurvey();
  }
}
