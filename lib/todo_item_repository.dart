import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sample_flutter/database_provider.dart';
import 'package:todo_app_sample_flutter/todo_item.dart';

class TodoItemRepository {
  static String table = 'todo_item';
  static DatabaseProvider instance = DatabaseProvider.instance;

  Future<void> create(String title, String body) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'title': title,
      'body': body,
      'createdAt': now.toString(),
      'updatedAt': now.toString(),
    };
    final db = await instance.database;
    final id = await db.insert(table, row);
    return TodoItem(
      id: id,
      title: row["title"],
      body: row["body"],
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<List<TodoItem>> getAll() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $table ORDER BY updated_at DESC');

    return List.generate(maps.length, (i) {
      return TodoItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        createdAt: maps[i]['createdAt'],
      );
    });
  }

  Future<TodoItem> getTodoItem(int id) async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE id = ?', [id]);
    if (rows.isEmpty) return null;
    return TodoItem.fromMap(rows.first);
  }

  Future<void> updateTodoItem({int id, String title, String body}) async {
    String now = DateTime.now().toString();
    final row = {
      'id': id,
      'title': title,
      'body': body,
      'updatedAt': now,
    };
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTodoItem(int id) async {
    final db = await instance.database;
    await db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
