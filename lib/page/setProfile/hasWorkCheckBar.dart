import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';


import 'package:http/http.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/constant/Constant.dart';
import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/localization/localizations.dart';

class HasWorkCheckBar extends StatefulWidget {
  final bool termsOfUseCheck;
  final Function setTermsOfUseCheck;

  const HasWorkCheckBar({
    Key key,
    this.termsOfUseCheck,
    this.setTermsOfUseCheck,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new HasWorkCheckBarState();
}

class HasWorkCheckBarState extends State<HasWorkCheckBar> {
  // 2.0 is the default from TextField class

  bool _radioValue = false;
  bool isCheckboxValid = true;
  bool hasWorkCheck = false;
  List<int> workDays = <int>[];
  bool allDaysValue = false;
  bool monValue = false;
  bool tueValue = false;
  bool wedValue = false;
  bool thuValue = false;
  bool friValue = false;
  bool satValue = false;
  bool sunValue = false;


  TextStyle _termTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
  );

  TextStyle _termLinkTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Color(0xff977cd5),
    fontSize: 12.0,
    fontStyle: FontStyle.normal,
  );

  HasWorkCheckBarState();

  @override
  initState() {
    super.initState();
    this.hasWorkCheck = widget.termsOfUseCheck != null ? widget.termsOfUseCheck : false;
  }

  checkState() {
//    if(!hasWorkCheck) {
//      isCheckboxValid = true;
//    }
    setState(() {});
  }

  List<int> getWorkDays() {
    return this.workDays;
  }

