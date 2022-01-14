import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pref_dessert/pref_dessert.dart';

import 'package:can_i_go_out/constant/Constant.dart';
import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/localization/localizations.dart';

//import 'package:camera/camera.dart';

void sleep(Duration duration) {
  var ms = duration.inMilliseconds;
  var start = new DateTime.now().millisecondsSinceEpoch;
  while (true) {
    var current = new DateTime.now().millisecondsSinceEpoch;
    if (current - start >= ms) {
      break;
    }
  }
}

saveUserPreference(String loginId, String loginIdType, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("loginId", loginId);
  prefs.setString("loginIdType", loginIdType);
  prefs.setString("password", password);
}

Future<List<String>> getUserPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String loginId = prefs.getString("loginId");
  String loginIdType = prefs.getString("loginIdType");
  String password = prefs.getString("password");

  return [loginId, loginIdType, password];
}

removeUserPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("loginId");
  prefs.remove("loginIdType");
  prefs.remove("password");
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

/// Returns the bool status that determines to showing DialogBox.
///
/// The dialogBox is showing in createCombination class and it using
/// for giving the information to user about forwarding to the
/// combination cover photo crop page.
/// If this method returns false, createCombination page won't show
/// dialogBox otherwise will.
Future<bool> getCccDialogShowPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isCccDialogShowing = prefs.getBool("isCccDialogShowing");

  return isCccDialogShowing;
}

saveCccDialogShowPreference(bool isCccDialogShowing) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isCccDialogShowing", isCccDialogShowing);
}


checkGlobalLatestUri() {
  if (globalLatestLink != null && globalLatestUri != null) {
    String path = globalLatestUri?.path;
    var queryParams = globalLatestUri?.queryParametersAll?.entries?.toList();

    List<String> pathList = path.split("/");

    if (pathList.length == 2) {
      List<String> userList = pathList.last.split("@");

      if (userList.length == 2) {
      }
    } else if(pathList.length == 3) {
      if(pathList[1] == "ch") {

      }
    }
  }
}