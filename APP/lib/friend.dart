import 'dart:convert';
import 'package:meta/meta.dart';

class Friend {
  Friend({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.location,
    @required this.coordinates,

  });

  final String avatar;
  final String name;
  final String email;
  final String location;
  final String coordinates;

  static List<Friend> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['results']
        .cast<Map<String, dynamic>>()
        .map((obj) => Friend.fromMap(obj))
        .toList()
        .cast<Friend>();
  }

  static Friend fromMap(Map map) {
    var name = map['name'];

    return new Friend(
      avatar: map['picture']['large'],
      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
      email: map['email'],
      location: _capitalize(map['location']['state']+","+map['location']['country']),
        coordinates:map['coordinates'],
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}