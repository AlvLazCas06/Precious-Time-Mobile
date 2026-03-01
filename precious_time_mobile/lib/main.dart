import 'package:flutter/material.dart';
import 'package:precious_time_mobile/features/create_project/ui/create_project_page.dart';
import 'package:precious_time_mobile/features/create_task/ui/create_task_page.dart';
import 'package:precious_time_mobile/features/home/ui/home_page_view.dart';
import 'package:precious_time_mobile/features/login/ui/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => HomePageView(),
        '/task/create': (context) => CreateTaskPage(),
        '/project/create': (context) => CreateProjectPage(),
      }
    );
  }
}