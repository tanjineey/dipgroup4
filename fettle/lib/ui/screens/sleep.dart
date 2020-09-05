import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants.dart';
import '../components/shared/bottomNavBar.dart';
import 'package:provider/provider.dart';
import '../../providers/avatar.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../components/sleep/dreamDiary/index.dart';

class SleepScreen extends StatefulWidget {
  static String id = 'sleep';
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
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
            child: DreamDiary(),
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
        backgroundColor: Provider.of<AvatarProvider>(context).isSleeping
            ? Colors.black
            : mainBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Switch(
                          value: Provider.of<AvatarProvider>(context).autoSleep,
                          onChanged: (value) {
                            Provider.of<AvatarProvider>(context, listen: false)
                                .updateAutoSleep(value);
                          },
                          activeTrackColor: Colors.lightBlueAccent,
                          activeColor: Colors.blue,
                        ),
                        Text(
                          (Provider.of<AvatarProvider>(context).autoSleep
                                  ? ""
                                  : "Not ") +
                              "Syncing with " +
                              (Platform.isIOS ? 'Apple Health' : 'Google Fit'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Provider.of<AvatarProvider>(context).isSleeping
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    if (!Provider.of<AvatarProvider>(context).autoSleep)
                      Center(
                          child: RaisedButton(
                              onPressed: Provider.of<AvatarProvider>(context)
                                  .toggleSleepStatus,
                              child: Text(Provider.of<AvatarProvider>(context)
                                      .isSleeping
                                  ? 'Turn on the lights'
                                  : 'Turn off the lights'))),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () => showBottomSheet(context),
                                child: Text("Dream Diary",
                                    style: TextStyle(
                                      color:
                                          Provider.of<AvatarProvider>(context)
                                                  .isSleeping
                                              ? Colors.white
                                              : Colors.black,
                                    ))),
                            Text(
                              'Sleep Log',
                              style: TextStyle(
                                color: Provider.of<AvatarProvider>(context)
                                        .isSleeping
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              BottomNavBar(currentScreenId: SleepScreen.id)
            ],
          ),
        ));
  }
}
