import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/shared/bottomNavBar.dart';
import '../../constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/foodAI.dart';

class FoodScreen extends StatefulWidget {
  static String id = 'food';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  bool loading = false;
  String imageSource = "Gallery";
  PickedFile imageFile;

  Map predictionMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(25),
                      child: RaisedButton(
                        child: Text('Predict'),
                        onPressed: () async {
                          // if (await Permission.camera.request().isGranted) {
                          //   ImagePicker imagePicker = new ImagePicker();
                          //   imageFile = await imagePicker.getImage(
                          //       source: ImageSource.camera, imageQuality: 30);
                          //   if (imageFile != null) {
                          //     setState(() => loading = true);
                          //     predictionMap = await FoodAI.getFoodPrediction(
                          //         File(imageFile.path));
                          //     setState(() => loading = false);
                          //   }
                          // }
                          setState(() => loading = true);
                          predictionMap = await FoodAI.getFoodPrediction();
                          setState(() => loading = false);
                        },
                      )),
                  if (loading)
                    SpinKitWave(
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ...List.generate(predictionMap.keys.length, (generator) {
                    return Column(
                      children: <Widget>[
                        Divider(),
                        Text('FOOD: ' + predictionMap.keys.toList()[generator]),
                        Text('Probability: ' +
                            predictionMap.values
                                .toList()[generator]
                                .toString()),
                        Divider(),
                      ],
                    );
                  })
                ],
              )),
              BottomNavBar(currentScreenId: FoodScreen.id)
            ],
          ),
        ));
  }
}
