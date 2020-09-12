import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/shared/bottomNavBar.dart';
import '../../constants.dart';
import '../components/exercise/timers/timer1.dart';

class ExerciseScreen extends StatefulWidget {
  static String id = 'exercise';
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool loading = false;

  void showBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: timer1(),
          );
        });
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
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(),
                  Text('lets work out'),
                  RaisedButton(
                      onPressed: () => showBottomSheet(context),
                      child: Text("Timer 1")
                      // onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => timer1()),
                      //   );
                      // },
                      // child: Text('Timer1'),
                      ),
                  Text('timer 2 button'),

//need button to timer 2 here
                ],
              ),
              BottomNavBar(currentScreenId: ExerciseScreen.id),
            ],
          ),
        ));
  }
}

// test test pls workkkk
