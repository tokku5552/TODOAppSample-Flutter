/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/domain/storage_repository.dart';
import 'package:todo_app_sample_flutter/domain/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/todo_item_repository.dart';
import 'package:todo_app_sample_flutter/presentation/todo_item_detail/todo_item_detail_page.dart';
import 'package:todo_app_sample_flutter/presentation/todo_list/todo_list_model.dart';

class TodoListPage extends StatelessWidget {
  final _displayConfig = [
    viewCompletedItemsTrueString,
    viewCompletedItemsFalseString
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModel>(
      create: (_) => TodoListModel(
        storageRepository: context.read<StorageRepository>(),
        todoItemRepository: context.read<TodoItemRepository>(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TODOAppSample-Flutter'),
          actions: [
            Consumer<TodoListModel>(builder: (context, model, child) {
              return PopupMenuButton(
                initialValue: 'model.viewCompletedItems',
                onSelected: (String s) async {
                  await model.changeViewCompletedItems(s);
                  await model.getTodoList();
                },
                itemBuilder: (BuildContext context) {
                  return _displayConfig.map((String s) {
                    return PopupMenuItem(
                      child: Text(s),
                      value: s,
                    );
                  }).toList();
                },
              );
            })
          ],
        ),
        body: Consumer<TodoListModel>(builder: (context, model, child) {
          final todoList = model.list;
          return ListView(
            children: todoList
                    ?.map(
                      (todo) => ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (bool value) {
                            todo.isDone = !todo.isDone;
                            model.updateIsDone(
                                id: todo.id, isDone: todo.isDone);
                          },
                        ),
                        title: RichText(
                          text: TextSpan(
                            text: todo.title,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        onTap: () {
                          pushWithReload(context, model, todoItem: todo);
                        },
                        onLongPress: () async {
                          await showDialog<AlertDialog>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('${todo.title}を削除しますか？'),
                                actions: [
                                  FlatButton(
                                    onPressed: () async {
                                      await model.deleteAndReload(id: todo.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('はい'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('いいえ'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                    ?.toList() ??
                [
                  const ListTile(
                    title: Text(''),
                  )
                ],
          );
        }),
        floatingActionButton:
            Consumer<TodoListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () {
              pushWithReload(context, model);
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future<void> pushWithReload(BuildContext context, TodoListModel model,
      {TodoItem todoItem}) async {
    await Navigator.push<MaterialPageRoute>(
      context,
      MaterialPageRoute(
        builder: (context) => (todoItem == null)
            ? const TodoItemDetailPage()
            : TodoItemDetailPage(todoItem: todoItem),
        fullscreenDialog: true,
      ),
    );
    await model.getTodoList();
  }
}
