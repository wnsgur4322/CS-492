import 'dart:convert';
import 'dart:io';

import 'package:dart_space_adventure/dart_space_adventure.dart';

var planetData = {
 // 'Mercury': 'A very hot planet, closest to the sun',
 // 'Venus' : 'It\'s very cloudy clear!'
};

class JsonFile {
  String name;
  String planets;

  JsonFile(this.name, this.planets);

  factory JsonFile.fromJson(dynamic json) {
    return JsonFile(json['title'] as String, json['planets'] as String);
  }
  @override
  String toString() {
    return name;

  }
}

void main(List<String> arguments) {
  var json_contents = File(arguments[0]).readAsStringSync();

  Map valueMap = json.decode(json_contents);

  for (var i = 0; i < valueMap['planets'].length; i++){
    planetData[valueMap['planets'][i]['name']] = valueMap['planets'][i]['description'];
  }

  

  SpaceAdventure(
    planetarySystem: PlanetarySystem(
      name: valueMap['name'],
      planets: mockPlanets()
    )
  ).start();

}

List<Planet> mockPlanets() {
  return planetData.entries.map( 
    (entry) => Planet(name: entry.key, description: entry.value)
  ).toList();
  // var entries = planetData.map( (k, v) {
  //   MapEntry(k, Planet(name: k, description: v));
  // });
 
}

