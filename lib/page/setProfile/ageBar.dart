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

class AgeBar extends StatefulWidget {
  final String selectedAge;
  final Function setSelectedAge;

  const AgeBar({
    Key key,
    this.selectedAge,
    this.setSelectedAge,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new AgeBarState();
}

class AgeBarState extends State<AgeBar> {
  // 2.0 is the default from TextField class

  final registerAgeTextController = TextEditingController();
  bool isNameValid = true;
  bool isNameFieldEmpty = false;

  AgeBarState();

  @override
  initState() {
    super.initState();
    this.registerAgeTextController.text = widget.selectedAge != null ? widget.selectedAge : "";
  }

  checkState() {
    if(registerAgeTextController.text == "") {
      isNameFieldEmpty = true;
    }
    setState(() {});
  }

  onAgeFieldChanged(text) {
    if(text == "") {
      isNameFieldEmpty = true;
      widget.setSelectedAge(null);
    } else{
      isNameFieldEmpty = false;
      widget.setSelectedAge(text.trim());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 36.4,
                  width: screenSize.width - 210,
//                  padding: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.5),
                    border: Border.all(
                      color: Color(0xff3C3C3C),
                      width: 0.7,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 20,
                            width: screenSize.width - 251.4,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Yaşınız",
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff3C3C3C),
                                  fontSize: 20.0,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: onAgeFieldChanged,
                              controller: registerAgeTextController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 180,
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Visibility(
              visible: this.isNameFieldEmpty,
              child: Container(
                width: screenSize.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Bu alan boş bırakılamaz",
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
