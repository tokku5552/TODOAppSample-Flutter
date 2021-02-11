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
  final StorageRepositoryMemImpl storageRepository = StorageRepositoryMemImpl();
  final TodoItemRepositoryMemImpl todoItemRepository =
      TodoItemRepositoryMemImpl();
  final model = TodoListModel(
      storageRepository: storageRepository,
      todoItemRepository: todoItemRepository);
  final now = DateTime.now();
  final yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);
  final List<TodoItem> data = [
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
      data.forEach((todoItem) {
        todoItemRepository.incrementId();
        todoItemRepository.create(
            todoItem.title, todoItem.body, todoItem.isDone, now);
      });
      model.viewCompletedItems = true;

      // メソッド実行
      bool isSuccessful = true;
      try {
        await model.getTodoList();
      } catch (e) {
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
      data.forEach((todoItem) {
        todoItemRepository.incrementId();
        todoItemRepository.create(
            todoItem.title, todoItem.body, todoItem.isDone, now);
      });

      // メソッド実行
      await model.updateIsDone(2, true);

      // 結果確認
      final result = await todoItemRepository.findAll();
      expect(result[1].isDone, true);
    });
  });

  group('deleteTodoItem', () {
    test('正常系', () async {
      // 事前準備
      todoItemRepository.clear();
      data.forEach((todoItem) {
        todoItemRepository.incrementId();
        todoItemRepository.create(
            todoItem.title, todoItem.body, todoItem.isDone, now);
      });

      // メソッド実行
      await model.deleteTodoItem(1);

      // 結果確認
      final result = await todoItemRepository.findAll();
      expect(result.length, 2);
      result.forEach((value) {
        expect(value.id != 1, true);
      });
    });
  });

  group('changeViewCompletedItems', () {
    test('正常系', () async {
      // 事前準備
      storageRepository.clear();

      // メソッド実行
      await model.changeViewCompletedItems(VIEW_COMPLETED_ITEMS_TRUE_STRING);

      // 結果確認
      expect(
          await storageRepository.isExistKey(VIEW_COMPLETED_ITEMS_KEY), true);
      expect(
          await storageRepository
              .loadPersistenceStorage(VIEW_COMPLETED_ITEMS_KEY),
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
      expect(
          await storageRepository.isExistKey(VIEW_COMPLETED_ITEMS_KEY), false);
      expect(result, VIEW_COMPLETED_ITEMS_KEY_NONE);
    });

    test('正常系:keyがある時', () async {
      // 事前準備
      storageRepository.clear();
      storageRepository.savePersistenceStorage(
          VIEW_COMPLETED_ITEMS_KEY, VIEW_COMPLETED_ITEMS_TRUE_STRING);

      // メソッド実行
      await model.loadViewCompletedItems();

      // 結果確認
      expect(
          await storageRepository.isExistKey(VIEW_COMPLETED_ITEMS_KEY), true);
      expect(
          await storageRepository
              .loadPersistenceStorage(VIEW_COMPLETED_ITEMS_KEY),
          VIEW_COMPLETED_ITEMS_TRUE_STRING);
    });
  });
}
