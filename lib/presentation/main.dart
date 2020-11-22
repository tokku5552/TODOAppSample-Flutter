import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/data/todo_item.dart';
import 'package:todo_app_sample_flutter/domain/main_model.dart';
import 'package:todo_app_sample_flutter/presentation/todo_item_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TodoAppSampleFlutter', home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  final _displayConfig = [
    VIEW_COMPLETED_ITEMS_TRUE_STRING,
    VIEW_COMPLETED_ITEMS_FALSE_STRING
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getTodoList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("TODOAppSample-Flutter"),
          actions: [
            Consumer<MainModel>(builder: (context, model, child) {
              return PopupMenuButton(
                initialValue: "model.viewCompletedItems",
                onSelected: (String s) {
                  model.changeViewCompletedItems(s);
                  model.getTodoList();
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
        body: Consumer<MainModel>(builder: (context, model, child) {
          final todoList = model.list;
          return ListView(
            children: todoList
                    ?.map(
                      (todo) => ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (bool value) {
                            todo.isDone = !todo.isDone;
                            model.updateIsDone(todo.id, todo.isDone);
                          },
                        ),
                        title: RichText(
                          text: TextSpan(
                            text: todo.title,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        onTap: () {
                          pushWithReload(context, model, todoItem: todo);
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("${todo.title}を削除しますか？"),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      model.deleteTodoItem(todo.id);
                                      model.getTodoList();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("はい"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("いいえ"),
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
                  ListTile(
                    title: Text(""),
                  )
                ],
          );
        }),
        floatingActionButton:
            Consumer<MainModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () {
              pushWithReload(context, model);
            },
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  void pushWithReload(BuildContext context, MainModel model,
      {TodoItem todoItem}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => (todoItem == null)
            ? TodoItemDetailPage()
            : TodoItemDetailPage(todoItem: todoItem),
        fullscreenDialog: true,
      ),
    );
    model.getTodoList();
  }
}

const String VIEW_COMPLETED_ITEMS_TRUE_STRING = "完了済みのアイテムを表示する";
const String VIEW_COMPLETED_ITEMS_FALSE_STRING = "完了済みのアイテムを表示しない";
