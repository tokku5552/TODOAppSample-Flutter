import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sample_flutter/database_provider.dart';
import 'package:todo_app_sample_flutter/todo_item.dart';

class TodoItemRepository {
  static String table = 'todo_item';
  static DatabaseProvider instance = DatabaseProvider.instance;

  Future<void> insertTodoItem(TodoItem todoItem) async {
    final Database db = await instance.database;
    await db.insert(
      'todos',
      todoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoItem>> todoItemList() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return TodoItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        createdAt: maps[i]['createdAt'],
      );
    });
  }

  Future<void> updateTodoItem(TodoItem todoItem) async {
    final db = await instance.database;

    await db.update(
      'todos',
      todoItem.toMap(),
      where: "id = ?",
      whereArgs: [todoItem.id],
    );
  }

  Future<void> deleteTodoItem(int id) async {
    final db = await instance.database;
    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
