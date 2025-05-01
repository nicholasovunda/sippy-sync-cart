import 'package:flutter/material.dart';

class ActiveUserProvider with ChangeNotifier {
  String _name = '';

  String get name => _name;

  // Setter to update name
  set name(String value) {
    _name = value;
    notifyListeners(); // Notify listeners after updating the name
  }
}
