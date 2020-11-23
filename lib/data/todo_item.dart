/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
class TodoItem {
  TodoItem(
      {this.id,
      this.title,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.isDone});

  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isDone;

  // define getter
  int get getId => id;

  String get getTitle => '$title';

  String get getBody => '$body';

  DateTime get getUpdatedAt => updatedAt;

  bool get getIsDone => isDone;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      'isDone': (isDone) ? 1 : 0,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> json) => TodoItem(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        isDone: (json["isDone"] == "1") ? true : false,
      );

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, createdAt: $createdAt}';
  }
}
