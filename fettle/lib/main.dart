import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/avatar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/screens/home.dart';
import 'ui/screens/login.dart';
import 'ui/screens/food.dart';
import 'ui/screens/exercise.dart';
import 'ui/screens/sleep.dart';
import 'ui/screens/social.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState != ConnectionState.done) {
            return Container(color: Colors.black);
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => AuthProvider()),
                ChangeNotifierProxyProvider<AuthProvider, AvatarProvider>(
                  create: (ctx) => AvatarProvider(),
                  update: (ctx, auth, prevShop) => prevShop..update(auth),
                ),
              ],
              child: Consumer<AuthProvider>(builder: (ctx, auth, _) {
                Key key = new UniqueKey();
                return MaterialApp(
                    key: key,
                    title: 'Fettle',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    home: auth.isLoggedIn ? HomeScreen() : LoginScreen(),
                    routes: {
                      ExerciseScreen.id: (context) => ExerciseScreen(),
                      FoodScreen.id: (context) => FoodScreen(),
                      HomeScreen.id: (context) => HomeScreen(),
                      LoginScreen.id: (context) => LoginScreen(),
                      SleepScreen.id: (context) => SleepScreen(),
                      SocialScreen.id: (context) => SocialScreen(),
                    });
              }));
        });
  }
}

// test comment
//testing 123
