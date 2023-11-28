import 'package:flutter/material.dart';
import 'package:todo_application/components/my_textfield.dart';
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
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
              child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter task name:',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextfield(
                  controller: _textController,
                  hintText: '',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
