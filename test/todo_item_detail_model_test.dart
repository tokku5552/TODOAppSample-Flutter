/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/presentation/todo_item_detail/todo_item_detail_model.dart';

import 'infrastructure/todo_item_repository_mem_impl.dart';

void main() {
  final repository = TodoItemRepositoryMemImpl();
  final model = TodoItemDetailModel(todoItemRepository: repository);
  final dummyDate = DateTime.now();
  group('setTodoItem', () {
    test('正常系', () async {
      // 事前準備
      repository.clear();
      final data = TodoItem(
        id: 0,
        title: 'テストタイトル',
        body: 'テストボディ',
        createdAt: dummyDate,
        updatedAt: dummyDate,
      );
      model.setTodoItem(data);
      expect(model.todoTitle, data.title);
      expect(model.todoBody, data.body);
    });
  });
  group('add', () {
    test('正常系', () async {
      // 事前準備
      repository.clear();
      final data = TodoItem(
        id: 0,
        title: 'テストタイトル',
        body: 'テストボディ',
        createdAt: dummyDate,
        updatedAt: dummyDate,
      );
      model
        ..todoTitle = data.title
        ..todoBody = data.body;

      // メソッド実行
      var isSuccessful = true;
      try {
        await model.add();
      } on Exception {
        isSuccessful = false;
      }

      // 結果確認
      final result = await repository.findAll();
      expect(isSuccessful, true);
      expect(result.length, 1);
      final item = result.first;
      expect(item.title, data.title);
      expect(item.body, data.body);
      expect(item.isDone, false);
      expect(item.createdAt, isNotNull);
      expect(item.updatedAt, isNotNull);
      expect(item.createdAt, item.updatedAt);
    });

    test('異常系', () async {
      // implement
      final newModel = TodoItemDetailModel(todoItemRepository: repository);
      var successfully = false;
      try {
        await newModel.add();
      } catch (e) {
        successfully = true;
      }
      expect(successfully, true);
    });
  });

  group('update', () {
    test('正常系', () async {
      // 事前準備
      repository.clear();
      final data = TodoItem(
        id: 0,
        title: 'テストタイトル',
        body: 'テストボディ',
        createdAt: dummyDate,
        updatedAt: dummyDate,
      );
      await repository.create(
        title: '変更前',
        body: '変更前',
        isDone: false,
        now: DateTime.now().subtract(const Duration(days: 1)),
      );
      model
        ..todoTitle = data.title
        ..todoBody = data.body;

      // メソッド実行
      var isSuccessful = true;
      try {
        await model.update(repository.currentId);
      } on Exception {
        isSuccessful = false;
      }

      // 結果確認
      final result = await repository.findAll();
      expect(isSuccessful, true);
      expect(result.length, 1);
      final item = result.first;
      expect(item.title, data.title);
      expect(item.body, data.body);
      expect(item.isDone, false);
      expect(item.updatedAt.isAfter(item.createdAt), true);
    });
  });
}
