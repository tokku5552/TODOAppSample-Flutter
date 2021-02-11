/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sample_flutter/common/database_provider.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';

class TodoItemRepositoryImpl implements TodoItemRepository {
  static String table = 'todo_item';
  static DatabaseProvider instance = DatabaseProvider.instance;

  @override
  Future<TodoItem> create(String title, String body, bool isDone) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'title': title,
      'body': body,
      'createdAt': now.toString(),
      'updatedAt': now.toString(),
      'isDone': (isDone == true) ? 1 : 0,
    };
    final db = await instance.database;
    final id = await db.insert(table, row);
    return TodoItem(
      id: id,
      title: row["title"],
      body: row["body"],
      createdAt: now,
      updatedAt: now,
      isDone: isDone,
    );
  }

  @override
  Future<List<TodoItem>> getAll({bool viewCompletedItems}) async {
    final Database db = await instance.database;

    final rows = (viewCompletedItems == null || viewCompletedItems)
        ? await db.rawQuery('SELECT * FROM $table ORDER BY updatedAt DESC')
        : await db.rawQuery(
            'SELECT * FROM $table WHERE isDone = 0 ORDER BY updatedAt DESC');
    if (rows.isEmpty) return null;
    return rows.map((json) => TodoItem.fromMap(json)).toList();
  }

  @override
  Future<TodoItem> getTodoItem(int id) async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE id = ?', [id]);
    if (rows.isEmpty) return null;
    return TodoItem.fromMap(rows.first);
  }

  @override
  Future<void> updateTodoItem({int id, String title, String body}) async {
    String now = DateTime.now().toString();
    final row = {
      'id': id,
      'title': title,
      'body': body,
      'updatedAt': now,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updateIsDone(List<TodoItem> list) async {
    final db = await instance.database;
    String now = DateTime.now().toString();
    list.forEach((todo) async {
      final row = {
        'id': todo.id,
        'updatedAt': now,
        'isDone': (todo.isDone) ? 1 : 0,
      };
      await db.update(table, row, where: 'id = ?', whereArgs: [todo.id]);
    });
  }

  @override
  Future<void> updateIsDoneByTodoItem(TodoItem todoItem) async {
    String now = DateTime.now().toString();
    print("todoItem=${todoItem.title}");
    final row = {
      'id': todoItem.id,
      'updatedAt': now,
      'isDone': (todoItem.isDone) ? 1 : 0,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [todoItem.id]);
  }

  @override
  Future<void> updateIsDoneById(int id, bool isDone) async {
    String now = DateTime.now().toString();
    print("id=$id,isDone=$isDone");
    final row = {
      'id': id,
      'updatedAt': now,
      'isDone': (isDone) ? 1 : 0,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteTodoItem(int id) async {
    final db = await instance.database;
    await db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