  Widget _buildDaySelectionWidget() {
    return Container(
      height: 42.5,
      width: screenSize.width,
      padding: EdgeInsets.only(left: 50),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.allDaysValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.allDaysValue = value;

                                  this.monValue = this.allDaysValue;
                                  this.tueValue = this.allDaysValue;
                                  this.wedValue = this.allDaysValue;
                                  this.thuValue = this.allDaysValue;
                                  this.friValue = this.allDaysValue;
                                  this.satValue = this.allDaysValue;
                                  this.sunValue = this.allDaysValue;
                                  if(value) {
                                    workDays.clear();
                                    workDays.add(DateTime.monday);
                                    workDays.add(DateTime.tuesday);
                                    workDays.add(DateTime.wednesday);
                                    workDays.add(DateTime.thursday);
                                    workDays.add(DateTime.friday);
                                    workDays.add(DateTime.saturday);
                                    workDays.add(DateTime.sunday);
                                  } else {
                                    workDays.remove(DateTime.monday);
                                    workDays.remove(DateTime.tuesday);
                                    workDays.remove(DateTime.wednesday);
                                    workDays.remove(DateTime.thursday);
                                    workDays.remove(DateTime.friday);
                                    workDays.remove(DateTime.saturday);
                                    workDays.remove(DateTime.sunday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "her gün"
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.allDaysValue = !this.allDaysValue;

                        this.monValue = this.allDaysValue;
                        this.tueValue = this.allDaysValue;
                        this.wedValue = this.allDaysValue;
                        this.thuValue = this.allDaysValue;
                        this.friValue = this.allDaysValue;
                        this.satValue = this.allDaysValue;
                        this.sunValue = this.allDaysValue;
                        if(this.allDaysValue) {
                          workDays.clear();
                          workDays.add(DateTime.monday);
                          workDays.add(DateTime.tuesday);
                          workDays.add(DateTime.wednesday);
                          workDays.add(DateTime.thursday);
                          workDays.add(DateTime.friday);
                          workDays.add(DateTime.saturday);
                          workDays.add(DateTime.sunday);
                        } else {
                          workDays.remove(DateTime.monday);
                          workDays.remove(DateTime.tuesday);
                          workDays.remove(DateTime.wednesday);
                          workDays.remove(DateTime.thursday);
                          workDays.remove(DateTime.friday);
                          workDays.remove(DateTime.saturday);
                          workDays.remove(DateTime.sunday);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.monValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.monValue = value;
                                  if(value) {
                                    workDays.add(DateTime.monday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.monday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "P.tesi"
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.monValue = !this.monValue;
                        if(this.monValue) {
                          workDays.add(DateTime.monday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.monday);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
//                  color: Colors.red,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.tueValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.tueValue = value;
                                  if(value) {
                                    workDays.add(DateTime.tuesday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.tuesday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Salı"
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.tueValue = !this.tueValue;
                        if(this.tueValue) {
                          workDays.add(DateTime.tuesday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.tuesday);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
//                  color: Colors.red,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.wedValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.wedValue = value;
                                  if(value) {
                                    workDays.add(DateTime.wednesday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.wednesday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Çarş."
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.wedValue = !this.wedValue;
                        if(this.wedValue) {
                          workDays.add(DateTime.wednesday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.wednesday);
                        }
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 4.5,
          ),
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
//                  color: Colors.red,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.thuValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.thuValue = value;
                                  if(value) {
                                    workDays.add(DateTime.thursday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.thursday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Perş."
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.thuValue = !this.thuValue;
                        if(this.thuValue) {
                          workDays.add(DateTime.thursday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.thursday);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
//                  color: Colors.red,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.friValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.friValue = value;
                                  if(value) {
                                    workDays.add(DateTime.friday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.friday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Cuma"
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.friValue = !this.friValue;
                        if(this.friValue) {
                          workDays.add(DateTime.friday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.friday);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
//                  color: Colors.red,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.satValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.satValue = value;
                                  if(value) {
                                    workDays.add(DateTime.saturday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.saturday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "C.tesi"
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.satValue = !this.satValue;
                        if(this.satValue) {
                          workDays.add(DateTime.saturday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.saturday);
                        }
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 15,
                          width: 18,
//                  color: Colors.red,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: this.sunValue,
                              onChanged: (bool value) {
                                setState(() {
                                  this.sunValue = value;
                                  if(value) {
                                    workDays.add(DateTime.sunday);
                                  } else {
                                    this.allDaysValue = false;
                                    workDays.remove(DateTime.sunday);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5,
                        ),
                        Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                style: _termTextStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Pazar"
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        this.sunValue = !this.sunValue;
                        if(this.sunValue) {
                          workDays.add(DateTime.sunday);
                        } else {
                          this.allDaysValue = false;
                          workDays.remove(DateTime.sunday);
                        }
                      });
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                new Container(
                  height: 27,
                  child: Text(
                    "Çalışıyor musunuz?",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 15,
//                  color: Colors.red,
                    child: Transform.scale(
                      scale: 0.9,
                      child: Radio(
                        groupValue: _radioValue,
                        value: true,
                        onChanged: (bool value) {
                          setState(() {
                            _radioValue = value;
                            hasWorkCheck = value;
                            isCheckboxValid = true;
                            widget.setTermsOfUseCheck(value);
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                    child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        text: TextSpan(
                          style: _termTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Evet"
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _radioValue = true;
                  hasWorkCheck = true;
                  isCheckboxValid = true;
                  widget.setTermsOfUseCheck(true);
                });
              },
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
              visible: this.hasWorkCheck,
              child: _buildDaySelectionWidget(),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 15,
//                  color: Colors.red,
                    child: Transform.scale(
                      scale: 0.9,
                      child: Radio(
                        groupValue: _radioValue,
                        value: false,
                        onChanged: (bool value) {
                          setState(() {
                            _radioValue = value;
                            hasWorkCheck = value;
                            isCheckboxValid = true;
                            widget.setTermsOfUseCheck(value);

                            this.allDaysValue = value;

                            this.monValue = this.allDaysValue;
                            this.tueValue = this.allDaysValue;
                            this.wedValue = this.allDaysValue;
                            this.thuValue = this.allDaysValue;
                            this.friValue = this.allDaysValue;
                            this.satValue = this.allDaysValue;
                            this.sunValue = this.allDaysValue;

                            workDays.remove(DateTime.monday);
                            workDays.remove(DateTime.tuesday);
                            workDays.remove(DateTime.wednesday);
                            workDays.remove(DateTime.thursday);
                            workDays.remove(DateTime.friday);
                            workDays.remove(DateTime.saturday);
                            workDays.remove(DateTime.sunday);
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
//                  height: 35,
//                  width: screenSize.width - 20,
                    child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        text: TextSpan(
                          style: _termTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Hayır"
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _radioValue = false;
                  hasWorkCheck = false;
                  isCheckboxValid = true;
                  widget.setTermsOfUseCheck(false);

                  this.allDaysValue = false;

                  this.monValue = this.allDaysValue;
                  this.tueValue = this.allDaysValue;
                  this.wedValue = this.allDaysValue;
                  this.thuValue = this.allDaysValue;
                  this.friValue = this.allDaysValue;
                  this.satValue = this.allDaysValue;
                  this.sunValue = this.allDaysValue;

                  workDays.remove(DateTime.monday);
                  workDays.remove(DateTime.tuesday);
                  workDays.remove(DateTime.wednesday);
                  workDays.remove(DateTime.thursday);
                  workDays.remove(DateTime.friday);
                  workDays.remove(DateTime.saturday);
                  workDays.remove(DateTime.sunday);
                });
              },
            ),
            SizedBox(
              height: 3,
            ),
            Visibility(
              visible: !this.isCheckboxValid,
              child: Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Alanlardan birini işaretlemek zorundasınız!",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
