import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/screens/home.dart';
import 'ui/screens/login.dart';

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
            print(snapshot.error);
            return Container(color: Colors.black);
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => AuthProvider()),
                // ChangeNotifierProxyProvider<AuthProvider, ContactsProvider>(
                //   builder: (context, auth, previousMessages) =>
                //       ContactsProvider(auth),
                // initialBuilder: (BuildContext context) => ContactsProvider(null),
                // ),
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
                      HomeScreen.id: (context) => HomeScreen(),
                      LoginScreen.id: (context) => LoginScreen(),
                    });
              }));
        });
  }
}

// test comment
//testing 123