import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'business_card.dart';
import 'tabmenu.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight]);
runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Me Maybe',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 3,
        child: TabMenu()),
      routes: {
        BusinessCard.route: (context) => BusinessCard(),
      }
    );
  }

}