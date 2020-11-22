import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/todo_item.dart';
import 'package:todo_app_sample_flutter/todo_item_repository.dart';

class MainModel extends ChangeNotifier {
  List<TodoItem> list = [];

  void getTodoList() async {
    list = await TodoItemRepository.getAll();
    notifyListeners();
  }

  void updateIsDone(int id, bool isDone) async {
    // print("todoItem=${todoItem.title} isDone=${todoItem.isDone}");
    await TodoItemRepository.updateIsDoneById(id, isDone);
    notifyListeners();
  }
}
