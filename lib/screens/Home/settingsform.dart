import 'package:flutter/material.dart';
import 'package:moodclicks/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = 'Name';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Update your brew settings.',
              style: TextStyle(fontSize: 10.0),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextFormField(
              cursorColor: Colors.pink,
              decoration: textInputDecoration,
              validator: (val) => val!.isEmpty
                  ? 'Please enter a name'
                  : null, //NEED TO Make sure this TExt is shown in the form
              onChanged: (val) => setState(() => _currentName = val),
            ),
            // dropdown
            DropdownButtonFormField<String>(
              decoration: textInputDecoration,
              // value: _currentSugars ?? '0',
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  // value: _currentSugars == ' ' ? sugars[0] : sugars[0],
                  child: Text(
                    '$sugar sugars',
                    // style: TextStyle(backgroundColor: Colors.red),
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentSugars = val!),
            ),
            // Slider(
            //   min: 100,
            //   max: 900,
            //   divisions: 8,
            //   value: (_currentStrength ?? 100).toDouble(),
            //   activeColor: Colors.brown[_currentStrength ?? 100],
            //   inactiveColor: Colors.brown[_currentStrength ?? 100],
            //   onChanged: (val) =>
            //       setState(() => _currentStrength = val.round()),
            // ),
            // slider
            Slider(
              value: (_currentStrength ?? _currentStrength).toDouble(),
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
              min: 100,
              max: 900,
              divisions: 8,
              onChanged: (val) =>
                  setState(() => _currentStrength = val.round()),
            ),
            SizedBox(
              height: 12.0,
            ),

            TextButton(
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                // print(_currentStrength);
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
