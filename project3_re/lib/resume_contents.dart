import 'package:flutter/material.dart';

class ResumeContents extends StatefulWidget {
  final title;
  final company;
  final duration;
  final location;
  final description;
  ResumeContents({this.title, this.company, this.duration, this.location, this.description});

  @override
  _ResumeContents createState() => _ResumeContents();
}

class _ResumeContents extends State<ResumeContents> {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    //final resume = Provider.of<Resume>(context, listen: false);

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          margin: EdgeInsets.all(1),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 3),
                child: Row(
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 5, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      Text(
                      widget.company,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1,
                  ),
                      Text(
                        widget.duration,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                  ),
                      Text(
                        widget.location,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}