import 'package:flutter/material.dart';
import 'file:///C:/Users/physi/AndroidStudioProjects/todo_app_sample_flutter/lib/data/todo_item_repository.dart';
import 'package:todo_app_sample_flutter/data/todo_item.dart';

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
