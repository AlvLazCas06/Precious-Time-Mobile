import 'package:flutter/material.dart';
import 'package:precious_time_mobile/features/create_project/ui/create_project_page.dart';
import 'package:precious_time_mobile/features/create_task/ui/create_task_page.dart';
import 'package:precious_time_mobile/features/edit_project/ui/edit_project_page.dart';
import 'package:precious_time_mobile/features/edit_task/ui/edit_task.dart';
import 'package:precious_time_mobile/features/home/ui/home_page_view.dart';
import 'package:precious_time_mobile/features/login/ui/login.dart';
import 'package:precious_time_mobile/features/project_view/ui/project_view.dart';
import 'package:precious_time_mobile/features/register/ui/register_page.dart';
import 'package:precious_time_mobile/features/task_view/ui/task_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precious Time',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePageView(),
        '/task/create': (context) => CreateTaskPage(),
        '/project/create': (context) => CreateProjectPage(),
        '/task/edit': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return EditTask(id: id);
        },
        '/project/edit': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return EditProjectPage(id: id);
        },
        '/task': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return TaskView(id: id);
        },
        '/project': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return ProjectView(id: id);
        },
      },
    );
  }
}
