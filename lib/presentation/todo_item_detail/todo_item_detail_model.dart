/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';

class TodoItemDetailModel extends ChangeNotifier {
  TodoItemDetailModel({
    @required TodoItemRepository todoItemRepository,
  }) : _todoItemRepository = todoItemRepository;
  final TodoItemRepository _todoItemRepository;

  String todoTitle = '';
  String todoBody = '';
  bool isDone = false;

  void setTodoItem(TodoItem todoItem) {
    todoTitle = todoItem.title;
    todoBody = todoItem.body;
  }

  Future<void> add() async {
    if (todoTitle == null || todoTitle.isEmpty) {
      final Error error = ArgumentError('タイトルを入力してください。');
      throw error;
    }
    await _todoItemRepository.create(
        title: todoTitle,
        body: (todoBody.isEmpty) ? '' : todoBody,
        isDone: isDone,
        now: DateTime.now());
    notifyListeners();
  }

  Future<void> update(int id) async {
    final todoItem = TodoItem(
      id: id,
      title: (todoTitle.isEmpty) ? todoTitle = '' : todoTitle,
      body: (todoBody.isEmpty) ? '' : todoBody,
      updatedAt: DateTime.now(),
    );
    await _todoItemRepository.update(todoItem: todoItem);
    notifyListeners();
  }
}
