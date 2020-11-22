import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/todo_item_repository.dart';

class TodoItemDetailModel extends ChangeNotifier {
  String todoTitle;
  String todoBody;
  bool isDone = false;

  Future<void> add() async {
    await TodoItemRepository.create(todoTitle, todoBody, isDone);
    notifyListeners();
  }

  Future<void> update(int id) async {
    await TodoItemRepository.updateTodoItem(
        id: id, title: todoTitle, body: todoBody);
    notifyListeners();
  }
}
