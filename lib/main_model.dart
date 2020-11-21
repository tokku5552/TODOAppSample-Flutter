import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String test = 'test';

  void changeTest() {
    test = "test2";
    notifyListeners();
  }


}