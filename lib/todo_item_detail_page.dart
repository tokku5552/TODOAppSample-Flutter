import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_sample_flutter/todo_item_detail_model.dart';

class TodoItemDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoItemDetailModel>(
      create: (_) => TodoItemDetailModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("新規追加"),
        ),
        body: Consumer<TodoItemDetailModel>(builder: (context, model, child) {
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
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  child: Text("追加する"),
                  onPressed: () async {
                    await model.add();
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
