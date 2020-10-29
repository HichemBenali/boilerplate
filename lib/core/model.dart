import 'dart:convert';

abstract class Model {
  // Api entity id;
  String id;

  // Unique id for offline operations
  String hash;

  Model();

  // Load Model from Map
  Model.load();

  // Export model to map
  Map<String, dynamic> getData();

  // Export model to json
  String toJson() {
    return jsonEncode(getData());
  }

  @override
  String toString() {
    return toJson();
  }
}
