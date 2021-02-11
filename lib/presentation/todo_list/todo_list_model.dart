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
        _todoItemRepository = todoItemRepository {
    this.viewCompletedItems =
        (loadViewCompletedItems().toString() == "true") ? true : false;
  }

  final TodoItemRepository _todoItemRepository;
  final StorageRepository _storageRepository;
  List<TodoItem> list = [];
  bool viewCompletedItems;

  void getTodoList() async {
    list = await _todoItemRepository.findAll(
        viewCompletedItems: viewCompletedItems);
    notifyListeners();
  }

  void updateIsDone(int id, bool isDone) async {
    final now = DateTime.now();
    await _todoItemRepository.updateIsDoneById(id, isDone, now);
    notifyListeners();
  }

  void deleteTodoItem(int id) async {
    await _todoItemRepository.delete(id);
    notifyListeners();
  }

  void changeViewCompletedItems(String s) {
    switch (s) {
      case VIEW_COMPLETED_ITEMS_TRUE_STRING:
        viewCompletedItems = true;
        break;
      case VIEW_COMPLETED_ITEMS_FALSE_STRING:
        viewCompletedItems = false;
        break;
    }
    _storageRepository.savePersistenceStorage(
        VIEW_COMPLETED_ITEMS_KEY, viewCompletedItems.toString());
  }

  Future<String> loadViewCompletedItems() async {
    if (!await _storageRepository.isExistKey(VIEW_COMPLETED_ITEMS_KEY)) {
      return VIEW_COMPLETED_ITEMS_KEY_NONE;
    } else {
      return await _storageRepository
          .loadPersistenceStorage(VIEW_COMPLETED_ITEMS_KEY);
    }
  }
}

const String VIEW_COMPLETED_ITEMS_TRUE_STRING = "完了済みのアイテムを表示する";
const String VIEW_COMPLETED_ITEMS_FALSE_STRING = "完了済みのアイテムを表示しない";
