import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';

abstract class TodoItemRepository {
  Future<TodoItem> create({
    @required String title,
    @required String body,
    @required bool isDone,
    @required DateTime now,
  });
  Future<List<TodoItem>> findAll({bool viewCompletedItems});
  Future<TodoItem> find({@required int id});
  Future<void> update({@required TodoItem todoItem});
  Future<void> updateIsDoneById({@required int id, @required bool isDone});
  Future<void> delete({@required int id});
}
