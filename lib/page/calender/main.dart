import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/helpers/profile.dart';
import 'package:can_i_go_out/helpers/enabledTime.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/page/home/profiles.dart';
import 'package:can_i_go_out/page/home/dialog.dart';
import 'package:can_i_go_out/constant/CustomFontIcons.dart';

class CalenderPage extends StatefulWidget {
  CalenderPage({
    Key key,
  }) : super(key: key);

  @override
  CalenderPageState createState() => new CalenderPageState();
}

class CalenderPageState extends State<CalenderPage>
    with AfterLayoutMixin<CalenderPage>, TickerProviderStateMixin {
  static CalenderPageState of(BuildContext context) =>
      context.findAncestorStateOfType();

  bool isProcessingAnimationVisible = false;

  List<List<int>> hoursOfDaysList;

  TextStyle _titleTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w200,
  );

  CalenderPageState();

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    hoursOfDaysList = getCalender(globalProfileModel);
  }

  setProcessingAnimationVisibility(bool visibility) {
    setState(() {
      this.isProcessingAnimationVisible = visibility;
    });
  }

  List<Widget> getHourRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
//            width: screenSize.width / 4,
        height: 50,
      ),
    );

    for (int i = 0; i < 24; i++) {
      String time = "";
      if (i < 10) {
        time = "0$i";
      } else {
        time = "$i";
      }

      rows.add(
        Container(
          width: screenSize.width / 9.13,
          height: 20,
          child: Center(
            child: Text(time, style: _titleTextStyle),
          ),
        ),
      );
    }
    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    return rows;
  }

  List<Widget> getMonRows() {
    List<Widget> rows = [];
//    rows.add(
//      SizedBox(
//        height: 5,
//      )
//    );
    rows.add(
      Container(
        width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("P.tesi", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
          width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[0][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
  }

  List<Widget> getTueRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("Salı", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[1][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
  }

  List<Widget> getWedRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("Çarş.", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[2][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
  }

  List<Widget> getThuRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("Perş.", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[3][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
  }

  List<Widget> getFriRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("Cuma", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[4][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
  }

  List<Widget> getSatRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("C.tesi", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[5][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
  }

  List<Widget> getSunRows() {
    List<Widget> rows = [];
    rows.add(
      Container(
width: screenSize.width / 8.6,
        height: 20,
        child: Center(
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(-90 / 360),
            child: Text("Paz", style: _titleTextStyle),
          ),
        ),
      ),
    );

    rows.add(
      SizedBox(
//            width: screenSize.width / 4,
        height: 10,
      ),
    );

    for (int i = 0; i < 24; i++) {
      rows.add(
        Container(
width: screenSize.width / 8.6,
          height: 20,
          color: this.hoursOfDaysList[6][i] == 0 ? Colors.white : Colors.red,
        ),
      );
    }

    return rows;
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
                    width: screenSize.width / 41.1,
                  ),
                  Container(
                    height: 34,
                    width: 25,
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
                    width: screenSize.width / 82.2,
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
                    width: screenSize.width / 82.2,
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
                          fontSize: screenSize.width / 16.4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xff3C3C3C),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: this.getHourRows(),
                    ),
                    Column(
                      children: this.getMonRows(),
                    ),
                    Column(
                      children: this.getTueRows(),
                    ),
                    Column(
                      children: this.getWedRows(),
                    ),
                    Column(
                      children: this.getThuRows(),
                    ),
                    Column(
                      children: this.getFriRows(),
                    ),
                    Column(
                      children: this.getSatRows(),
                    ),
                    Column(
                      children: this.getSunRows(),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
