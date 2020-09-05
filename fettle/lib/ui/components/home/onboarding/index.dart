import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../shared/buttons/mainButton.dart';
import '../../../../constants.dart';

class OnboardingModal extends StatefulWidget {
  @override
  _OnboardingModalState createState() => _OnboardingModalState();
}

class _OnboardingModalState extends State<OnboardingModal> {
  bool loading = false;
  TextEditingController nameController = TextEditingController();
  bool enteredName = false;
  double height = 160.0;
  double weight = 60.0;
  Gender gender = Gender.Male;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (enteredName)
      return Center(
          child: Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Welcome to fettle, " + nameController.text + "!"),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:
                            Text("Height: " + height.round().toString() + "cm"),
                      ),
                      Slider(
                          label: height.round().toString(),
                          max: 200,
                          min: 100,
                          value: height,
                          onChanged: (value) => setState(() => height = value)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:
                            Text("Weight: " + weight.round().toString() + "kg"),
                      ),
                      Slider(
                          label: weight.round().toString(),
                          max: 150,
                          min: 40,
                          value: weight,
                          onChanged: (value) => setState(() => weight = value)),
                    ],
                  ),
                  MainButton(
                      onPressed: () =>
                          Provider.of<AvatarProvider>(context, listen: false)
                              .saveBioData(
                                  nameController.text, height, weight, gender),
                      title: "Save Profile")
                ],
              )));
    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.88,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0), color: Colors.white),
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
  }
}
