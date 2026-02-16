import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/home/ui/active_projects.dart';
import 'package:precious_time_mobile/features/home/ui/app_bar_precious_time.dart';
import 'package:precious_time_mobile/features/home/ui/card_task_home.dart';
import 'package:precious_time_mobile/features/home/ui/project_card.dart';
import 'package:precious_time_mobile/features/home/ui/summary_box_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int currentPageIndex = 0;
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
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
      body: [
        SingleChildScrollView(
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
                    Text(
                      'Hola, María 👋',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
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
                        Text(
                          'Ver todos',
                          style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 21, 93, 255),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ActiveProjects(
                      color: Color.fromARGB(255, 139, 92, 246),
                      label: 'Rediseño de la aplicación\nmóvil',
                      percent: 65,
                    ),
                    SizedBox(height: 14),
                    ActiveProjects(
                      color: Color.fromARGB(255, 59, 130, 246),
                      label: 'Rediseño de la aplicación\nmóvil',
                      percent: 65,
                    ),
                    SizedBox(height: 14),
                    ActiveProjects(
                      color: Color.fromARGB(255, 16, 185, 129),
                      label: 'Rediseño de la aplicación\nmóvil',
                      percent: 65,
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
                        Text(
                          'Ver todos',
                          style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 21, 93, 255),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    CardTaskHome(
                      label: 'Revisar propuesta de diseño',
                      type: 'diseño',
                      color: Color.fromARGB(255, 139, 92, 246),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 250, 251),
            ),
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
                ProjectCard(
                  label: 'Rediseño de la aplicación móvil',
                  description:
                      'Rediseño completo de la interfaz de usuario de la aplicación móvil principal.',
                  percent: 65,
                  startDate: '15 Ene 2026',
                  finishDate: '15 Feb 2026',
                ),
                SizedBox(height: 20),
                ProjectCard(
                  label: 'Rediseño de la aplicación móvil',
                  description:
                      'Rediseño completo de la interfaz de usuario de la aplicación móvil principal.',
                  percent: 65,
                  startDate: '15 Ene 2026',
                  finishDate: '15 Feb 2026',
                ),
                SizedBox(height: 20),
                ProjectCard(
                  label: 'Rediseño de la aplicación móvil',
                  description:
                      'Rediseño completo de la interfaz de usuario de la aplicación móvil principal.',
                  percent: 65,
                  startDate: '15 Ene 2026',
                  finishDate: '15 Feb 2026',
                ),
                SizedBox(height: 20),
                ProjectCard(
                  label: 'Rediseño de la aplicación móvil',
                  description:
                      'Rediseño completo de la interfaz de usuario de la aplicación móvil principal.',
                  percent: 65,
                  startDate: '15 Ene 2026',
                  finishDate: '15 Feb 2026',
                ),
                SizedBox(height: 20),
                ProjectCard(
                  label: 'Rediseño de la aplicación móvil',
                  description:
                      'Rediseño completo de la interfaz de usuario de la aplicación móvil principal.',
                  percent: 65,
                  startDate: '15 Ene 2026',
                  finishDate: '15 Feb 2026',
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add, color: Colors.white),
                  color: Color.fromARGB(255, 179, 203, 255),
                  style: IconButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 21, 93, 255),
                  ),
                  iconSize: 22,
                ),
              ],
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
