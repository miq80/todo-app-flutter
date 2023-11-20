import 'package:flutter/material.dart';
import 'package:todo_application/components/my_textfield.dart';
import 'package:todo_application/views/bottom_sheets/tasks_view.dart';
import 'package:todo_application/views/header_view.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: TasksView(),
      ),
    );
  }
}
