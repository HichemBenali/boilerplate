import 'dart:convert';

abstract class Model {
  String name;
  String id;
  String date;
  String hash;

  Model();
  // Load from API Map
  Model.load();

  bool isValid() {
    return true;
  }

  Map<String, dynamic> getData();
  String toJson() {
    return jsonEncode(getData());
  }

  @override
  String toString() {
    return toJson();
  }
}
