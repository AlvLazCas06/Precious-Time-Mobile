import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/features/task_list/bloc/task_list_bloc.dart';
import 'package:precious_time_mobile/features/task_list/ui/task_card.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key, this.preference});

  final PreferenceResponse? preference;

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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: widget.preference?.theme == 'dark'
            ? const Color(0xFF1E2939)
            : const Color.fromARGB(255, 249, 250, 251),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mis Tareas',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: widget.preference?.theme == 'dark' ? Colors.white : null,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt_outlined,
                  size: 30,
                  color: widget.preference?.theme == 'dark' ? Colors.white : null,
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                BlocBuilder<TaskListBloc, TaskListState>(
                  bloc: taskListBloc,
                  builder: (context, state) {
                    if (state is TaskListLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is TaskListSuccess) {
                      if (state.tasks.isEmpty) {
                        return Center(
                          child: Text(
                            'No tienes tareas pendientes actualmente',
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 22),
                              Text(
                                '${state.tasks.length} tareas en total',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: widget.preference?.theme == 'dark' ? Colors.white : null,
                                ),
                              ),
                              SizedBox(height: 22),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.tasks.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      TaskCard(
                                        taskListBloc: taskListBloc,
                                        id: state.tasks[index].id,
                                        label: state.tasks[index].title,
                                        description:
                                            state.tasks[index].description,
                                        status: state.tasks[index].status,
                                        priority: state.tasks[index].priority,
                                        date: state.tasks[index].completedAt,
                                        emoji:
                                            state.tasks[index].category.emoji,
                                        category:
                                            state.tasks[index].category.name,
                                        color: hexToColor(
                                          state.tasks[index].category.color,
                                        
                                        ),
                                        isDark: widget.preference?.theme == 'dark',
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    if (state is TaskListError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
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
            ),
          ),
        ],
      ),
    );
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
