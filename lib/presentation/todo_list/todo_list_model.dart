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

  Future<void> updateIsDone(int id, bool isDone) async {
    await _todoItemRepository.updateIsDoneById(id, isDone);
    notifyListeners();
  }

  Future<void> deleteTodoItem(int id) async {
    await _todoItemRepository.delete(id);
    notifyListeners();
  }

  Future<void> changeViewCompletedItems(String s) async {
    switch (s) {
      case VIEW_COMPLETED_ITEMS_TRUE_STRING:
        viewCompletedItems = true;
        break;
      case VIEW_COMPLETED_ITEMS_FALSE_STRING:
        viewCompletedItems = false;
        break;
    }
    await _storageRepository.savePersistenceStorage(
        VIEW_COMPLETED_ITEMS_KEY, viewCompletedItems.toString());
  }

  Future<bool> loadViewCompletedItems() async {
    if (!await _storageRepository.isExistKey(VIEW_COMPLETED_ITEMS_KEY)) {
      return null;
    } else {
      final result = await _storageRepository
          .loadPersistenceStorage(VIEW_COMPLETED_ITEMS_KEY);
      print(result);
      return result == 'true';
    }
  }
}

const String VIEW_COMPLETED_ITEMS_TRUE_STRING = "完了済みのアイテムを表示する";
const String VIEW_COMPLETED_ITEMS_FALSE_STRING = "完了済みのアイテムを表示しない";
