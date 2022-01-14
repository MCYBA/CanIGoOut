import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/helpers/profile.dart';
import 'package:can_i_go_out/helpers/advertisement.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/page/home/profiles.dart';
import 'package:can_i_go_out/page/home/dialog.dart';
import 'package:can_i_go_out/page/calender/main.dart';
//import 'package:can_i_go_out/page/calenderPng/main.dart';
import 'package:can_i_go_out/constant/CustomFontIcons.dart';


class HomePage extends StatefulWidget {
  final restartWidgetKey;

  HomePage({
    Key key,
    this.restartWidgetKey,
  }) : super(key: key);

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>
    with AfterLayoutMixin<HomePage>, TickerProviderStateMixin {
  static HomePageState of(BuildContext context) =>
      context.findAncestorStateOfType();

  final math.Random rng = new math.Random();
  int adCounter = 0;

  bool isProcessingAnimationVisible = false;

  MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['can i go out', 'beautiful apps'],
    contentUrl: 'https://github.com/MCYBA/CanIGoOut',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  HomePageState();

  @override
  void afterFirstLayout(BuildContext context) {
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show();
  }

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
  setProcessingAnimationVisibility(bool visibility) {
    setState(() {
      this.isProcessingAnimationVisible = visibility;
    });
  }

  resetState() {
    setState(() {});
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialsAdUnitId(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: globalIsOutEnable ? Color(0xff00A1A0) : Color(0xff3C3C3C),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Container(
              height: 66,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width / 13.7,
                  ),
                  Container(
                    height: 66,
                    width: 66,
                    margin: const EdgeInsets.only(left: 0.0),
                    child: GestureDetector(
                      child: Icon(
                          CustomFontIcons.flaky_24px,
                          color: globalIsOutEnable ? Colors.white : Color(0xff00A1A0),
                          size: 66
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width / 27.4,
                  ),
                  Container(
                    height: 66,
//                    width: screenSize.width,
                    child: Center(
                      child: Text(
                        "Sokağa Çıkabilir ",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: screenSize.width / 16.4,
                          color: globalIsOutEnable ? Colors.white : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 66,
//                    width: screenSize.width,
                    child: Center(
                      child: Text(
                        "Miyim?",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: screenSize.width / 16.4,
                          color: globalIsOutEnable ? Color(0xff3C3C3C) : Color(0xff00A1A0),
                        ),
                      ),
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ProfilesWidget(
              resetParentState: resetState,
            ),
            SizedBox(
              height: 10,
            ),
            DialogWidget(
              resetParentState: resetState,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 35,
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: screenSize.width - 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color: Colors.transparent,
                            width: 1
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        new Container(
//            width: screenSize.width / 4,
                          height: 20,
                          child: Text(
                            "Haftalık Programınıza Bakın",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(left: 0.0),
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 24
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
//                    this.adCounter++;
//                    final snackBar = const SnackBar(
//                      content: Text("Bu özellik hala geliştirme aşamasındadır."),
//                    );
//
//                    Scaffold.of(context).showSnackBar(snackBar);
//                  if(this.adCounter == 1) {
//                  } else {
//                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new CalenderPage()));
//                  }
//
//                  if(this.adCounter > 1) {
//                    this.adCounter = 0;
//                  }

                    _interstitialAd?.dispose();
                    _interstitialAd = createInterstitialAd()..load().then((value) {
                      if(value) {
                        _interstitialAd.show().then((value) {
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new CalenderPage()));
                        });
                      } else {
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => new CalenderPage(
                        )));
                      }
                    });
//                    Timer(Duration(seconds: 1), () {});
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}