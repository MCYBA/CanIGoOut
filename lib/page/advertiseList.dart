import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'package:can_i_go_out/after_layout.dart';
import 'package:can_i_go_out/localization/localizations.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/helpers/main.dart';
import 'package:can_i_go_out/main.dart';
import 'package:can_i_go_out/constant/CustomFontIcons.dart';
import 'package:can_i_go_out/helpers/advertisement.dart';

class AdvertiseListPage extends StatefulWidget {

  AdvertiseListPage({Key key}) : super(key: key);

  @override
  AdvertiseListPageState createState() => new AdvertiseListPageState();
}

class AdvertiseListPageState extends State<AdvertiseListPage>
    with AfterLayoutMixin<AdvertiseListPage> {
  static AdvertiseListPageState of(BuildContext context) =>
      context.findAncestorStateOfType();
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  int additionAdvertiseCount = 7;

  List<Widget> _tiles = [];

  ScrollController _scrollController = ScrollController();
  var _scrollPhysics;

  AdvertiseListPageState();

  @override
  void afterFirstLayout(BuildContext context) {
//    this._scrollToBottom();
    RewardedVideoAd.instance.load(
        adUnitId: getRewardAdUnitId()
    ).then((value) {
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: getAppId());
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        print("REWARD AMOUNT IS $rewardAmount");
      }
      RewardedVideoAd.instance.load(
          adUnitId: getRewardAdUnitId()
      ).then((value) {
      });
    };

//    _pullAdvertisements();

    _scrollPhysics = ScrollPhysics();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("PULLING NEW ADS");
        _getMoreAdvertisementData();
      }
    });
  }

  _getMoreAdvertisementData() {
    _pullAdvertisements();

  }

  _pullAdvertisements() {
    for (int i = 0; i < this.additionAdvertiseCount; i++) {
      this._tiles.add(AdvertisementCard());
      setState(() {});
    }
  }

  _scrollToBottom() {
//    for(int i = 0; i < this.additionAdvertiseCount; i++) {
//
////      if(i == this.additionAdvertiseCount - 1) {
////        i = 0;
////        this._tiles.clear();
////        this._getMoreAdvertisementData();
////      }
//    }
    Timer(const Duration(seconds: 10), () {
      if(this._tiles.length > 100) {
        this._tiles.clear();
        this._getMoreAdvertisementData();
      }
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      this._scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: TOP_BAR_HEIGHT,
                  decoration: BoxDecoration(
                      color: Color(0xfffafafa),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black87,
                          width: cTBBottomLineHeight,
                        ),
                      )),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        child: Container(
                          height: TOP_BAR_HEIGHT - cTBBottomLineHeight,
//                          width: TOP_BAR_HEIGHT - cTBBottomLineHeight,
                          margin: const EdgeInsets.only(left: 0.0),
                          child: GestureDetector(
                            child: Center(
                              child: Text(
//                              AppLocalizations.of(context).text("Cancel"),
                                "Reward Ad",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15.0,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                            onTap: () {

                              RewardedVideoAd.instance.show().catchError((){
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return AlertDialog(
                                        title: Text('Rewarded Ad Could Not Showing'),
                                      );
                                    });
                              });
//                                  .catchError(() {
//                                print("Reward Ad not loaded");
//                              });

//                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: TOP_BAR_HEIGHT - cTBBottomLineHeight,
                        width: screenSize.width,
                        child: Center(
                          child: Text(
//                            AppLocalizations.of(context).text("Sokağa Çıkabilir Miyim?"),
                            "Sokağa Çıkabilir Miyim?",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15.0,
                              color: Color(0xff977cd5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        child: Container(
                          height: TOP_BAR_HEIGHT - cTBBottomLineHeight,
//                          width: TOP_BAR_HEIGHT - cTBBottomLineHeight,
                          margin: const EdgeInsets.only(left: 0.0),
                          child: GestureDetector(
                            child: Center(
                              child: Text(
//                              AppLocalizations.of(context).text("Refresh"),
                                "Refresh",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15.0,
                                  color: Color(0xff977cd5),
                                ),
                              ),
                            ),
                            onTap: () async {
//                              RewardedVideoAd.instance.show().catchError((){
//                                showDialog(
//                                    context: context,
//                                    builder: (context) {
//                                      Future.delayed(Duration(seconds: 2), () {
//                                        Navigator.of(context).pop(true);
//                                      });
//                                      return AlertDialog(
//                                        title: Text('Rewarded Ad Could Not Showing'),
//                                      );
//                                    });
//                              });

                              this._tiles.clear();
                              this._getMoreAdvertisementData();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screenSize.height - TOP_BAR_HEIGHT,
                  child: Scaffold(
//              resizeToAvoidBottomInset: false,
                    body: ListView.builder(
                      physics: _scrollPhysics,
                      shrinkWrap: true,
                      controller: _scrollController,
//                              itemExtent: ,
                      itemBuilder: (context, i) {
                        if (i == this._tiles.length) {
                          if ((this._tiles.length % this.additionAdvertiseCount) == 0) {
                            return Column(
                              children: <Widget>[
                                CupertinoActivityIndicator(),
                                SizedBox(
                                  height: 4,
                                )
                              ],
                            );
                          } else {
                            return Visibility(
                              visible: false,
                              child: Container(),
                            );
                          }
                        }
                        return this._tiles[i];
                      },
                      itemCount: (this._tiles.length % this.additionAdvertiseCount) == 0 &&
                          this._tiles.length > 0
                          ? this._tiles.length + 1
                          : this._tiles.length,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}

class AdvertisementCard extends StatefulWidget {

  AdvertisementCard({Key key}) : super(key: key);

  @override
  AdvertisementCardState createState() => new AdvertisementCardState();
}

class AdvertisementCardState extends State<AdvertisementCard>
    with AfterLayoutMixin<AdvertisementCard> {
  static AdvertisementCardState of(BuildContext context) =>
      context.findAncestorStateOfType();

  final _nativeAdController = NativeAdmobController();

  AdvertisementCardState();

  @override
  void afterFirstLayout(BuildContext context) {
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 107,
        width: screenSize.width,
//            padding: EdgeInsets.all(10),
//            margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        child: Column(
          children: <Widget>[
            SizedBox(
              height: 3.5,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 4,
                ),
                Container(
                  height: 100,
                  width: screenSize.width - 8,
//                                  padding: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.black87,
                      width: 0.7,
                    ),
                  ),
                  child: NativeAdmob(
                    // Your ad unit id

                    adUnitID: getNativeAdUnitId(),
                    numberAds: 3,
                    controller: _nativeAdController,
                    type: NativeAdmobType.banner,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
            SizedBox(
              height: 3.5,
            ),
          ],
        )
    );
  }
}