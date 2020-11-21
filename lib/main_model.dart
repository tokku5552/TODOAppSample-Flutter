import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/todo_item.dart';

class MainModel extends ChangeNotifier {
  List<TodoItem> list = [];
  String test = 'test';

  void getTodoList() async {
    notifyListeners();
  }
}
