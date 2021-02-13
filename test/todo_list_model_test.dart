/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_sample_flutter/domain/storage_repository.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/presentation/todo_list/todo_list_model.dart';

import 'infrastructure/storage_repository_mem_impl.dart';
import 'infrastructure/todo_item_repository_mem_impl.dart';

void main() {
  final storageRepository = StorageRepositoryMemImpl();
  final todoItemRepository = TodoItemRepositoryMemImpl();
  final model = TodoListModel(
      storageRepository: storageRepository,
      todoItemRepository: todoItemRepository);
  final now = DateTime.now();
  final yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);
  final data = <TodoItem>[
    TodoItem(
      id: 1,
      title: 'title1',
      body: 'body1',
      createdAt: yesterday,
      updatedAt: now,
      isDone: false,
    ),
    TodoItem(
        id: 2,
        title: 'title2',
        body: 'body2',
        createdAt: now,
        updatedAt: now,
        isDone: false),
    TodoItem(
        id: 3,
        title: 'title3',
        body: 'body3',
        createdAt: now,
        updatedAt: now,
        isDone: false),
  ];
  group('getTodoList', () {
    test('正常系', () async {
      // 事前準備
      todoItemRepository.clear();

      for (final todoItem in data) {
        todoItemRepository
          ..incrementId()
          ..create(
              title: todoItem.title,
              body: todoItem.body,
              isDone: todoItem.isDone,
              now: now);
      }

      model.viewCompletedItems = true;

      // メソッド実行
      var isSuccessful = true;
      try {
        await model.getTodoList();
      } on Exception {
        isSuccessful = false;
      }

      // 結果確認
      final result = model.list;
      expect(isSuccessful, true);
      expect(result.length, 3);
      result.asMap().forEach((key, value) {
        expect(value.id, data[key].id);
        expect(value.title, data[key].title);
        expect(value.body, data[key].body);
        expect(value.isDone, data[key].isDone);
      });
    });
  });

  group('updateIsDone', () {
    test('正常系', () async {
      // 事前準備
      todoItemRepository.clear();
      for (final todoItem in data) {
        todoItemRepository
          ..incrementId()
          ..create(
              title: todoItem.title,
              body: todoItem.body,
              isDone: todoItem.isDone,
              now: now);
      }

      // メソッド実行
      await model.updateIsDone(id: 2, isDone: true);

      // 結果確認
      final result = await todoItemRepository.findAll();
      expect(result[1].isDone, true);
    });
  });

  group('deleteTodoItem', () {
    test('正常系', () async {
      // 事前準備
      todoItemRepository.clear();
      for (final todoItem in data) {
        todoItemRepository
          ..incrementId()
          ..create(
              title: todoItem.title,
              body: todoItem.body,
              isDone: todoItem.isDone,
              now: now);
      }

      // メソッド実行
      await model.deleteTodoItem(id: 1);

      // 結果確認
      final result = await todoItemRepository.findAll();
      expect(result.length, 2);

      for (final value in result) {
        expect(value.id != 1, true);
      }
    });
  });

  group('changeViewCompletedItems', () {
    test('正常系', () async {
      // 事前準備
      storageRepository.clear();

      // メソッド実行
      await model.changeViewCompletedItems(viewCompletedItemsTrueString);

      // 結果確認
      expect(await storageRepository.isExistKey(viewCompletedItemsKey), true);
      expect(
          await storageRepository.loadPersistenceStorage(viewCompletedItemsKey),
          'true');
    });
  });

  group('loadViewCompletedItems', () {
    test('正常系:keyがない時', () async {
      // 事前準備
      storageRepository.clear();

      // メソッド実行
      final result = await model.loadViewCompletedItems();

      // 結果確認
      expect(await storageRepository.isExistKey(viewCompletedItemsKey), false);
      expect(result, null);
    });

    test('正常系:keyがある時', () async {
      // 事前準備
      storageRepository
        ..clear()
        ..savePersistenceStorage(
            viewCompletedItemsKey, viewCompletedItemsTrueString);

      // メソッド実行
      await model.loadViewCompletedItems();

      // 結果確認
      expect(await storageRepository.isExistKey(viewCompletedItemsKey), true);
      expect(
          await storageRepository.loadPersistenceStorage(viewCompletedItemsKey),
          viewCompletedItemsTrueString);
    });
  });
}
