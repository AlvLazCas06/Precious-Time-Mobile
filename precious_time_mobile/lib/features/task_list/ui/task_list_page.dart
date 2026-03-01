import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/features/task_list/bloc/task_list_bloc.dart';
import 'package:precious_time_mobile/features/task_list/ui/task_card.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late TaskListBloc taskListBloc;

  @override
  void initState() {
    super.initState();
    taskListBloc = TaskListBloc(TaskService())..add(TaskListFetchAllEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      bloc: taskListBloc,
      builder: (context, state) {
        if (state is TaskListLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TaskListSuccess) {
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
                        '${state.tasks.length} tareas en total',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      SizedBox(height: 22),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            label: state.tasks[index].title,
                            description: state.tasks[index].description,
                            status: state.tasks[index].status,
                            priority: state.tasks[index].priority,
                            date: state.tasks[index].completedAt!,
                            emoji: state.tasks[index].category.emoji,
                            category: state.tasks[index].category.name,
                            color: Colors.black,
                          );
                        },
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
        if (state is TaskListError) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
