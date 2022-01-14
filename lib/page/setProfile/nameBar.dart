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

class NameBar extends StatefulWidget {
  final String selectedName;
  final Function setSelectedName;

  const NameBar({
    Key key,
    this.selectedName,
    this.setSelectedName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new NameBarState();
}

class NameBarState extends State<NameBar> {
  // 2.0 is the default from TextField class

  final registerNameTextController = TextEditingController();
  bool isNameValid = true;
  bool isNameFieldEmpty = false;

  NameBarState();

  @override
  initState() {
    super.initState();
    this.registerNameTextController.text = widget.selectedName != null ? widget.selectedName : "";
  }

  checkState() {
    if(registerNameTextController.text == "") {
      isNameFieldEmpty = true;
    }
    setState(() {});
  }

  onNameFieldChanged(text) {
    if(text == "") {
      isNameFieldEmpty = true;
      widget.setSelectedName(null);
    } else{
      isNameFieldEmpty = false;
      widget.setSelectedName(text.trim());
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
                  width: screenSize.width - 60,
//                  padding: EdgeInsets.only(left: 20),
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
                            width: screenSize.width - 101.4,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "İsiminiz",
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
                              onChanged: onNameFieldChanged,
                              controller: registerNameTextController,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
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
