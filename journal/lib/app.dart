import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/journal_entries.dart';
import 'screens/add_form.dart';
import 'screens/entry.dart';


class MyApp extends StatefulWidget {

  final SharedPreferences preferences;
  MyApp({Key key, @required this.preferences}) : super(key: key);




  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  static const THEME = 'dark';

  bool get theme =>
    widget.preferences.getBool(THEME) ?? false;

  @override
  Widget build(BuildContext context) {
      final routes = {
        JournalEntries.routeName: (context) => JournalEntries(changer: changeTheme, state: theme),
        AddForm.routeName: (context) => AddForm(changer: changeTheme, state: theme),
      };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: getTheme(),
      ),

      routes: routes,
    );
  }

  void changeTheme(state) {
    setState( () {
      widget.preferences.setBool(THEME, state);
    });
  }

  Brightness getTheme() =>
    theme ? Brightness.dark : Brightness.light;

}
