import 'package:flutter/material.dart';
import 'package:todo_application/todo/todo_bloc.dart';

class TaskFormView extends StatelessWidget {
  TaskFormView({super.key});

  final _textController = TextEditingController();
  void addTask() {
    todoBloc.addTodo(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              addTask();
            },
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}
