import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppBarPreciousTime(),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.white,
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
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 249, 250, 251),
                  ),
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
                                  ),
                                );
                              }
                              if (state is UserHomeSuccess) {
                                return Text(
                                  'Hola, ${state.user.fullName} 👋',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                );
                              }
                              return Text(
                                'Hola, María 👋',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              );
                            },
                          ),
                          Text(
                            'Aquí está tu resumen de hoy',
                            style: GoogleFonts.poppins(),
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
                                totalProjects: 2,
                              ),
                              SummaryBoxWidget(
                                icon: Icons.error_outline,
                                iconColor: Color.fromARGB(255, 255, 105, 0),
                                label: 'En progreso',
                                totalTasks: 5,
                                totalProjects: 2,
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
                              ),
                              SummaryBoxWidget(
                                icon: Icons.moving,
                                iconColor: Color.fromARGB(255, 173, 70, 255),
                                label: 'Total hoy',
                                totalTasks: 5,
                                totalProjects: 2,
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
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.tasks.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CardTaskHome(
                                          label: state.tasks[index].title,
                                          priority: state.tasks[index].priority,
                                          date: state.tasks[index].completedAt!,
                                          emoji:
                                              state.tasks[index].category.emoji,
                                          category:
                                              state.tasks[index].category.name,
                                          color: Colors.black,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              if (state is TaskHomeError) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: GoogleFonts.poppins(color: Colors.red),
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
        ProjectListPage(),
        TaskListPage(),
        SettingsPage(),
      ][currentPageIndex],
    );
  }
}
