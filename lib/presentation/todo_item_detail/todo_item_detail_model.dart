/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';

class TodoItemDetailModel extends ChangeNotifier {
  TodoItemDetailModel({
    @required TodoItemRepository todoItemRepository,
  }) : _todoItemRepository = todoItemRepository;
  String todoTitle = "";
  String todoBody = "";
  bool isDone = false;
  TodoItemRepository _todoItemRepository;

  Future<void> add() async {
    if (todoTitle == null || todoTitle.isEmpty) {
      throw ("タイトルを入力してください。");
    }
    await _todoItemRepository.create(
      todoTitle,
      (todoBody.isEmpty) ? "" : todoBody,
      isDone,
    );
    notifyListeners();
  }

  Future<void> update(int id) async {
    await _todoItemRepository.updateTodoItem(
      id: id,
      title: (todoTitle.isEmpty) ? todoTitle = "" : todoTitle,
      body: (todoBody.isEmpty) ? "" : todoBody,
    );
    notifyListeners();
  }
}
