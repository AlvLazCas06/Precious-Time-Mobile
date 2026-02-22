import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/project_list/ui/project_card.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        );
  }
}