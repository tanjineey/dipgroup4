import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../providers/auth.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        backgroundColor: mainBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: mainButtonColor)),
                    color: mainButtonColor,
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    onPressed: () {
                      _googleSignIn();
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
