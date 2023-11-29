import 'dart:async';
import 'todo_model.dart';

class TodoBloc {
  final _todoController = StreamController<List<Todo>>.broadcast();

  final List<Todo> _todos = [];

  Stream<List<Todo>> get todos => _todoController.stream;

  void addTodo(
      {required String title, required DateTime time, required Todo newTask}) {
    final newTodo = Todo(
      id: newTask.id,
      title: title,
      description: newTask.description,
      time: time,
    );
    _todos.add(newTodo);
    _updateTodos();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] =
          _todos[index].copyWith(isCompleted: !_todos[index].isCompleted);
      _updateTodos();
    }
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _updateTodos();
  }

  void _updateTodos() {
    _todoController.add(List.from(_todos));
  }

  void dispose() {
    _todoController.close();
  }
}

final todoBloc = TodoBloc();
