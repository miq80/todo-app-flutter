import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/todo/todo_bloc.dart';
import 'package:todo_application/todo/todo_model.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return const Text(
            'No todos yet.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          );
        }

        return Column(
          children: state.todos.map((todo) {
            return ListTile(
              leading: const Icon(Icons.task),
              style: ListTileStyle.drawer,
              subtitleTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.black12),
              title: Text(
                todo.title,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              subtitle: Column(children: [
                if (todo.description != null)
                  Text(
                    todo.description!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                Text(
                  todo.time.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )
              ]),
              trailing: Checkbox(
                value: todo.isCompleted,
                onChanged: (isChecked) {
                  context.read<TodoBloc>().add(ToggleTodoEvents(id: todo.id));
                },
              ),
              isThreeLine: true,
              onTap: () {
                context.read<TodoBloc>().add(RemoveTodoEvent(id: todo.id));
              },
            );
          }).toList(),
        );
      },
    );
  }
}
