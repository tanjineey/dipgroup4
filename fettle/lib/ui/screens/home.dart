import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
    initOnline();
  }

  void initOnline() {}

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}