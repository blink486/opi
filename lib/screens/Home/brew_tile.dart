import 'package:flutter/material.dart';
import 'package:moodclicks/model/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({Key? key, required this.brew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength!.toInt()],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name.toString()),
          subtitle: Text('Takes ${brew.sugars} sugars'),
        ),
      ),
    );
  }
}
