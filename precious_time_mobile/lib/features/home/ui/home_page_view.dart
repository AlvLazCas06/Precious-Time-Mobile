import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/preference_service.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/core/service/user_service.dart';
import 'package:precious_time_mobile/features/home/bloc/project_bloc/project_home_bloc.dart';
import 'package:precious_time_mobile/features/home/bloc/task_bloc/task_home_bloc.dart';
import 'package:precious_time_mobile/features/home/bloc/user_bloc/user_home_bloc.dart';
import 'package:precious_time_mobile/features/home/ui/active_projects.dart';
import 'package:precious_time_mobile/features/home/ui/app_bar_precious_time.dart';
import 'package:precious_time_mobile/features/home/ui/card_task_home.dart';
import 'package:precious_time_mobile/features/home/ui/summary_box_widget.dart';
import 'package:precious_time_mobile/features/project_list/ui/project_list_page.dart';
import 'package:precious_time_mobile/features/settings/bloc/preference_bloc/preference_bloc.dart';
import 'package:precious_time_mobile/features/settings/ui/settings_page.dart';
import 'package:precious_time_mobile/features/task_list/ui/task_list_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int currentPageIndex = 0;
  late UserHomeBloc userHomeBloc;
  late TaskHomeBloc taskHomeBloc;
  late ProjectHomeBloc projectHomeBloc;
  late PreferenceBloc preferenceBloc;
  PreferenceResponse? _preference;

  @override
  void initState() {
    super.initState();
    preferenceBloc = PreferenceBloc(PreferenceService())
      ..add(PreferenceFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: preferenceBloc,
      child: BlocConsumer<PreferenceBloc, PreferenceState>(
        listener: (context, state) {
          if (state is PreferenceSuccess) {
            setState(() => _preference = state.preferenceResponse);
          }
        },
        builder: (context, prefState) {
          final isDark = _preference?.theme == 'dark';
          final bgColor = isDark
              ? const Color(0xFF1E2939)
              : const Color.fromARGB(255, 249, 250, 251);
          final surfaceColor =
              isDark ? const Color(0xFF364153) : Colors.white;
          final textColor = isDark ? Colors.white : Colors.black;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: surfaceColor,
              title: AppBarPreciousTime(preference: _preference),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              backgroundColor: surfaceColor,
              indicatorColor: isDark
                  ? const Color(0xFF1E2939)
                  : Colors.white,
              selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/images/home_icon.svg',
              color: Color.fromARGB(255, 21, 93, 252),
            ),
            icon: SvgPicture.asset(
              'assets/images/home_icon.svg',
              color: Color.fromARGB(255, 106, 114, 130),
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/images/project_icon.svg',
              color: Color.fromARGB(255, 21, 93, 252),
            ),
            icon: SvgPicture.asset(
              'assets/images/project_icon.svg',
              color: Color.fromARGB(255, 106, 114, 130),
            ),
            label: 'Proyectos',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/images/task_icon.svg',
              color: Color.fromARGB(255, 21, 93, 252),
            ),
            icon: SvgPicture.asset(
              'assets/images/task_icon.svg',
              color: Color.fromARGB(255, 106, 114, 130),
            ),
            label: 'Tareas',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/images/settings_icon.svg',
              color: Color.fromARGB(255, 21, 93, 252),
            ),
            icon: SvgPicture.asset(
              'assets/images/settings_icon.svg',
              color: Color.fromARGB(255, 106, 114, 130),
            ),
            label: 'Ajustes',
          ),
        ],
      ),
      body: [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      userHomeBloc = UserHomeBloc(UserService())
                        ..add(UserHomeFetchEvent()),
                ),
                BlocProvider(
                  create: (context) =>
                      taskHomeBloc = TaskHomeBloc(TaskService())
                        ..add(TaskHomeFetchEvent()),
                ),
                BlocProvider(
                  create: (context) =>
                      projectHomeBloc = ProjectHomeBloc(ProjectService())
                        ..add(ProjectHomeFetchEvent()),
                ),
              ],
              child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: bgColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder(
                                bloc: BlocProvider.of<UserHomeBloc>(context),
                                builder: (context, state) {
                                  if (state is UserHomeLoading) {
                                    return Text(
                                      'Hola, 👋',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: textColor,
                                      ),
                                    );
                                  }
                                  if (state is UserHomeSuccess) {
                                    return Text(
                                      'Hola, ${state.user.name} 👋',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: textColor,
                                      ),
                                    );
                                  }
                                  return Text(
                                      'Hola, María 👋',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: textColor,
                                      ),
                                    );
                                },
                              ),
                              Text(
                                'Aquí está tu resumen de hoy',
                                style: GoogleFonts.poppins(color: textColor),
                              ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resumen de hoy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SummaryBoxWidget(
                                icon: Icons.timer_outlined,
                                iconColor: Color.fromARGB(255, 43, 127, 255),
                                label: 'Pendientes',
                                totalTasks: 5,
                                isDark: isDark,
                              ),
                              SummaryBoxWidget(
                                icon: Icons.error_outline,
                                iconColor: Color.fromARGB(255, 255, 105, 0),
                                label: 'En progreso',
                                totalProjects: 2,
                                isDark: isDark,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SummaryBoxWidget(
                                icon: Icons.check_circle_outline,
                                iconColor: Color.fromARGB(255, 0, 201, 80),
                                label: 'Completados',
                                totalTasks: 5,
                                totalProjects: 2,
                                isDark: isDark,
                              ),
                              SummaryBoxWidget(
                                icon: Icons.moving,
                                iconColor: Color.fromARGB(255, 173, 70, 255),
                                label: 'Total hoy',
                                totalTasks: 5,
                                totalProjects: 2,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Proyectos activos',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: textColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentPageIndex = 1;
                                  });
                                },
                                child: Text(
                                  'Ver todos',
                                  style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 21, 93, 255),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          BlocBuilder(
                            bloc: BlocProvider.of<ProjectHomeBloc>(context),
                            builder: (context, state) {
                              if (state is ProjectHomeLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is ProjectHomeSuccess) {
                                if (state.projects.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No tienes proyectos activos actualmente',
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.projects.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ActiveProjects(
                                            color: Color.fromARGB(
                                              255,
                                              139,
                                              92,
                                              246,
                                            ),
                                            label: state.projects[index].name,
                                            percent: state
                                                .projects[index]
                                                .percent
                                                .floor(),
                                            isDark: isDark,
                                          ),
                                          SizedBox(height: 14),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tareas pendientes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: textColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentPageIndex = 2;
                                  });
                                },
                                child: Text(
                                  'Ver todos',
                                  style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 21, 93, 255),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder(
                            bloc: BlocProvider.of<TaskHomeBloc>(context),
                            builder: (context, state) {
                              if (state is TaskHomeLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is TaskHomeSuccess) {
                                if (state.tasks.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No tienes tareas pendientes.',
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.tasks.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          CardTaskHome(
                                            label: state.tasks[index].title,
                                            priority:
                                                state.tasks[index].priority,
                                            date:
                                                state.tasks[index].completedAt,
                                            emoji: state
                                                .tasks[index]
                                                .category
                                                .emoji,
                                            category: state
                                                .tasks[index]
                                                .category
                                                .name,
                                            color: hexToColor(
                                              state.tasks[index].category.color,
                                            ),
                                            isDark: isDark,
                                          ),
                                          SizedBox(height: 15)
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                              if (state is TaskHomeError) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
                },
              ),
            ),
            ProjectListPage(preference: _preference),
            TaskListPage(preference: _preference),
            SettingsPage(preference: _preference),
          ][currentPageIndex],
          );
        },
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
