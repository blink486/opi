import 'package:flutter/material.dart';
import 'package:moodclicks/services/auth_service.dart';
import 'package:moodclicks/shared/constants.dart';
import 'package:moodclicks/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text('Sign in to Zympoll'),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () async {
                      // await _auth.signOut();
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
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
                        obscureText: true,
                        validator: (value) => value!.length < 6
                            ? 'Enter a password 6+ Chars long'
                            : null,
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
                                .signInWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those creentials';
                                setState(() => loading = false);
                              });
                            }
                          }
                        },
                        child: Text('Sign IN'),
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
