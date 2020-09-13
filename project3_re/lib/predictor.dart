import 'package:flutter/material.dart';

class Predicator extends StatefulWidget {
  static const route = '/business_card';

  @override
  _Predicator createState() => _Predicator();
}

class _Predicator extends State<Predicator> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter != 3) {
        _counter++;
      } else {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> text = [
      'Yes, Definitely.',
      'Unlikely but possible.',
      'Maybe indeed.',
      'The future is uncertain.'
    ];

    return Scaffold(

      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              ),
              Center(
                child: Text(
                  'Call me... Maybe?',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: InkWell(
                      onTap: _incrementCounter,
                      child: Text(
                        'Ask question... tap for the answer.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  text[_counter],
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}