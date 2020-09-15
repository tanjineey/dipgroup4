import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../providers/auth.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController _smsCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  String verificationId = "";
  String countryCode = "+65";

  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      setState(() => loading = true);

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      User user = result.user;
      await Provider.of<AuthProvider>(context, listen: false).smsLogin(user);
      setState(() => loading = false);
    };

    final PhoneVerificationFailed verificationFailed = (authException) {
      setState(() {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      setState(() {});
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    var firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: countryCode + _phoneNumberController.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber(String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    setState(() => loading = true);

    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    User user = result.user;

    await Provider.of<AuthProvider>(context, listen: false).smsLogin(user);
    setState(() => loading = false);
  }

  Widget renderSMSTextfield() {
    if (verificationId == "") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 25.0),
              child: TextField(
                cursorColor: Color(0xfff53b57),
                onChanged: (e) => countryCode + _phoneNumberController.text,
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "DIan Hua Number",
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(50, 25, 50, 25),
        child: TextField(
          cursorColor: Color(0xfff53b57),
          onChanged: (e) {
            if (e.length == 6) _signInWithPhoneNumber(_smsCodeController.text);
          },
          controller: _smsCodeController,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              fontSize: 16.0,
              color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
            hintText: "Enter 6 digit code here",
            hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: "WorkSansSemiBold",
                fontSize: 16.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading
                ? SpinKitFadingCube(
                    color: Color(0xfff53b57),
                    size: 100.0,
                  )
                : Center(
                    child: Column(
                      children: <Widget>[
                        renderSMSTextfield(),
                        verificationId == ""
                            ? Container(
                                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                child: RaisedButton(
                                  onPressed: () {
                                    _sendCodeToPhoneNumber();
                                  },
                                  color: Color(0xfff53b57),
                                  child: Text(
                                    "SEND SMS CODE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                // showInSnackBar("Login button pressed"))
                              )
                            : Container(
                                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                child: RaisedButton(
                                    onPressed: () {},
                                    color: Color(0xfff53b57),
                                    child: Text("SEND SMS CODE",
                                        style:
                                            TextStyle(color: Colors.white)))),
                      ],
                    ),
                  )
          ],
        ));
  }
}
