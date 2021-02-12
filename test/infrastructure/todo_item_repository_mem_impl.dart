/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
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
  Future<TodoItem> create(
      String title, String body, bool isDone, DateTime now) {
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
  Future<void> delete(int id) {
    _data.remove(id);
    return null;
  }

  @override
  Future<List<TodoItem>> findAll({bool viewCompletedItems = true}) {
    List<TodoItem> result = [];
    final List<TodoItem> todoItems = List<TodoItem>.unmodifiable(_data.values);
    if (!viewCompletedItems) {
      todoItems.forEach((element) {
        result.add(element);
      });
    } else {
      result = todoItems;
    }
    return Future.value(result);
  }

  @override
  Future<TodoItem> find(int id) {
    return Future.value(_data[id]);
  }

  @override
  Future<void> updateIsDoneById(int id, bool isDone) {
    final todoItem = _data[id];
    todoItem.isDone = isDone;
    _data[id] = todoItem;
    return null;
  }

  @override
  Future<void> update(TodoItem todoItem) {
    TodoItem updateData = _data[todoItem.id];
    updateData.title = todoItem.title;
    updateData.body = todoItem.body;
    updateData.updatedAt = todoItem.updatedAt;
    _data[todoItem.id] = updateData;
    return null;
  }
}
