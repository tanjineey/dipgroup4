import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/shared/bottomNavBar.dart';
import '../../constants.dart';

class ShopScreen extends StatefulWidget {
  static String id = 'shop';
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top row for home button and displaying number of gems
              Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 60.0,
                  ),
                  SizedBox(width: 60,),
                  Icon(
                    Icons.monetization_on,
                    color: Colors.blueGrey,
                    size: 50.0
                  ),
                  Container(
                    child: Text(
                      '36,001',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  )
                ],
              ),
              // Shop Title
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  "SHOP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              // Tab Section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                child: DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: 460,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                                icon: Icon(
                                  Icons.card_giftcard,
                                ),
                                text: "Souvenir",
                            ),
                            Tab(
                                icon: Icon(Icons.flight),
                                text: "Flight"
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Text('a'),
                              Text('b')
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(currentScreenId: ShopScreen.id),
    );
  }
}


