import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../constants.dart';
import 'package:health/health.dart';
import '../duntellmama.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FoodAI {
  static Future<Map<String, double>> getFoodPrediction({File photo}) async {
    Map<String, double> predictionMap = {};
    final FirebaseAuth _fAuth = FirebaseAuth.instance;
    User user = _fAuth.currentUser;
    // FirebaseStorage storage =
    //     new FirebaseStorage(storageBucket: 'gs://auth-cf4ea.appspot.com');
    // StorageReference reference = storage
    //     .ref()
    //     .child('user')
    //     .child(user.uid)
    //     .child(DateTime.now().millisecondsSinceEpoch.toString());
    // StorageUploadTask uploadTask = reference.putFile(photo);
    // StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    // String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
    String imageURL =
        'https://ucarecdn.com/76a65f56-fcfa-44b9-aa1f-c63938b4b797/-/scale_crop/1280x960/center/-/quality/normal/-/format/jpeg/mee-rebus.jpg';
    print('make request');
    dynamic response = await http.post('http://api.foodai.org/v1/classify',
        headers: {
          // HttpHeaders.authorizationHeader: "Bearer " + token,
          "Content-Type": "application/json"
        },
        body: json.encode({
          'image_url': imageURL,
          'num_tag': 10,
          'api_key': foodAIkey,
        }));
    print('request done');
    print(response.body);
    List results = json.decode(response.body)['food_results'];
    int itemsPredicted = results.length > 0 ? results[0].length : 0;
    try {
      for (var i = 0; i < itemsPredicted; i++) {
        predictionMap[results[i][0]] = double.parse(results[i][1]);
      }
    } catch (e) {
      print(e);
    }
    return predictionMap;
  }
}
