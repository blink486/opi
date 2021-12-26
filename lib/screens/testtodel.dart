import 'package:flutter/material.dart';
import 'package:moodclicks/screens/adddetails.dart';

class HomeNav2 extends StatefulWidget {
  const HomeNav2({Key? key}) : super(key: key);

  @override
  _HomeNav2State createState() => _HomeNav2State();
}

class _HomeNav2State extends State<HomeNav2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Hellos"),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddDetails()));
              },
              child: Text(
                " < LOGIN >",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Text("Hellos"),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddDetails()));
              },
              child: Text(
                " < REGISTER >",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
