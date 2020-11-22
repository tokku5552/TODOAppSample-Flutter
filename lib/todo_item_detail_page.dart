import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/todo_item.dart';
import 'package:todo_app_sample_flutter/todo_item_detail_model.dart';

class TodoItemDetailPage extends StatelessWidget {
  TodoItemDetailPage({this.todoItem});
  final TodoItem todoItem;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = todoItem != null;
    final titleEditingController = TextEditingController();
    final detailEditingController = TextEditingController();
    titleEditingController.text = todoItem?.title;
    detailEditingController.text = todoItem?.body;
    return ChangeNotifierProvider<TodoItemDetailModel>(
      create: (_) => TodoItemDetailModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? "タスクの更新" : "新規追加"),
        ),
        body: Consumer<TodoItemDetailModel>(builder: (context, model, child) {
          model.todoTitle = todoItem?.title;
          model.todoBody = todoItem?.body;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "タイトル",
                    hintText: "やること",
                  ),
                  onChanged: (title) {
                    model.todoTitle = title;
                  },
                  controller: titleEditingController,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "詳細",
                    hintText: "やることの詳細",
                  ),
                  onChanged: (body) {
                    model.todoBody = body;
                  },
                  controller: detailEditingController,
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  child: Text(isUpdate ? "更新する" : "追加する"),
                  onPressed: () async {
                    isUpdate
                        ? await model.update(todoItem.id)
                        : await model.add();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
