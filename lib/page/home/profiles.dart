import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pref_dessert/pref_dessert.dart';

import 'package:can_i_go_out/after_layout.dart';

import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/model/profile.dart';
import 'package:can_i_go_out/page/setProfile/main.dart';


class ProfilesWidget extends StatefulWidget {
  final Function resetParentState;

  ProfilesWidget({
    Key key,
    this.resetParentState,
  }) : super(key: key);

  @override
  ProfilesWidgetState createState() => new ProfilesWidgetState();
}

class ProfilesWidgetState extends State<ProfilesWidget>
    with AfterLayoutMixin<ProfilesWidget>  {

  List<ProfileModel> profileModels = new List<ProfileModel>();


  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    super.initState();

    _pullTopics();
  }

  _pullTopics() async {

    var repo = new FuturePreferencesRepository<ProfileModel>(new ProfileModelDesSer());
    List<ProfileModel> profileModels = await repo.findAll();

    for(ProfileModel model in profileModels) {
      this.profileModels.add(model);
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: screenSize.width,
//      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: new ListView.builder(
        itemCount: profileModels.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if(index == profileModels.length) {
            return new AddProfileItem();
          }
          return new InkWell(
            splashColor: Colors.blueAccent,
            onTap: () {
//              print("Inkwell tap works");
//              globalProfileModel = profileModels[index];
//              widget.resetParentState();
//              setState(() {});
            },
            child: new ProfileItem(profileModels[index], widget.resetParentState),
          );
        },
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final ProfileModel profileModel;
  final Function resetParentState;

  ProfileItem(this.profileModel, this.resetParentState);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 105,
        width: 105,
      padding: EdgeInsets.only(left: 7.5, right: 7.5),
        child: Column(
          children: <Widget>[
            new Container(
//            width: screenSize.width / 4,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(45.0),
                border: Border.all(
                  color: globalProfileModel.id == profileModel.id ? globalIsOutEnable ? Color(0xff3C3C3C) : Color(0xff00A1A0)  : Colors.transparent,
                  width: globalProfileModel.id == profileModel.id ? 5 : 0.0,
                ),
              ),
              child: Center(
                child: Text(
                  "${profileModel.name.substring(0, 1).toUpperCase()}",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            new Container(
//            width: screenSize.width / 4,
              height: 20,
              child: Center(
                child: Text(
                  "${profileModel.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: globalProfileModel.id == profileModel.id ? FontWeight.normal: FontWeight.w100
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        globalProfileModel = profileModel;
        resetParentState();
      },
    );
  }
}

class AddProfileItem extends StatelessWidget {

  AddProfileItem();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 105,
        width: 90,
        child: Column(
          children: <Widget>[
            Container(
//            width: screenSize.width / 4,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: !globalIsOutEnable ? Color(0xff00A1A0) : Color(0xff3C3C3C),
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 0.0,
                ),
              ),
              child: Center(
                child: Icon(Icons.add,
                    color: Colors.white, size: 50),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            new Container(
//            width: screenSize.width / 4,
              height: 20,
              child: Center(
                child: Text(
                  "Profil Ekle",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new SetProfilePage(
          restartWidgetKey: globalRestartWidgetKey,
        )));
      },
    );
  }
}