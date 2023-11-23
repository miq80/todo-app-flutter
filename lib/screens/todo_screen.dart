import 'package:flutter/material.dart';
import 'package:todo_application/components/my_textfield.dart';
import 'package:todo_application/views/todo_pages/tasks_form.dart';
import 'package:todo_application/views/header_view.dart';
import 'package:todo_application/views/todo_pages/tasks_list.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.add_task,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TaskFormView(),
              const TasksList(),
            ],
          ),
        ),
      ),
    );
  }
}
