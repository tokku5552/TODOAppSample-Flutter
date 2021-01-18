/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:todo_app_sample_flutter/common/persistence_storage_provider.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/infrastructure/storage_repository_impl.dart';
import 'package:todo_app_sample_flutter/infrastructure/todo_item_repository_impl.dart';
import 'package:todo_app_sample_flutter/presentation/main.dart';

class MainModel extends ChangeNotifier {
  MainModel() {
    this.viewCompletedItems =
        (loadViewCompletedItems().toString() == "true") ? true : false;
  }

  List<TodoItem> list = [];
  bool viewCompletedItems;
  final persistenceStorage = PersistenceStorageProvider.instance;

  void getTodoList() async {
    list = await TodoItemRepositoryImpl.getAll(
        viewCompletedItems: viewCompletedItems);
    notifyListeners();
  }

  void updateIsDone(int id, bool isDone) async {
    await TodoItemRepositoryImpl.updateIsDoneById(id, isDone);
    notifyListeners();
  }

  void deleteTodoItem(int id) async {
    await TodoItemRepositoryImpl.deleteTodoItem(id);
    notifyListeners();
  }

  changeViewCompletedItems(String s) {
    switch (s) {
      case VIEW_COMPLETED_ITEMS_TRUE_STRING:
        viewCompletedItems = true;
        break;
      case VIEW_COMPLETED_ITEMS_FALSE_STRING:
        viewCompletedItems = false;
        break;
    }
    StorageRepositoryImpl.savePersistenceStorage(
        VIEW_COMPLETED_ITEMS_KEY, viewCompletedItems.toString());
  }

  Future<String> loadViewCompletedItems() async {
    if (!await StorageRepositoryImpl.isExistKey(VIEW_COMPLETED_ITEMS_KEY)) {
      return VIEW_COMPLETED_ITEMS_KEY_NONE;
    } else {
      return await StorageRepositoryImpl.loadPersistenceStorage(
          VIEW_COMPLETED_ITEMS_KEY);
    }
  }
}
