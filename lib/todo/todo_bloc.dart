import 'package:bloc/bloc.dart';
import 'package:todo_application/todo/todo_model.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final DateTime time;
  final String description;

  AddTodoEvent({
    required this.title,
    required this.time,
    required this.description,
  });
}

class ToggleTodoEvents extends TodoEvent {
  final String id;

  ToggleTodoEvents({required this.id});
}

class RemoveTodoEvent extends TodoEvent {
  final String id;

  RemoveTodoEvent({required this.id});
}

class FetchTodos extends TodoEvent {}

class TodoState {
  final List<Todo> todos;

  TodoState({required this.todos});
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final firestoreInstance = FirebaseFirestore.instance.collection('tasks');

  TodoBloc() : super(TodoState(todos: [])) {
    on<AddTodoEvent>(_addTodo);

    on<ToggleTodoEvents>(_toggleTodo);

    on<RemoveTodoEvent>(_removeTodo);

    on<FetchTodos>(fetchTodos);

    add(FetchTodos());
  }

  void fetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    final snapshots = await firestoreInstance.get();
    final todos = snapshots.docs.map((e) => Todo.fromJSON(e.data())).toList();
    emit(TodoState(todos: todos));
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    Todo todo = Todo(
      id: const Uuid().v4(),
      title: event.title,
      time: event.time,
      description: event.description,
    );
    final oldTodos = state.todos;
    emit(
      TodoState(
        todos: [...oldTodos, todo],
      ),
    );
    firestoreInstance.doc(todo.id).set(todo.toJSON());
  }

  void _toggleTodo(ToggleTodoEvents event, Emitter<TodoState> emit) {
    final stateTodos = state.todos;
    final todoToggle = stateTodos.firstWhere(
      (todo) {
        return todo.id == event.id;
      },
    );
    final toggledTodo = todoToggle.copyWith(
      isCompleted: !todoToggle.isCompleted,
    );
    final updatedTodos = stateTodos.map((todo) {
      if (todo.id == toggledTodo.id) {
        return toggledTodo;
      }
      return todo;
    }).toList();
    emit(TodoState(todos: updatedTodos));
    firestoreInstance.doc(toggledTodo.id).update(
      {'isCompleted': toggledTodo.isCompleted},
    );
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    final stateTodos = state.todos;

    final updatedTodo = stateTodos
        .where(
          (todo) => todo.id != event.id,
        )
        .toList();
    emit(TodoState(todos: updatedTodo));
    firestoreInstance.doc(event.id).delete();
  }
}
