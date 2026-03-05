import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';
import 'package:precious_time_mobile/features/project_list/bloc/project_list_bloc.dart';
import 'package:precious_time_mobile/features/project_list/ui/project_card.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  late ProjectListBloc projectListBloc;

  @override
  void initState() {
    super.initState();
    projectListBloc = ProjectListBloc(ProjectService())
      ..add(ProjectListFetchAllEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: Color.fromARGB(255, 249, 250, 251)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Proyectos',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text('proyectos activos', style: GoogleFonts.poppins()),
          SizedBox(height: 20),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                BlocBuilder<ProjectListBloc, ProjectListState>(
                  bloc: projectListBloc,
                  builder: (context, state) {
                    if (state is ProjectListLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is ProjectListSuccess) {
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.projects.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ProjectCard(
                                      label: state.projects[index].name,
                                      description:
                                          state.projects[index].description,
                                      percent: state.projects[index].progress,
                                      startDate: state.projects[index].startDate,
                                      finishDate:
                                          state.projects[index].finishDate,
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is ProjectListError) {
                      Center(child: Text(state.message));
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
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, '/project/create');
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
}
