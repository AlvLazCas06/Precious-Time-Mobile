import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/service/preference_service.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/features/project_view/bloc/project_view_bloc.dart';
import 'package:precious_time_mobile/features/settings/bloc/preference_bloc/preference_bloc.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key, required this.id});

  final String id;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  late ProjectViewBloc projectViewBloc;
  late PreferenceBloc preferenceBloc;
  Project? _project;
  PreferenceResponse? _preference;

  @override
  void initState() {
    super.initState();
    projectViewBloc = ProjectViewBloc(ProjectService(), TaskService())
      ..add(ProjectViewFetchEvent(id: int.parse(widget.id)));
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

          return BlocConsumer<ProjectViewBloc, ProjectViewState>(
            bloc: projectViewBloc,
            listener: (context, state) {
              if (state is ProjectViewSuccess) {
                setState(() => _project = state.project);
              }
              if (state is ProjectViewCancelSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Proyecto cancelado exitosamente')),
                );
              }
              if (state is ProjectViewCompleteTaskSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Tarea marcada como completada')),
                );
              }
              if (state is ProjectViewError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (_project == null) {
                return Scaffold(
                  backgroundColor: bgColor,
                  appBar: AppBar(
                    backgroundColor: surfaceColor,
                    iconTheme: IconThemeData(color: textColor),
                    title: Text(
                      'Detalle del proyecto',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  body: state is ProjectViewError
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

              final project = _project!;

              return Scaffold(
                backgroundColor: bgColor,
                appBar: AppBar(
                  backgroundColor: surfaceColor,
                  iconTheme: IconThemeData(color: textColor),
                  title: Text(
                    project.name,
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
                                color: _statusColor(project.status)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                project.status,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: _statusColor(project.status),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        _SectionCard(
                          surfaceColor: surfaceColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.bar_chart_outlined,
                                      size: 20, color: subtitleColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Progreso',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: subtitleColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\%',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 21, 93, 252),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: project.progress,
                                  minHeight: 8,
                                  backgroundColor: isDark
                                      ? const Color(0xFF4B5563)
                                      : const Color.fromARGB(
                                          255, 229, 231, 235),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 21, 93, 252),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

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
                                (project.description != null &&
                                        project.description!.isNotEmpty)
                                    ? project.description!
                                    : 'Sin descripcion',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: (project.description != null &&
                                          project.description!.isNotEmpty)
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
                                icon: Icons.person_outline,
                                label: 'Autor',
                                value: project.author,
                                isDark: isDark,
                              ),
                              Divider(
                                  height: 24,
                                  color: isDark
                                      ? const Color(0xFF4B5563)
                                      : null),
                              _InfoRow(
                                icon: Icons.calendar_today_outlined,
                                label: 'Fecha de inicio',
                                value: project.startDate,
                                isDark: isDark,
                              ),
                              Divider(
                                  height: 24,
                                  color: isDark
                                      ? const Color(0xFF4B5563)
                                      : null),
                              _InfoRow(
                                icon: Icons.event_outlined,
                                label: 'Fecha de fin',
                                value: project.finishDate,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (project.tasks.isNotEmpty) ...[
                          _SectionCard(
                            surfaceColor: surfaceColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.task_alt_outlined,
                                        size: 20, color: subtitleColor),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Tareas (\)',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: subtitleColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ...project.tasks.map(
                                  (task) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            task.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                _priorityColor(task.priority)
                                                    .withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            task.priority,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: _priorityColor(
                                                  task.priority),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        IconButton(
                                          tooltip: 'Marcar como completada',
                                          icon: const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                          onPressed:
                                              state is ProjectViewLoading
                                                  ? null
                                                  : () {
                                                      projectViewBloc.add(
                                                        ProjectViewCompleteTaskEvent(
                                                          taskId: task.id,
                                                          projectId:
                                                              int.parse(
                                                                  widget.id),
                                                        ),
                                                      );
                                                    },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: FloatingActionButton(
                            onPressed: state is ProjectViewLoading
                                ? null
                                : () {
                                    projectViewBloc.add(
                                      ProjectViewCancelEvent(
                                          id: int.parse(widget.id)),
                                    );
                                  },
                            backgroundColor:
                                const Color.fromARGB(255, 221, 100, 100),
                            child: state is ProjectViewLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    'Cancelar proyecto',
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

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completado':
        return Colors.green;
      case 'en progreso':
        return const Color.fromARGB(255, 21, 93, 252);
      case 'pendiente':
        return Colors.orange;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
