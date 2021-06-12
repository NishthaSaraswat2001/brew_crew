// import 'package:brew_crew/services/auth.dart';
// import 'package:flutter/material.dart';

// class SignIn extends StatefulWidget {
//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   AuthServices _auth = AuthServices();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[100],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         title: Text('Sign in to Brew Crew'),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: RaisedButton(
//           child: Text('sign in anon'),
//           onPressed: () async {
//             dynamic result = await _auth.signInAnony();
//             if (result == null) {
//               print("error logging in");
//             } else {
//               print("logged in anony");
//               print("${result.uid}");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text("sign up"),
              onPressed: () {
                widget.toggleView();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (value) =>
                    value.isEmpty ? "Enter valid email" : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (value) =>
                    value.length < 6 ? "Enter password with 6+ char" : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink[400]),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      // print(email);
                      // print(password);
                      dynamic result = await _auth.signInWithEmailAndPasswaord(
                          email, password);
                      if (result == null) {
                        error = "could not sign in";
                      }
                    }
                  }),
              SizedBox(height: 20.0),
              Text(
                error,
              )
            ],
          ),
        ),
      ),
    );
  }
}
