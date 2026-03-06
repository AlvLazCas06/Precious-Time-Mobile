import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/features/task_view/bloc/task_view_bloc.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, required this.id});

  final String id;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskViewBloc taskViewBloc;
  TaskResponse? _task;

  @override
  void initState() {
    super.initState();
    taskViewBloc = TaskViewBloc(TaskService())
      ..add(TaskViewFetchEvent(id: int.parse(widget.id)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskViewBloc, TaskViewState>(
      bloc: taskViewBloc,
      listener: (context, state) {
        if (state is TaskViewSuccess) {
          setState(() => _task = state.taskResponse);
        }
        if (state is TaskCompletedSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tarea completada exitosamente')),
          );
        }
        if (state is TaskViewError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (_task == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Detalle de tarea',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
            body: state is TaskViewError
                ? Center(
                    child: Text(
                      state.message,
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        }

        final task = _task!;
        final categoryColor = hexToColor(task.category.color);

        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                task.title,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 250, 251),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                task.category.emoji,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                task.category.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: categoryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _priorityColor(
                              task.priority,
                            ).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            task.priority,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _priorityColor(task.priority),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: Color.fromARGB(255, 106, 114, 130),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Descripción',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(
                                    255,
                                    106,
                                    114,
                                    130,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            task.description.isNotEmpty
                                ? task.description
                                : 'Sin descripción',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: task.description.isNotEmpty
                                  ? Colors.black87
                                  : const Color.fromARGB(255, 153, 161, 175),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    _SectionCard(
                      child: Column(
                        children: [
                          _InfoRow(
                            icon: Icons.folder_outlined,
                            label: 'Proyecto',
                            value: task.projectName,
                          ),
                          const Divider(height: 24),
                          _InfoRow(
                            icon: Icons.person_outline,
                            label: 'Autor',
                            value: task.author,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    _SectionCard(
                      child: Column(
                        children: [
                          _InfoRow(
                            icon: Icons.flag_outlined,
                            label: 'Estado',
                            value: task.status,
                          ),
                          if (task.completedAt != null) ...[
                            const Divider(height: 24),
                            _InfoRow(
                              icon: Icons.calendar_today_outlined,
                              label: 'Fecha de vencimiento',
                              value: task.completedAt!,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton(
                        onPressed: state is TaskViewLoading
                            ? null
                            : () {
                                taskViewBloc.add(
                                  TaskCheckCompleteEvent(id: int.parse(widget.id)),
                                );
                              },
                        backgroundColor: const Color.fromARGB(255, 100, 221, 148),
                        child: state is TaskViewLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Completar tarea',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'alta':
        return Colors.red;
      case 'media':
        return Colors.orange;
      case 'baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color.fromARGB(255, 106, 114, 130)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color.fromARGB(255, 106, 114, 130),
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
