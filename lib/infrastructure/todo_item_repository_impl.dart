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
  Future<TodoItem> create(
      String title, String body, bool isDone, DateTime now) async {
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
  Future<List<TodoItem>> findAll({bool viewCompletedItems}) async {
    final Database db = await instance.database;

    final rows = (viewCompletedItems == null || viewCompletedItems)
        ? await db.rawQuery('SELECT * FROM $table ORDER BY updatedAt DESC')
        : await db.rawQuery(
            'SELECT * FROM $table WHERE isDone = 0 ORDER BY updatedAt DESC');
    if (rows.isEmpty) return null;
    return rows.map((json) => TodoItem.fromMap(json)).toList();
  }

  @override
  Future<TodoItem> find(int id) async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE id = ?', [id]);
    if (rows.isEmpty) return null;
    return TodoItem.fromMap(rows.first);
  }

  @override
  Future<void> updateIsDoneById(int id, bool isDone, DateTime updatedAt) async {
    print("id=$id,isDone=$isDone");
    final row = {
      'id': id,
      'updatedAt': updatedAt.toString(),
      'isDone': (isDone) ? 1 : 0,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(TodoItem todoItem) async {
    final row = {
      'id': todoItem.id,
      'title': todoItem.title,
      'body': todoItem.body,
      'updatedAt': todoItem.updatedAt,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [todoItem.id]);
  }
}
