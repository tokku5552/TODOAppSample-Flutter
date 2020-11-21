import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/todo_item_repository.dart';

class TodoItemDetailModel extends ChangeNotifier {
  String todoTitle;
  String todoBody;

  Future<void> add() async {
    await TodoItemRepository.create(todoTitle, todoBody);
    notifyListeners();
  }
}