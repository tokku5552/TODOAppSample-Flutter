import 'package:todo_app_sample_flutter/domain/todo_item.dart';

abstract class TodoItemRepository {
  Future<TodoItem> create(String title, String body, bool isDone);
  Future<List<TodoItem>> getAll({bool viewCompletedItems});
  Future<TodoItem> getTodoItem(int id);
  Future<void> updateTodoItem({int id, String title, String body});
  Future<void> updateIsDone(List<TodoItem> list);
  Future<void> updateIsDoneByTodoItem(TodoItem todoItem);
  Future<void> updateIsDoneById(int id, bool isDone);
  Future<void> deleteTodoItem(int id);
}
