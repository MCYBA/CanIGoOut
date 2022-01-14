import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/helpers/profile.dart';
import 'package:can_i_go_out/helpers/advertisement.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/constant/CustomFontIcons.dart';
import 'package:can_i_go_out/page/setProfile/nameBar.dart';
import 'package:can_i_go_out/page/setProfile/ageBar.dart';
import 'package:can_i_go_out/page/setProfile/hasWorkCheckBar.dart';

class SetProfilePage extends StatefulWidget {
  final restartWidgetKey;

  SetProfilePage({
    Key key,
    this.restartWidgetKey,
  }) : super(key: key);

  @override
  SetProfilePageState createState() => new SetProfilePageState();
}

class SetProfilePageState extends State<SetProfilePage>
    with AfterLayoutMixin<SetProfilePage>, TickerProviderStateMixin {
  static SetProfilePageState of(BuildContext context) =>
      context.findAncestorStateOfType();

  MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['can i go out', 'beautiful apps'],
    contentUrl: 'https://github.com/MCYBA/CanIGoOut',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd _bannerAd;

  var nameWidgetKey = GlobalKey<NameBarState>();
  var ageWidgetKey = GlobalKey<AgeBarState>();
  var hasWorkCheckWidgetKey = GlobalKey<HasWorkCheckBarState>();

  String selectedName;
  String selectedAge;
  bool hasWorkCheck = false;
  List<int> workDays = <int>[];

  bool isProcessingAnimationVisible = false;

  SetProfilePageState();

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

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  setProcessingAnimationVisibility(bool visibility) {
    setState(() {
      this.isProcessingAnimationVisible = visibility;
    });
  }

  setSelectedName(String name) {
    this.selectedName = name;
  }

  setSelectedAge(String age) {
    this.selectedAge = age;
  }

  setTermsOfUseCheck(bool status) {
    this.hasWorkCheck = status;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
//      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Color(0xff3C3C3C),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Visibility(
                        visible: globalProfileModel != null,
                        child: Container(
                          height: screenSize.height / 15,
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 34,
                                  width: 34,
                                  margin: const EdgeInsets.only(left: 0.0),
                                  child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 25,
                                  ),
                                ),
                                Container(
                                  color: Color(0xff3C3C3C),
                                  width: 50,
                                  height: 34,
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 140,
                          width: 120,
                          margin: const EdgeInsets.only(left: 0.0),
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            child: Icon(CustomFontIcons.flaky_24px,
                                color: Color(0xff00A1A0), size: 100),
                            onTap: () {
//                          Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: screenSize.width / 9,
                      ),
                      Container(
                        height: screenSize.width / 6.85,
//                    width: screenSize.width,
                        child: Text(
                          "Sokağa Çıkabilir ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: screenSize.width / 8.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: screenSize.width / 9,
                      ),
                      Container(
                        height: screenSize.width / 6.85,
//                    width: screenSize.width,
                        child: Text(
                          "Miyim?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: screenSize.width / 8.5,
                            color: Color(0xff00A1A0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  NameBar(
                    key: nameWidgetKey,
                    selectedName: this.selectedName,
                    setSelectedName: this.setSelectedName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AgeBar(
                    key: ageWidgetKey,
                    selectedAge: this.selectedAge,
                    setSelectedAge: this.setSelectedAge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HasWorkCheckBar(
                    key: hasWorkCheckWidgetKey,
                    termsOfUseCheck: this.hasWorkCheck,
                    setTermsOfUseCheck: this.setTermsOfUseCheck,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 35,
                      width: screenSize.width - 60,
                      decoration: BoxDecoration(
                        color: Color(0xff00A1A0),
                        borderRadius: BorderRadius.circular(17.5),
                      ),
                      child: Center(
                        child: Text(
                          "Profili Ekle",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      bool registerAvailable = true;
                      if (this.selectedName == null) {
                        nameWidgetKey.currentState.checkState();
                        registerAvailable = false;
                      }
                      if (this.selectedAge == null) {
                        ageWidgetKey.currentState.checkState();
                        registerAvailable = false;
                      }
                      if (this.hasWorkCheck) {
                        this.workDays = hasWorkCheckWidgetKey.currentState.getWorkDays();
                        this.workDays.sort();
                        print("WorkDays: ${this.workDays}");
                      }

                      if (registerAvailable) {
                        FocusScope.of(context).unfocus();
                        this.setProcessingAnimationVisibility(true);

                        addProfile(this.selectedName, int.parse(this.selectedAge),
                            this.hasWorkCheck, this.workDays);

                        this.setProcessingAnimationVisibility(false);
                        Timer(Duration(milliseconds: 200), () {
                          widget.restartWidgetKey.currentState.restartApp();
                        });

                        setState(() {});
                      } else {
                        print("Register Not Available");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenSize.width - 70,
                    child: Center(
                      child: Text(
                        "Bu uygulama kanıt teşkil etmez. Hiç bir resmiyeti yoktur. Uygulamayı kullanarak bu yazılanları okumuş ve kabul etmiş olursunuz.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: this.isProcessingAnimationVisible,
              child: Opacity(
                opacity: 0.2,
                child: GestureDetector(
                  child: Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Visibility(
              visible: this.isProcessingAnimationVisible,
              child: Opacity(
                opacity: 0.2,
                child: GestureDetector(
                  child: Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    color: Colors.black,
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 1200)),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
