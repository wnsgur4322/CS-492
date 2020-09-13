import 'package:flutter/material.dart';

class CenteredPlaceholder extends StatelessWidget {

  //final double padding;
  final double left;
  final double top;
  final double right;
  final double bottom;


  const CenteredPlaceholder ({Key key, this.left, this.top, this.right, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          child: SizedBox(
          child: Image.asset('assets/me.jpg'),
          width: 100, height: 100)
        );
      
  }
}