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
  int _nextId;

  int get nextId => _nextId;

  void setNextId(int id) {
    _nextId = id;
  }

  void clear() {
    _data.clear();
  }

  @override
  Future<TodoItem> create(
      String title, String body, bool isDone, DateTime now) {
    final result = TodoItem(
      id: _nextId,
      title: title,
      body: body,
      createdAt: now,
      updatedAt: now,
    );
    _data[_nextId] = result;
    return Future.value(result);
  }

  @override
  Future<void> delete(int id) {
    _data.remove(id);
    return null;
  }

  @override
  Future<List<TodoItem>> findAll({bool viewCompletedItems}) {
    final todoItems = List<TodoItem>.unmodifiable(_data.values);
    return Future.value(todoItems);
  }

  @override
  Future<TodoItem> find(int id) {
    return Future.value(_data[id]);
  }

  @override
  Future<void> updateIsDoneById(int id, bool isDone, DateTime updatedAt) {
    final todoItem = _data[id];
    todoItem.isDone = isDone;
    todoItem.updatedAt = updatedAt;
    _data[id] = todoItem;
    return null;
  }

  @override
  Future<void> update(TodoItem todoItem) {
    _data[todoItem.id] = todoItem;
    return null;
  }
}
