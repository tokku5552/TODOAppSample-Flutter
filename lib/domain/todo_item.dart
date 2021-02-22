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

  factory TodoItem.fromMap(Map<String, dynamic> json) => TodoItem(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
        updatedAt: DateTime.parse(json['updatedAt'] as String).toLocal(),
        isDone: json['isDone'] == '1',
      );

  final int id;
  String title;
  String body;
  final DateTime createdAt;
  DateTime updatedAt;
  bool isDone;

  // define getter
  int get getId => id;
  String get getTitle => '$title';
  String get getBody => '$body';
  DateTime get getUpdatedAt => updatedAt;
  bool get getIsDone => isDone;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      'isDone': isDone ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, createdAt: $createdAt}';
  }
}
