import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../shared/buttons.dart';
import '../../../../constants.dart';
import 'dart:io';
import 'package:health/health.dart';

class OnboardingModal extends StatefulWidget {
  @override
  _OnboardingModalState createState() => _OnboardingModalState();
}

class _OnboardingModalState extends State<OnboardingModal> {
  bool loading = false;
  TextEditingController nameController = TextEditingController();
  bool enteredName = false;
  double height;
  double weight;
  Gender gender = Gender.Male;

  bool syncWithWearable;

  HealthFactory health = HealthFactory();

  List<HealthDataType> types = [
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.SLEEP_IN_BED,
  ];

  List<HealthDataPoint> healthData = [];

  @override
  void initState() {
    super.initState();
  }

  void fetchDeviceData() async {
    DateTime startDate = DateTime.utc(2001, 01, 01);
    DateTime endDate = DateTime.now();
    healthData = await health.getHealthDataFromTypes(startDate, endDate, types);
    healthData = HealthFactory.removeDuplicates(healthData);
    height = healthData
            .lastWhere((element) => element.type == HealthDataType.HEIGHT,
                orElse: null)
            ?.value
            ?.toDouble() ??
        1.6;
    weight = healthData
            .lastWhere((element) => element.type == HealthDataType.WEIGHT,
                orElse: null)
            ?.value
            ?.toDouble() ??
        50.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!enteredName)
      return Center(
          child: Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Hi! What's your name?"),
                  TextField(
                    autofocus: true,
                    autocorrect: false,
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Hockie'),
                  ),
                  MainButton(
                      onPressed: () {
                        if (nameController.text.length > 0)
                          setState(() => enteredName = true);
                      },
                      title: "That's me!")
                ],
              )));
    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.88,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Welcome to fettle, " + nameController.text + "!"),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Select your gender."),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () => setState(() => gender = Gender.Male),
                            child: Text("Male",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: gender == Gender.Male
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: gender == Gender.Male
                                        ? Colors.black
                                        : Colors.black54)),
                          ),
                          InkWell(
                            onTap: () => setState(() => gender = Gender.Female),
                            child: Text("Female",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: gender == Gender.Female
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: gender == Gender.Female
                                        ? Colors.black
                                        : Colors.black54)),
                          ),
                        ]),
                  ],
                ),
                if (height != null && weight != null)
                  Column(children: <Widget>[
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Look at that body.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(height.toString() + 'm',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(weight.toString() + 'kg',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ]),
                Column(children: <Widget>[
                  if (height == null || weight == null)
                    MainButton(
                        onPressed: fetchDeviceData,
                        title: ("Sync with " +
                            (Platform.isIOS ? 'Apple Health' : 'Google Fit'))),
                  if (height != null && weight != null)
                    MainButton(
                        onPressed: () => Provider.of<AvatarProvider>(context,
                                listen: false)
                            .saveBioData(
                                nameController.text, height, weight, gender),
                        title: 'Data is accurate. Continue.'),
                  if (height != null && weight != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: fetchDeviceData,
                          child: Text(
                            "Data not accurate? Change them in your " +
                                (Platform.isIOS
                                    ? 'Apple Health'
                                    : 'Google Fit') +
                                " app and tap here to resync.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted),
                          )),
                    )
                ]),
              ],
            )));
  }
}
