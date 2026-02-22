import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/task_list/ui/task_card.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 250, 251),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mis Tareas',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_alt_outlined, size: 30),
                        ),
                      ],
                    ),
                    SizedBox(height: 22),
                    Text(
                      '6 tareas en total',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    SizedBox(height: 22),
                    TaskCard(
                      label: 'Revisar propuesta de diseño',
                      description:
                          'Revisar la nueva propuesta de diseño para la aplicación móvil y ',
                      status: 'En proceso',
                      priority: 'Alta',
                      date: 'Mañana',
                      emoji: '🎨',
                      category: 'Diseño',
                      color: Colors.deepPurpleAccent,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/task/create');
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 21, 93, 255),
                    padding: EdgeInsets.all(16),
                  ),
                  iconSize: 28,
                ),
              ),
            ),
          ],
        );
  }
}