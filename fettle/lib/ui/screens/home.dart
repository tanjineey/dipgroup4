import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../providers/auth.dart';
import '../components/home/onboarding/index.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _googleSignOut() async {
    setState(() => loading = true);
    Provider.of<AuthProvider>(context, listen: false).socialLogout();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Provider.of<AvatarProvider>(context).fetchBioData(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState != ConnectionState.done) {
            print(snapshot.error);
            return Container(color: mainBackgroundColor);
          }

          return Scaffold(
              backgroundColor: Provider.of<AvatarProvider>(context).onboarded
                  ? mainBackgroundColor
                  : darkBackgroundColor,
              body: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Sup, " + Provider.of<AvatarProvider>(context).name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Text(
                          "Height: " +
                              Provider.of<AvatarProvider>(context).heightString,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Text(
                          "Weight: " +
                              Provider.of<AvatarProvider>(context).weightString,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: mainButtonColor)),
                          color: mainButtonColor,
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Text("Logout",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          onPressed: () {
                            _googleSignOut();
                          },
                        ),
                      )
                    ],
                  ),
                  if (!Provider.of<AvatarProvider>(context).onboarded)
                    OnboardingModal()
                ],
              ));
        });
  }
}
