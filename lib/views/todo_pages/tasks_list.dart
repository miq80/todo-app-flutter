import 'package:flutter/material.dart';
import 'package:todo_application/todo/todo_bloc.dart';
import 'package:todo_application/todo/todo_model.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: todoBloc.todos,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No todos yet.');
        }
        return Column(
          children: snapshot.data!.map((todo) {
            return ListTile(
              title: Text(todo.title),
              trailing: Checkbox(
                value: todo.isCompleted,
                onChanged: (isChecked) {
                  todoBloc.toggleTodo(todo.id);
                },
              ),
              onTap: () {
                todoBloc.removeTodo(todo.id);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
