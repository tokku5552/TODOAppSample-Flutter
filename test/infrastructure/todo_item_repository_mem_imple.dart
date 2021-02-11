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
  DateTime _nextCreatedAt;
  DateTime _nextUpdatedAt;

  int get nextId => _nextId;
  DateTime get nextCreatedAt => _nextCreatedAt;
  DateTime get nextUpdatedAt => _nextUpdatedAt;

  void setNextId(int id) {
    _nextId = id;
  }

  void setNextCreatedAt(DateTime createdAt) {
    _nextCreatedAt = createdAt;
  }

  void setNextUpdatedAt(DateTime updatedAt) {
    _nextUpdatedAt = nextUpdatedAt;
  }

  void clear() {
    _data.clear();
  }

  @override
  Future<TodoItem> create(String title, String body, bool isDone) {
    final result = TodoItem(
      id: _nextId,
      title: title,
      body: body,
      createdAt: _nextCreatedAt,
      updatedAt: _nextUpdatedAt,
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
  Future<void> updateIsDoneById(int id, bool isDone) {
    final todoItem = _data[id];
    todoItem.isDone = isDone;
    _data[id] = todoItem;
    return null;
  }

  @override
  Future<void> update(TodoItem todoItem) {
    _data[todoItem.id] = todoItem;
    return null;
  }
}
