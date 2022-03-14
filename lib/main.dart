import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/account.dart';
import 'package:moodclicks/screens/questioncard.dart';
import 'package:moodclicks/screens/surveydisplay2.dart';
import 'package:moodclicks/screens/votinghome.dart';
import 'package:moodclicks/screens/wrapper.dart';
import 'package:moodclicks/services/auth_service.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().signInAnon();
  //Added for 1manStUP
  await AuthService().getOrCreateUser();

// 1. BrewAppStart: MyApp()
  // runApp(MyApp());

  //myApp Start Home()
  // runApp(Home());

  // Emojo Picker

  // runApp(MultiProvider(
  //   providers: [
  //     Provider.value(value: AuthService()),
  //   ],
  //   // child: MaterialApp(home: HomePage()),
  //   child: MaterialApp(home: Wrapper()),
  // )
  //     // ,
  //     );

//2. myApp with multiprovider
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: AuthService()),
        // Provider.StreamProvider<Account?>.value(
        // value: AuthService().user,
        // initialData: null,
        // catchError: (_, __) {},
      ],
      child: MaterialApp(home: HomePage()),
      // child: MaterialApp(home: Wrapper()),
    ),
  );
}

// StreamProvider<Account?>.value(
//       value: AuthService().user,
//       initialData: null,
//       catchError: (_, __) {},

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Zympoll - Personal Stats',
//       routes: {
//         // '/': (context) => HomePage(),
//         '/': (context) => Wrapper(),
//         '/tutorials': (context) => TutorialsPage(),
//         '/error': (context) => ErrorPage(),
//         '/dylink': (context) => SurveyDisplay2(surveyId: ''),
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Account?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) {},
      child: MaterialApp(
        title: 'Zympoll - Personal Stats',
        routes: {
          // '/': (context) => HomePage(),
          '/': (context) => Wrapper(),
          '/tutorials': (context) => TutorialsPage(),
          '/error': (context) => ErrorPage(),
          // '/dylink': (context) => SurveyDisplay2(surveyId: ''),
          '/dylink': (context) => VotingChoices(surveyId: ''),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String _shortUrl = '';

  @override
  void initState() {
    super.initState();
    this._initDynamicLinks();
  }

  void _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print("1 Printing myIxD: dynamicLinkData.toString ");
      print(dynamicLinkData.link.toString());
      //  Navigator.pushNamed(context, dynamicLinkData.link.path);
      // Navigator.pushNamed(SurveyDisplay2(surveyId: 'tFISHjkrM1cXrfpmDMTS'));

      // id = 'tFISHjkrM1cXrfpmDMTS';
      // Uri deepLink = dynamicLinkData.link;

      // if (dynamicLinkData != null) {
      //   if (deepLink.queryParameters.containsKey('surveyId')) {
      //     print("Printing deepLink ");
      //     print(deepLink);
      //     String? id = deepLink.queryParameters['surveyId'];
      //     print("Printing id ");
      //     print(id);
      //     //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SurveyDisplay2(surveyId: id);
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             SurveyDisplay2(surveyId: '$id'),
      //       ),
      //     );
      //   }
      // }
      Uri id = dynamicLinkData.link;
      // ignore: unnecessary_null_comparison
      if (id != null) {
        String myid = id.queryParameters['surveyId'].toString();
        print("2 deeplink data " + id.queryParameters.values.first);
        print("3 Printing myID ");
        print(id);
        print('4 ANother Hello');
        print(id.queryParameters.values.first.toString());
        String myLinkId = id.queryParameters.values.first.toString();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                // SurveyDisplay2(surveyId: myLinkId),
                VotingChoices(surveyId: myLinkId),
          ),
        );
        setState(() {});
      } else {
        print("5 Printing dynamicLinkData ");
        print("6 deeplink data " + id.queryParameters.values.first);
        print(dynamicLinkData.toString());
        print("7 Printing DeepLink Ensd");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                // SurveyDisplay2(surveyId: 'zLrGyGzOgDgRAH4Wrq4d'),
                VotingChoices(surveyId: 'zLrGyGzOgDgRAH4Wrq4d'),
          ),
        );
      }
    }).onError((error) {
      print("8 ERROR on _initDynamicLinks()");
      print(error.toString());
    });
  }

  // Future<void> _createDynamicLink() async {
  static Future<String> _createDynamicLink(String surveyId) async {
    String _linkMessage;

    // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://opinzy.page.link',
      // link: Uri.parse('https://www.opinzy.com/surveyId?id=$surveyId'),
      link: Uri.parse('https://opinzy.page.link/surveyId?id=$surveyId'),
      androidParameters: const AndroidParameters(
        //  fallbackUrl: Uri.parse('https://www.bbc.co.uk'),
        // //default location if your App is not in Appstore yet
        packageName: 'com.example.moodclicks',
        minimumVersion: 1,
      ),
      // iosParameters: const IOSParameters(
      //   bundleId: 'io.invertase.testing',
      //   minimumVersion: '0',
      // ),
    );
    //  final Uri uri = await dynamicLinks.buildLink(parameters);
    Uri url;
    // if (short) {
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    url = shortLink.shortUrl;
    // } else {
    //   uri = uri = await dynamicLinks.buildLink(parameters);
    // setState(() {
    //   _linkMessage = url.toString();
    //   _isCreatingLink = false;
    // });

    // print(_linkMessage);
    // uri = await dynamicLinks.buildLink(parameters);

    // }
//   static Future<void> initDynamicLink() async {
//     dynamicLinks = FirebaseDynamicLinks.instance;
//     dynamicLinks.onLink.listen((dynamicLinkData) {
// //OnSuccess Here
//     }).onError((error) {
// //onError Here
//     });
//   }
    _linkMessage = url.toString();
    print('Message link $_linkMessage');
    return _linkMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: const Text('Create Link'),
              onPressed: () {
                _createDynamicLink('surveyId');
              },
            ),
            SelectableText(_shortUrl),
            ElevatedButton.icon(
                icon: Icon(Icons.ac_unit),
                label: Text("START Page (HOME)"),
                onPressed: () => {
                      print('Moving to ResultsChart CHARTS'),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (BuildContext context) => ImpCharts()))
                              builder: (BuildContext context) => Home()))
                      // FireToObj()))
                    }),
            // Text("CurrentLoggedInUser: ${AuthService().user?.uid}"),
            Text(
                "CurrentLoggedInUser: ${AuthService().signInAnon().toString()}"),
            OutlinedButton(
              child: const Text('Press to Print'),
              onPressed: () {
                print(
                    "HomePage Button Clicked by user: ${AuthService().signInAnon()}");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: const Center(
        child: const Text('Tutorials Page'),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: const Center(
        child: const Text('Error Page'),
      ),
    );
  }
}
