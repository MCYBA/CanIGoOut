import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/helpers/profile.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/page/home/profiles.dart';
import 'package:can_i_go_out/page/home/dialog.dart';
import 'package:can_i_go_out/constant/CustomFontIcons.dart';

class CalenderPNGPage extends StatefulWidget {
  CalenderPNGPage({
    Key key,
  }) : super(key: key);

  @override
  CalenderPNGPageState createState() => new CalenderPNGPageState();
}

class CalenderPNGPageState extends State<CalenderPNGPage>
    with AfterLayoutMixin<CalenderPNGPage>, TickerProviderStateMixin {
  static CalenderPNGPageState of(BuildContext context) =>
      context.findAncestorStateOfType();

  bool isProcessingAnimationVisible = false;

  DecorationImage tableImage = DecorationImage(
    image: AssetImage('assets/images/has_work.png'),
    fit: BoxFit.fill,
  );

  CalenderPNGPageState();

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    super.initState();

    if (globalProfileModel.hasWork) {
      tableImage = DecorationImage(
        image: AssetImage('assets/images/has_work.png'),
        fit: BoxFit.fill,
      );
    } else if (globalProfileModel.age <= 20) {
      tableImage = DecorationImage(
        image: AssetImage('assets/images/below_twenty.png'),
        fit: BoxFit.fill,
      );
    } else if (globalProfileModel.age >= 65) {
      tableImage = DecorationImage(
        image: AssetImage('assets/images/above_sixty_five.png'),
        fit: BoxFit.fill,
      );
    } else {
      tableImage = DecorationImage(
        image: AssetImage('assets/images/between_twenty-sixty_five.png'),
        fit: BoxFit.fill,
      );
    }
  }

  setProcessingAnimationVisibility(bool visibility) {
    setState(() {
      this.isProcessingAnimationVisible = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Color(0xff00A1A0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Container(
              height: 66,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 34,
                    width: 34,
                    margin: const EdgeInsets.only(left: 0.0),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 25),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 66,
                    width: 66,
                    margin: const EdgeInsets.only(left: 0.0),
                    child: GestureDetector(
                      child: Icon(CustomFontIcons.flaky_24px,
                          color: Colors.white, size: 66),
                      onTap: () {
//                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 66,
//                    width: screenSize.width,
                    child: Center(
                      child: Text(
                        "Sokağa Çıkabilir ",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 25.0,
                          color: Colors.white,
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
                          fontSize: 25.0,
                          color: Colors.black,
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
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: Container(
                    width: screenSize.width - 20,
                    height: screenSize.height - 200,
                    decoration: BoxDecoration(
                        image: this.tableImage
//                          border: Border.all(
//                            color: Colors.black87,
//                            width: 0.7,
//                          ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
