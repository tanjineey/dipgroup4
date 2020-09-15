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
                  SizedBox(height: 10,),
                  Text(
                    'PLAYGROUND',
                    style: TextStyle(
                      fontSize: 42,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        decoration: stepBoxDecoration(),
                        child: Text(
                          "Today's Step: 13345",
                          style: TextStyle(
                              fontSize: 22,
                              letterSpacing: 1.5,
                              color: Colors.grey[800]
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: goldenMouseBoxDecoration(),
                        child: Container(
                          color: Colors.redAccent,
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            "Golden Mouse Event is On!",
                            style: TextStyle(
                                fontSize: 22,
                                letterSpacing: 1.5,
                                color: Colors.black
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.30,
                    alignment: Alignment.center,
                    decoration: catAnimationBoxDecoration(),
                    child: Text(
                      'Cat in Exercise Animation',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(
                      "Let's work out!",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3.0),
                        child: RaisedButton(
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
                      ),
                      Container(
                          padding: EdgeInsets.all(3.0),
                          child: RaisedButton(
                              onPressed: () => showBottomSheet(context),
                              child: Text("Timer 2")
                          ),
                      ),
                    ],
                  ),


//need button to timer 2 here
                ],
              ),
              BottomNavBar(currentScreenId: ExerciseScreen.id),
            ],
          ),
        ));
  }
}

BoxDecoration stepBoxDecoration(){
  return BoxDecoration(
    border: Border.all(
      width: 2,
      color: Colors.cyan[400],
    )
  );
}

BoxDecoration goldenMouseBoxDecoration(){
  return BoxDecoration(
      border: Border.all(
        width: 5,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

BoxDecoration catAnimationBoxDecoration(){
  return BoxDecoration(
    border: Border.all(
      width: 2,
      color: Colors.cyan[200],
    ),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),

  );
}


// test test pls workkkk
