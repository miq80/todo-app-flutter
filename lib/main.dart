import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/screens/registration_page.dart';
import 'package:todo_application/screens/todo_screen.dart';
import 'package:todo_application/todo/todo_bloc.dart';
import 'firebase_options.dart';
import 'screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TodoBloc();
      },
      child: MaterialApp(
        routes: {
          '/': (context) => LoginPage(),
          '/registration': (context) => RegistrationPage(),
          '/todo': (context) => TodoListPage(),
        },
      ),
    );
  }
}
