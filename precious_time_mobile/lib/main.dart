import 'package:flutter/material.dart';
import 'package:precious_time_mobile/features/create_project/ui/create_project_page.dart';
import 'package:precious_time_mobile/features/create_task/ui/create_task_page.dart';
import 'package:precious_time_mobile/features/edit_task/ui/edit_task.dart';
import 'package:precious_time_mobile/features/home/ui/home_page_view.dart';
import 'package:precious_time_mobile/features/login/ui/login.dart';

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
        '/home': (context) => HomePageView(),
        '/task/create': (context) => CreateTaskPage(),
        '/project/create': (context) => CreateProjectPage(),
        '/task/edit': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return EditTask(id: id);
        },
      },
    );
  }
}
