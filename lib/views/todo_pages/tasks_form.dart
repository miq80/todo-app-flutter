import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/components/my_textfield.dart';
import 'package:todo_application/todo/todo_bloc.dart';
import 'package:todo_application/components/my_button.dart';
import 'package:todo_application/todo/todo_model.dart';

class TaskFormView extends StatefulWidget {
  const TaskFormView({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskFormViewState createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final _textController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _time;

  @override
  void initState() {
    super.initState();
    _time = DateTime.now(); // Set a default time
  }

  Future<void> _selectTime(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      // ignore: use_build_context_synchronously
      TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_time),
      );

      if (picked != null) {
        setState(() {
          _time = DateTime(
            _time.year,
            _time.month,
            _time.day,
            picked.hour,
            picked.minute,
          );
        });
      } else {
        // Handle the case where the user cancels the time picker
        // ignore: avoid_print
        print('User canceled the time picker');
      }
    } catch (e) {
      // Handle any exceptions
      // ignore: avoid_print
      print("Error selecting time: $e");
    }
  }

  void addTask(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      context.read<TodoBloc>().add(
            AddTodoEvent(
                title: _textController.text,
                time: _time,
                description: _descriptionController.text),
          );

      _textController.clear();
      _descriptionController.clear();
    }
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
                  const SizedBox(height: 10),
                  const Text(
                    'Enter task name:',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  MyTextfield(
                    controller: _textController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  MyTextfield(
                    controller: _descriptionController,
                    hintText: 'Description',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // button border radius
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        'Select Time',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  MyButton(onTap: () => addTask(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
