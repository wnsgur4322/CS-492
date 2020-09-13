import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/////////////////////
//  UNUSED MODEL  //
////////////////////

class ThemeModel {

  final key;
  bool state;
  SharedPreferences prefs;

  ThemeModel({@required this.state, @required this.prefs, @required this.key});

  void changeTheme(state) {
    prefs.setBool(key, state);
  }

  Brightness getTheme() =>
    key ? Brightness.dark : Brightness.light;



}