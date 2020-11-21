class TodoItem {
  TodoItem({this.id, this.title, this.body, this.createdAt, this.updatedAt});

  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;

  // define getter
  int get getId => id;
  String get getTitle => '$title';
  String get getBody => '$body';
  DateTime get getUpdatedAt => updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, createdAt: $createdAt}';
  }
}
