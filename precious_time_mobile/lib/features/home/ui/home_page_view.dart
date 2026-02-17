import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/home/ui/active_projects.dart';
import 'package:precious_time_mobile/features/home/ui/app_bar_precious_time.dart';
import 'package:precious_time_mobile/features/home/ui/card_task_home.dart';
import 'package:precious_time_mobile/features/home/ui/project_card.dart';
import 'package:precious_time_mobile/features/home/ui/summary_box_widget.dart';
import 'package:precious_time_mobile/features/home/ui/task_card.dart';

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
        Stack(
          children: [
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
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
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
        Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
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
                  onPressed: () {},
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
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perfil de usuario',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(radius: 45),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'María',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Usuario premium',
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Color.fromARGB(255, 106, 114, 130)),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nombre',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              Text(
                                'María',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.mail_outline, color: Color.fromARGB(255, 106, 114, 130)),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              Text(
                                'maria@email.com',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
