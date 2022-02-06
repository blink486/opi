//2021-12-26 KEEP for v1

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/screens/createsurvey.dart';
import 'package:moodclicks/services/auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("1.  questioncard.dt"),
      ),
      body: Column(children: <Widget>[
        Center(
          child: TextButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Card(),
              //   ),
              // );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CreateSurvey()));
            },
            child: Text(
              'Start Survey',
            ),

            // ),
          ),
        ),
        Text(
            // "Logged in User Via Providor: ${context.read<AuthService>().user?.uid}"),
            "Logged in User Via Providor: ${context.read<AuthService>().signInAnon()}"),
      ]),
    );
  }

  //   Future<void> _initDynamicLinks() async {

  //   FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) (
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //         final Uri deepLink = dynamicLink?.link;

  //         if (deepLink != null) {
  //           Navigator.pushNamed(context, deepLink.path);
  //         }
  //       },
  //       onError: (OnLinkErrorException e) async {
  //         Navigator.pushNamed(context, '/error');
  //       }
  //   ) ;

  //   final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
  //   final Uri deepLink = data?.link;

  //   if (deepLink != null) {
  //     Navigator.pushNamed(context, deepLink.path);
  //   }
  // }

}
