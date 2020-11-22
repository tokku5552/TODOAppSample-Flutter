import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/todo_item.dart';
import 'package:todo_app_sample_flutter/todo_item_repository.dart';

class MainModel extends ChangeNotifier {
  List<TodoItem> list = [];

  void getTodoList() async {
    list = await TodoItemRepository.getAll();
    notifyListeners();
  }

  void reload() {
    notifyListeners();
  }
}
