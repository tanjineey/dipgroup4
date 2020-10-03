import 'package:flutter/material.dart';
import '../../screens/home.dart';
import '../../screens/food.dart';
import '../../screens/exercise.dart';
import '../../screens/sleep.dart';
import '../../screens/social.dart';
import '../../screens/shop.dart';

class BottomNavBar extends StatelessWidget {
  final String currentScreenId;
  final bool active;
  BottomNavBar({@required this.currentScreenId, this.active = true});

  Widget generateLink(Widget screen, String screenId, BuildContext context) {
    return InkWell(
        onTap: () => active
            ? Navigator.pushReplacement(context, FadeRoute(page: screen))
            : null,
        child: Text(screenId,
            style: TextStyle(
                fontWeight: currentScreenId == screenId
                    ? FontWeight.bold
                    : FontWeight.normal)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            generateLink(ShopScreen(), ShopScreen.id, context),
            generateLink(FoodScreen(), FoodScreen.id, context),
            generateLink(ExerciseScreen(), ExerciseScreen.id, context),
            generateLink(HomeScreen(), HomeScreen.id, context),
            generateLink(SleepScreen(), SleepScreen.id, context),
            generateLink(SocialScreen(), SocialScreen.id, context),
          ],
        ));
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (context, anim1, anim2, child) =>
                FadeTransition(opacity: anim1, child: child),
            transitionDuration: Duration(milliseconds: 300));
}
