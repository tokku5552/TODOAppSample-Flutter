import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/data/todo_item.dart';
import 'file:///C:/Users/physi/AndroidStudioProjects/todo_app_sample_flutter/lib/domain/main_model.dart';

import 'file:///C:/Users/physi/AndroidStudioProjects/todo_app_sample_flutter/lib/presentation/todo_item_detail_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getTodoList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("TODOAppSample-Flutter"),
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
