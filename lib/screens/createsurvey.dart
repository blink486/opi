//2021-12-26 KEEP for v1

import 'package:flutter/material.dart';
import 'package:moodclicks/services/signup.dart';

import 'bug_info_page.dart';

class CreateSurvey extends StatefulWidget {
  const CreateSurvey({Key? key}) : super(key: key);

  @override
  _CreateSurveyState createState() => _CreateSurveyState();
}

class _CreateSurveyState extends State<CreateSurvey> {
  TextEditingController srvName = new TextEditingController();
  TextEditingController srvDescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String emojiHeart = '\u2764';

    return Scaffold(
      appBar: AppBar(
        title: Text("1.1 createsurvey -  Menu Page" /*+ widget.searchstr*/),
        //  actions: <Widget>[HomeNav()],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(34.0),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      emojiHeart + " Sign up and Create Survey",
                      style: TextStyle(fontSize: 18),
                    ),
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BugInfoPage(),
                    ),
                  );
                },
                child: Text(
                  emojiHeart + " BugInfoPage",
                  style: TextStyle(fontSize: 18),
                ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
