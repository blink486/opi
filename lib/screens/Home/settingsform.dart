import 'package:flutter/material.dart';
import 'package:moodclicks/model/account.dart';
import 'package:moodclicks/model/user.dart';
import 'package:moodclicks/services/database.dart';
import 'package:moodclicks/shared/constants.dart';
import 'package:moodclicks/shared/loading.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<Account>(context);
    print(user.uid);
    // print(user.bank);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userdata = snapshot.data;
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
                      initialValue: userdata!.name,
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
                      value: userdata.sugars,
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

                    // slider
                    Slider(
                      value: (_currentStrength).toDouble(),
                      activeColor: userdata.strength != null
                          ? Colors.brown[userdata.strength]
                          : Colors.brown[_currentStrength],
                      // activeColor:  _currentStrength != null ? Colors.brown[_currentStrength]  : Colors.brown[_currentStrength],
                      // activeColor: Colors.brown[_currentStrength] ,
                      // inactiveColor: Colors.brown[_currentStrength],
                      inactiveColor: userdata.strength != null
                          ? Colors.brown[userdata.strength]
                          : Colors.brown[_currentStrength],
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
                        // print(_currentName);
                        // print(_currentSugars);
                        // print(_currentStrength);
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars, _currentName, _currentStrength);
                          Navigator.pop(context);
                        }
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
          } else {
            print("No User Data - Please Log in/Register");
            return Loading();
          }
        });
  }
}
