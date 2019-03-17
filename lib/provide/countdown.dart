import 'package:flutter/material.dart';

class Countdown with ChangeNotifier {
  int value = 0;

  void increament() {
    value++;
    notifyListeners();
  }
}