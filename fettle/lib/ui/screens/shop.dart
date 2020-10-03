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
                                text: "Flights"
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Column(
                                children: [
                                  Card(
                                    color: Colors.limeAccent[100],
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.image),
                                        Text('Kimono 35 coins'),
                                        RaisedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                              builder: (BuildContext context){
                                                  return AlertDialog(
                                                    content: Stack(
                                                      overflow: Overflow.visible,
                                                      children: [
                                                        Positioned(
                                                          right: -40.0,
                                                          top: -40.0,
                                                          child: InkResponse(
                                                            onTap: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: CircleAvatar(
                                                              child: Icon(Icons.close),
                                                              backgroundColor: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 20,
                                                          right: 20,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'Buy',
                                                                style: TextStyle(
                                                                  fontSize: 50
                                                                ),
                                                              ),
                                                              SizedBox(height: 50,),
                                                              Icon(Icons.image),
                                                              SizedBox(height: 50,),
                                                              Text(
                                                                  'Kimono for 35 coins?',
                                                                  style: TextStyle(
                                                                    fontSize: 20
                                                                  ),
                                                              ),
                                                              SizedBox(height: 50,),
                                                              RaisedButton(
                                                                onPressed: () {},
                                                                color: Colors.blue,
                                                                child: Text(
                                                                  'Buy',
                                                                  style: TextStyle(
                                                                      color: Colors.white
                                                                  ),
                                                                )
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                              }
                                            );
                                          },
                                          color: Colors.blue,
                                          child: Text(
                                            'Buy',
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Card(
                                      color: Colors.limeAccent[100],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.image),
                                          Text('Grass Skirt 35 coins'),
                                          RaisedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return AlertDialog(
                                                      content: Stack(
                                                        overflow: Overflow.visible,
                                                        children: [
                                                          Positioned(
                                                            right: -40.0,
                                                            top: -40.0,
                                                            child: InkResponse(
                                                              onTap: (){
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: CircleAvatar(
                                                                child: Icon(Icons.close),
                                                                backgroundColor: Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 20,
                                                            right: 20,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Take off',
                                                                  style: TextStyle(
                                                                      fontSize: 50
                                                                  ),
                                                                ),
                                                                SizedBox(height: 50,),
                                                                Icon(Icons.image),
                                                                SizedBox(height: 50,),
                                                                Text(
                                                                  'Before you can wear',
                                                                  style: TextStyle(
                                                                      fontSize: 20
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Grass Skirt',
                                                                  style: TextStyle(
                                                                      fontSize: 20
                                                                  ),
                                                                ),
                                                                SizedBox(height: 50,),
                                                                RaisedButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (BuildContext context){
                                                                            return AlertDialog(
                                                                              content: Stack(
                                                                                overflow: Overflow.visible,
                                                                                children: [
                                                                                  Positioned(
                                                                                    right: -40.0,
                                                                                    top: -40.0,
                                                                                    child: InkResponse(
                                                                                      onTap: (){
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: CircleAvatar(
                                                                                        child: Icon(Icons.close),
                                                                                        backgroundColor: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Positioned(
                                                                                    top: 20,
                                                                                    right: 20,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Text(
                                                                                          'Looking Good!',
                                                                                          style: TextStyle(
                                                                                              fontSize: 30
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(height: 50,),
                                                                                        Icon(Icons.image),
                                                                                        SizedBox(height: 50,),
                                                                                        Text(
                                                                                          'Grass Skirt',
                                                                                          style: TextStyle(
                                                                                              fontSize: 20
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(height: 50,),
                                                                                        RaisedButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            color: Colors.blue,
                                                                                            child: Text(
                                                                                              'Ok',
                                                                                              style: TextStyle(
                                                                                                  color: Colors.white
                                                                                              ),
                                                                                            )
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }
                                                                      );
                                                                    },
                                                                    color: Colors.blue,
                                                                    child: Text(
                                                                      'change',
                                                                      style: TextStyle(
                                                                          color: Colors.white
                                                                      ),
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                              );
                                            },
                                            color: Colors.green,
                                            child: Text(
                                              'Wear',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Card(
                                      color: Colors.limeAccent[100],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.image),
                                          Text('Kimono 35 coins'),
                                          RaisedButton(
                                            onPressed: () {},
                                            color: Colors.blue,
                                            child: Text(
                                              'Buy',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  Card(
                                      color: Colors.limeAccent[100],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.image),
                                          Text('Parasol 35 coins'),
                                          RaisedButton(
                                            onPressed: () {},
                                            color: Colors.blue,
                                            child: Text(
                                              'Buy',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              )
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


