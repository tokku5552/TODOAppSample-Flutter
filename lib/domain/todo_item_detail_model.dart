import 'package:flutter/material.dart';
import 'file:///C:/Users/physi/AndroidStudioProjects/todo_app_sample_flutter/lib/data/todo_item_repository.dart';

class TodoItemDetailModel extends ChangeNotifier {
  String todoTitle = "";
  String todoBody = "";
  bool isDone = false;

  Future<void> add() async {
    if (todoTitle == null || todoTitle.isEmpty) {
      throw ("タイトルを入力してください。");
    }
    await TodoItemRepository.create(
      todoTitle,
      (todoBody.isEmpty) ? "" : todoBody,
      isDone,
    );
    notifyListeners();
  }

  Future<void> update(int id) async {
    await TodoItemRepository.updateTodoItem(
      id: id,
      title: (todoTitle.isEmpty) ? todoTitle = "" : todoTitle,
      body: (todoBody.isEmpty) ? "" : todoBody,
    );
    notifyListeners();
  }
}
