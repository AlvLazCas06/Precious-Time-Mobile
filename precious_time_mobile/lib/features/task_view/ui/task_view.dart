import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';
import 'package:precious_time_mobile/core/service/preference_service.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/features/settings/bloc/preference_bloc/preference_bloc.dart';
import 'package:precious_time_mobile/features/task_view/bloc/task_view_bloc.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, required this.id});

  final String id;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskViewBloc taskViewBloc;
  late PreferenceBloc preferenceBloc;
  TaskResponse? _task;
  PreferenceResponse? _preference;

  @override
  void initState() {
    super.initState();
    taskViewBloc = TaskViewBloc(TaskService())
      ..add(TaskViewFetchEvent(id: int.parse(widget.id)));
    preferenceBloc = PreferenceBloc(PreferenceService())
      ..add(PreferenceFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: preferenceBloc,
      child: BlocConsumer<PreferenceBloc, PreferenceState>(
        listener: (context, prefState) {
          if (prefState is PreferenceSuccess) {
            setState(() => _preference = prefState.preferenceResponse);
          }
        },
        builder: (context, prefState) {
          final isDark = _preference?.theme == 'dark';
          final bgColor = isDark
              ? const Color(0xFF1E2939)
              : const Color.fromARGB(255, 249, 250, 251);
          final surfaceColor =
              isDark ? const Color(0xFF364153) : Colors.white;
          final textColor = isDark ? Colors.white : Colors.black87;
          final subtitleColor = const Color.fromARGB(255, 106, 114, 130);

          return BlocConsumer<TaskViewBloc, TaskViewState>(
            bloc: taskViewBloc,
            listener: (context, state) {
              if (state is TaskViewSuccess) {
                setState(() => _task = state.taskResponse);
              }
              if (state is TaskCompletedSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Tarea completada exitosamente')),
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
                  backgroundColor: bgColor,
                  appBar: AppBar(
                    backgroundColor: surfaceColor,
                    iconTheme: IconThemeData(color: textColor),
                    title: Text(
                      'Detalle de tarea',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  body: state is TaskViewError
                      ? Center(
                          child: Text(
                            state.message,
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: textColor),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                );
              }

              final task = _task!;
              final categoryColor = hexToColor(task.category.color);

              return Scaffold(
                backgroundColor: bgColor,
                appBar: AppBar(
                  backgroundColor: surfaceColor,
                  iconTheme: IconThemeData(color: textColor),
                  title: Text(
                    task.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    color: bgColor,
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
                                color: _priorityColor(task.priority)
                                    .withOpacity(0.15),
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
                          surfaceColor: surfaceColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.description_outlined,
                                      size: 20, color: subtitleColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Descripcion',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                task.description.isNotEmpty
                                    ? task.description
                                    : 'Sin descripcion',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: task.description.isNotEmpty
                                      ? textColor
                                      : subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _SectionCard(
                          surfaceColor: surfaceColor,
                          child: Column(
                            children: [
                              _InfoRow(
                                icon: Icons.folder_outlined,
                                label: 'Proyecto',
                                value: task.projectName,
                                isDark: isDark,
                              ),
                              Divider(
                                  height: 24,
                                  color: isDark
                                      ? const Color(0xFF4B5563)
                                      : null),
                              _InfoRow(
                                icon: Icons.person_outline,
                                label: 'Autor',
                                value: task.author,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _SectionCard(
                          surfaceColor: surfaceColor,
                          child: Column(
                            children: [
                              _InfoRow(
                                icon: Icons.flag_outlined,
                                label: 'Estado',
                                value: task.status,
                                isDark: isDark,
                              ),
                              if (task.completedAt != null) ...[
                                Divider(
                                    height: 24,
                                    color: isDark
                                        ? const Color(0xFF4B5563)
                                        : null),
                                _InfoRow(
                                  icon: Icons.calendar_today_outlined,
                                  label: 'Fecha de vencimiento',
                                  value: task.completedAt!,
                                  isDark: isDark,
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
                                      TaskCheckCompleteEvent(
                                          id: int.parse(widget.id)),
                                    );
                                  },
                            backgroundColor:
                                const Color.fromARGB(255, 100, 221, 148),
                            child: state is TaskViewLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    'Completar tarea',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
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
        },
      ),
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
  const _SectionCard({required this.child, required this.surfaceColor});

  final Widget child;
  final Color surfaceColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
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
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final subtitleColor = const Color.fromARGB(255, 106, 114, 130);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: subtitleColor),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: subtitleColor,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
