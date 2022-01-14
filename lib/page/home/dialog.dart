import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pref_dessert/pref_dessert.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/helpers/enabledTime.dart';
import 'package:can_i_go_out/helpers/localNotifications.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/model/profile.dart';
import 'package:can_i_go_out/constant/CustomFontIcons.dart';


class DialogWidget extends StatefulWidget {

  final Function resetParentState;

  DialogWidget({
    Key key,
    this.resetParentState,
  }) : super(key: key);

  @override
  DialogWidgetState createState() => new DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget>
    with AfterLayoutMixin<DialogWidget>  {

  bool isOutEnable = false;
  bool isDisableClose = false;
  bool isDisableCloseShowed = false;

  String userMessageText = "";
  String enableText = "Şuan dışarı çıkabilirsiniz.";
  String disableText = "Malesef şuan da dışarı çıkamıyorsunuz.";

  Timer _timer;
  String counterTitle = "Yasağın başlamasına kalan süre:";

  TextStyle _counterTitleTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w300,
  );

  String counterTime = "";
  TextStyle _counterTimeTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
    fontSize: 60,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300
  );


  String disableSubText = "Az zaman kaldı!";
  bool isSubTextVisible = false;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    this.startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = new Timer.periodic(
      Duration(milliseconds: 1000),
          (Timer timer) => setState(
            () {
          List result = getMostCloseTime(globalProfileModel);
          globalIsOutEnable = result[0];
          this.counterTime = result[1];
          this.isDisableClose = result[2];
//          if(this.isDisableClose && !this.isDisableCloseShowed) {
//            showPublicNotification();
//            this.isDisableCloseShowed = true;
//          }
          if(globalIsOutEnable) {
            //todo: set state by enable
            this.userMessageText = this.enableText;
            this.counterTitle = "Yasağın başlamasına kalan süre:";
            isSubTextVisible = false;
          } else {
            //todo: set state by disable
            counterTitle = "Yasağın bitmesine kalan süre:";
            this.userMessageText = this.disableText;
            isSubTextVisible = true;

          }
          widget.resetParentState();
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: (this.isDisableClose && !globalIsOutEnable) ? 320 + 60.0 : 260 + 22.0 + 31.0,
      width: screenSize.width - 70,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),

      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 46,
            child: Container(
              height: (this.isDisableClose && !globalIsOutEnable) ? 274 + 60.0 : 214 + 22.0 + 31.0,
              width: screenSize.width - 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 46,
                  ),
                  new Container(
                    width: screenSize.width - 70,
                    child: Center(
                      child: Text(
                        this.userMessageText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          color: globalIsOutEnable ? Color(0xff3DA31E) : Color(0xffff0000),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: new Container(
                      height: 25,
                      child: Text(
                        this.counterTitle,
                        style: _counterTitleTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: new Container(
//            width: screenSize.width / 4,
                      height: 62,
                      padding: const EdgeInsets.only(top: 1.5, bottom: 1.5),
                      decoration: BoxDecoration(
//                            color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Text(
                        this.counterTime,
                        style: this._counterTimeTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: (!globalIsOutEnable && this.isDisableClose) || (globalIsOutEnable && globalProfileModel.hasWork),
                    child:  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: screenSize.width / 10,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            color: Colors.orange,
                            margin: const EdgeInsets.only(left: 0.0),
                            child: GestureDetector(
                              child: Icon(CustomFontIcons.report_problem_24px,
                                  color: Colors.white, size: 35),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 60,
                            width: screenSize.width / 2.055,
                            child: Center(
                              child: Text(
                                globalProfileModel.hasWork ? "Çalışma saatlerinize göre hareket ediniz!" : this.disableSubText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: globalProfileModel.hasWork ? screenSize.width / 20.55 : screenSize.width / 16.44,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width / 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: (screenSize.width - 70 - 92) / 2,
            child: Container(
              height: 92,
              width: 92,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  Column(
                    children: <Widget>[
                      Spacer(),
                      Container(
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80.0),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.3,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 73,
                            width: 73,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(80.0),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 0.3,
                              ),
                            ),
                            child: Icon(
                              globalIsOutEnable ? Icons.check_circle : CustomFontIcons.unpublished_24px,
                              color: globalIsOutEnable ? Color(0xff3DA31E) : Color(0xffff0000),
                              size: 73  ,
                            ),
                          ),
                        ),
                      ),
//                        SizedBox(
//                          height: 10,
//                        ),
                    ],
                  ),
//                    SizedBox(
//                      width: 10,
//                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
