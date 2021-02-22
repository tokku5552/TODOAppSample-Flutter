/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';

class TodoItemRepositoryMemImpl implements TodoItemRepository {
  // { id : TodoItem }
  final _data = <int, TodoItem>{};

  // Repository内部やDB側で自動生成されるものを外部から操作できるようにする
  int _currentId = 0;

  int get currentId => _currentId;

  void incrementId() {
    _currentId++;
  }

  void clear() {
    _data.clear();
    _currentId = 0;
  }

  @override
  Future<TodoItem> create({
    @required String title,
    @required String body,
    @required bool isDone,
    @required DateTime now,
  }) {
    final result = TodoItem(
      id: _currentId,
      title: title,
      body: body,
      isDone: isDone,
      createdAt: now,
      updatedAt: now,
    );
    _data[_currentId] = result;
    return Future.value(result);
  }

  @override
  Future<void> delete({@required int id}) {
    _data.remove(id);
    return null;
  }

  @override
  Future<List<TodoItem>> findAll({bool viewCompletedItems = true}) {
    var result = <TodoItem>[];
    final todoItems = List<TodoItem>.unmodifiable(_data.values);
    if (!viewCompletedItems) {
      todoItems.forEach(result.add);
    } else {
      result = todoItems;
    }
    return Future.value(result);
  }

  @override
  Future<TodoItem> find({@required int id}) {
    return Future.value(_data[id]);
  }

  @override
  Future<void> updateIsDoneById({@required int id, @required bool isDone}) {
    final todoItem = _data[id]..isDone = isDone;
    _data[id] = todoItem;
    return null;
  }

  @override
  Future<void> update({@required TodoItem todoItem}) {
    final updateData = _data[todoItem.id]
      ..title = todoItem.title
      ..body = todoItem.body
      ..updatedAt = todoItem.updatedAt;
    _data[todoItem.id] = updateData;
    return null;
  }
}
