import 'package:todo_app_sample_flutter/domain/todo_item.dart';

abstract class TodoItemRepository {
  Future<TodoItem> create(String title, String body, bool isDone);
  Future<List<TodoItem>> findAll({bool viewCompletedItems});
  Future<TodoItem> find(int id);
  Future<void> update(TodoItem todoItem);
  Future<void> updateIsDoneById(int id, bool isDone);
  Future<void> delete(int id);
}
