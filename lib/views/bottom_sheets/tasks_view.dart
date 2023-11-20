import 'package:flutter/material.dart';
import 'package:todo_application/todo/todo_bloc.dart';
import 'package:todo_application/todo/todo_model.dart';

class TasksView extends StatelessWidget {
  TasksView({super.key});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'New Todo',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              todoBloc.addTodo(_textController.text);
              _textController.clear();
            },
            child: const Text('Add Todo'),
          ),
          StreamBuilder<List<Todo>>(
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
          ),
        ],
      ),
    );
  }
}
