class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final String? description;
  final DateTime time;

  Todo(
      {required this.id,
      required this.title,
      this.isCompleted = false,
      this.description,
      required this.time});

  Todo copyWith(
      {String? id,
      String? title,
      bool? isCompleted,
      String? description,
      DateTime? time}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        description: description ?? this.description,
        time: time ?? this.time);
  }
}
