/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/common/database_provider.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';

class TodoItemRepositoryImpl implements TodoItemRepository {
  static String table = 'todo_item';
  static DatabaseProvider instance = DatabaseProvider.instance;

  @override
  Future<TodoItem> create({
    @required String title,
    @required String body,
    @required bool isDone,
    @required DateTime now,
  }) async {
    final row = <String, dynamic>{
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
      title: row['title'] as String,
      body: row['body'] as String,
      createdAt: now,
      updatedAt: now,
      isDone: isDone,
    );
  }

  @override
  Future<List<TodoItem>> findAll({bool viewCompletedItems = true}) async {
    final db = await instance.database;

    final rows = (viewCompletedItems == null || viewCompletedItems)
        ? await db.rawQuery('SELECT * FROM $table ORDER BY updatedAt DESC')
        : await db.rawQuery(
            'SELECT * FROM $table WHERE isDone = 0 ORDER BY updatedAt DESC');
    if (rows.isEmpty) {
      return null;
    } else {
      return rows.map((json) => TodoItem.fromMap(json)).toList();
    }
  }

  @override
  Future<TodoItem> find({@required int id}) async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table WHERE id = ?', <int>[id]);
    if (rows.isEmpty) {
      return null;
    } else {
      return TodoItem.fromMap(rows.first);
    }
  }

  @override
  Future<void> updateIsDoneById({
    @required int id,
    @required bool isDone,
  }) async {
    print('id=$id,isDone=$isDone');
    final row = {
      'id': id,
      'isDone': isDone ? 1 : 0,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: <int>[id]);
  }

  @override
  Future<void> delete({@required int id}) async {
    final db = await instance.database;
    await db.delete(table, where: 'id = ?', whereArgs: <int>[id]);
  }

  @override
  Future<void> update({@required TodoItem todoItem}) async {
    final row = {
      'id': todoItem.id,
      'title': todoItem.title,
      'body': todoItem.body,
      'updatedAt': todoItem.updatedAt.toString(),
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: <int>[todoItem.id]);
  }
}
