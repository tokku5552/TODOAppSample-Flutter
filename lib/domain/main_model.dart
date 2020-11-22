import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/data/todo_item.dart';
import 'package:todo_app_sample_flutter/data/todo_item_repository.dart';

class MainModel extends ChangeNotifier {
  List<TodoItem> list = [];

  void getTodoList() async {
    list = await TodoItemRepository.getAll();
    notifyListeners();
  }

  void updateIsDone(int id, bool isDone) async {
    await TodoItemRepository.updateIsDoneById(id, isDone);
    notifyListeners();
  }

  void deleteTodoItem(int id) async {
    await TodoItemRepository.deleteTodoItem(id);
    notifyListeners();
  }
}
