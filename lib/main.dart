import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/main_model.dart';
import 'package:todo_app_sample_flutter/todo_item_detail_page.dart';

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
          title: Text("Todo App Sample Flutter"),
        ),
        body: Consumer<MainModel>(builder: (context, model, child) {
          final todoList = model.list;
          return ListView(
            children: todoList
                .map(
                  (todo) => ListTile(
                    title: Text(todo.title),
                  ),
                )
                .toList(),
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

  void pushWithReload(BuildContext context, MainModel model) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoItemDetailPage(),
        fullscreenDialog: true,
      ),
    );
    model.getTodoList();
  }
}
