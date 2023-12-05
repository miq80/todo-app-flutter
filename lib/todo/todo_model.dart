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
      required this.description,
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

  Map<String, dynamic> toJSON() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'description': description,
        'time': time.toIso8601String()
      };

  Todo.fromJSON(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          isCompleted: json['isCompleted'],
          description: json['description'],
          time: DateTime.parse(
            json['time'],
          ),
        );
}
