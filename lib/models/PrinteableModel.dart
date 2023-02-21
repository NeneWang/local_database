import 'dart:convert';

abstract class PrintableModel {
  // Allows some extra methods such as printing themselves
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  void printSelf() {
    print(this);
  }
}
