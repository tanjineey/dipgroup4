import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/shared/bottomNavBar.dart';
import '../../constants.dart';

class ShopScreen extends StatefulWidget {
  static String id = 'shop';
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool loading = false;

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
            children: [
              Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 80.0,
                  ),
                  Icon(
                    Icons.monetization_on,
                    color: Colors.blueGrey,
                    size: 50.0
                  ),
                  Container(
                    child: Text(
                      '{Amount of Gems}',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
              Container(),
              BottomNavBar(currentScreenId: ShopScreen.id)
            ],
          ),
        ));
  }
}
