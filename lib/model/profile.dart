import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:uuid/uuid.dart';

import 'package:pref_dessert/pref_dessert.dart';

class ProfileModel {
  final String name;
  final int age;
  final String id;

  bool hasWork;
  List<int> workDays;

  ProfileModel(this.id, this.name, this.age, this.hasWork, this.workDays);
}

class ProfileModelDesSer extends DesSer<ProfileModel> {
  @override
  String get key => "ProfileModel";

  @override
  ProfileModel deserialize(String s) {
    var map = json.decode(s);

    List workDaysUnknown = map['workDays'] as List;
    List<int> workDays = <int>[];

    for(var workDay in workDaysUnknown) {
      workDays.add(int.parse(workDay.toString()));
    }

    ProfileModel profileModel = new ProfileModel(
      map['id'] as String,
      map['name'] as String,
      map['age'] as int,
      map['hasWork'] as bool,
      workDays
    );

    return profileModel;
  }

  @override
  String serialize(ProfileModel profileModel) {

    var map = {
      "id": profileModel.id,
      "name": profileModel.name,
      "age": profileModel.age,
      "hasWork": profileModel.hasWork,
      "workDays": profileModel.workDays,
    };

    return json.encode(map);
  }
}