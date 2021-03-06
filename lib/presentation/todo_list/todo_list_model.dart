/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/domain/storage_repository.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';

class TodoListModel extends ChangeNotifier {
  TodoListModel({
    @required StorageRepository storageRepository,
    @required TodoItemRepository todoItemRepository,
  })  : _storageRepository = storageRepository,
        _todoItemRepository = todoItemRepository;
  final TodoItemRepository _todoItemRepository;
  final StorageRepository _storageRepository;
  List<TodoItem> list = [];
  bool viewCompletedItems;

  Future<void> init() async {
    viewCompletedItems = await loadViewCompletedItems();
    await getTodoList();
  }

  Future<void> getTodoList() async {
    list = await _todoItemRepository.findAll(
        viewCompletedItems: viewCompletedItems);
    notifyListeners();
  }

  Future<void> updateIsDone({@required int id, @required bool isDone}) async {
    await _todoItemRepository.updateIsDoneById(id: id, isDone: isDone);
    notifyListeners();
  }

  Future<void> deleteTodoItem({@required int id}) async {
    await _todoItemRepository.delete(id: id);
    notifyListeners();
  }

  Future<void> deleteAndReload({@required int id}) async {
    await deleteTodoItem(id: id);
    await getTodoList();
  }

  Future<void> changeViewCompletedItems(String viewCompletedItemString) async {
    switch (viewCompletedItemString) {
      case viewCompletedItemsTrueString:
        viewCompletedItems = true;
        break;
      case viewCompletedItemsFalseString:
        viewCompletedItems = false;
        break;
    }
    await _storageRepository.savePersistenceStorage(
        viewCompletedItemsKey, viewCompletedItems.toString());
  }

  Future<bool> loadViewCompletedItems() async {
    if (!await _storageRepository.isExistKey(viewCompletedItemsKey)) {
      return null;
    } else {
      final result = await _storageRepository
          .loadPersistenceStorage(viewCompletedItemsKey);
      return result == 'true';
    }
  }
}

const String viewCompletedItemsTrueString = '完了済みのアイテムを表示する';
const String viewCompletedItemsFalseString = '完了済みのアイテムを表示しない';
