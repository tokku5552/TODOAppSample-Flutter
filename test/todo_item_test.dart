/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';

void main() {
  group('TodoItemのゲッターのテスト', () {
    final todoItem = TodoItem(
      id: 0,
      title: 'title',
      body: 'body',
      createdAt: DateTime(2020, 1, 1),
      updatedAt: DateTime(2020, 1, 1),
      isDone: true,
    );

    test('idのテスト', () async {
      expect(todoItem.getId, 0);
    });

    test('titleのテスト', () async {
      expect(todoItem.getTitle, 'title');
    });

    test('bodyのテスト', () async {
      expect(todoItem.getBody, 'body');
    });

    test('createdAtのテスト', () async {
      expect(todoItem.createdAt, DateTime(2020, 1, 1));
    });

    test('updatedAtのテスト', () async {
      expect(todoItem.getUpdatedAt, DateTime(2020, 1, 1));
    });

    test('isDoneのテスト', () async {
      expect(todoItem.getIsDone, true);
    });
  });

  group('toMapのテスト', () {
    final todoItem = TodoItem(
      id: 0,
      title: 'title',
      body: 'body',
      createdAt: DateTime(2020, 1, 1),
      updatedAt: DateTime(2020, 1, 1),
      isDone: true,
    );

    final todoItemMap = todoItem.toMap();
    final keyList = todoItemMap.keys.toList();
    final valueList = todoItemMap.values.toList();

    test('keyが一致しているか', () async {
      expect(keyList[0], 'id');
      expect(keyList[1], 'title');
      expect(keyList[2], 'body');
      expect(keyList[3], 'createdAt');
      expect(keyList[4], 'updatedAt');
      expect(keyList[5], 'isDone');
    });

    test('valueが一致しているか', () async {
      expect(valueList[0], 0);
      expect(valueList[1], 'title');
      expect(valueList[2], 'body');
      expect(valueList[3], DateTime(2020, 1, 1).toUtc().toIso8601String());
      expect(valueList[4], DateTime(2020, 1, 1).toUtc().toIso8601String());
      expect(valueList[5], 1);
    });
  });

  group('fromMapのテスト', () {
    final json = {
      'id': 0,
      'title': 'title',
      'body': 'body',
      'createdAt': DateTime(2020, 1, 1).toString(),
      'updatedAt': DateTime(2020, 1, 1).toString(),
      'isDone': '1', // SQLiteの仕様上真偽値はtrue=1,false=0のString
    };

    test('idが一致しているか', () {
      expect(TodoItem.fromMap(json).getId, 0);
    });
    test('titleが一致しているか', () {
      expect(TodoItem.fromMap(json).getTitle, 'title');
    });
    test('bodyが一致しているか', () {
      expect(TodoItem.fromMap(json).getBody, 'body');
    });
    test('createdAtが一致しているか', () {
      expect(TodoItem.fromMap(json).createdAt, DateTime(2020, 1, 1));
    });
    test('updatedAtが一致しているか', () {
      expect(TodoItem.fromMap(json).getUpdatedAt, DateTime(2020, 1, 1));
    });
    test('isDoneが一致しているか', () {
      expect(TodoItem.fromMap(json).isDone, true);
    });
  });

  group('toStringのテスト', () {
    final todoItem = TodoItem(
      id: 0,
      title: 'title',
      body: 'body',
      createdAt: DateTime(2020, 1, 1),
      updatedAt: DateTime(2020, 1, 1),
      isDone: true,
    );

    test('toStringで取得した結果が一致しているか', () async {
      expect(todoItem.toString(),
          'Todo{id: 0, title: title, createdAt: 2020-01-01 00:00:00.000}');
    });
  });
}
