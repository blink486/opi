import 'package:flutter/material.dart';
import 'package:moodclicks/services/auth_service.dart';
import 'package:moodclicks/shared/constants.dart';
import 'package:moodclicks/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  // Register({required this.toggleView});

  Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
// Textfield State : Could use 'TextEditingController' as I have done in my Original signup.dart Screen
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.greenAccent[100],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              elevation: 0,
              title: Text('Sign UP  to Zympoll'),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () async {
                      // await _auth.signOut();
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign In'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  //_formKey can be used later for validation checks
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        // keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (value) => value!.length < 6
                            ? 'Enter a password 6+ Chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          onSurface: Colors.red,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'please supply a valid email';
                                setState(() => loading = false);
                              });
                            }
                          }
                        },
                        child: Text('Register'),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.00),
                      )
                    ],
                  ),
                )),
          );
  }
}
