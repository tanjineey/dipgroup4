import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../providers/auth.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;

  void _googleSignIn() async {
    setState(() => loading = true);
    Provider.of<AuthProvider>(context, listen: false).socialLogin();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return SpinKitFadingCube(
        color: Color(0xfff53b57),
        size: 100.0,
      );

    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: RaisedButton(
          child: Text("hello"),
          onPressed: () {
            _googleSignIn();
          },
        )));
  }
}
