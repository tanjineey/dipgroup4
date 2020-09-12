import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../constants.dart';
import '../../shared/bottomNavBar.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../shared/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class timer1 extends StatefulWidget {
  const timer1({
    Key key,
  }) : super(key: key);

  @override
  _timer1State createState() => _timer1State();
}

class _timer1State extends State<timer1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('the timer is here hohoho'),
          ),
        ],
      ),
    );
  }
}
