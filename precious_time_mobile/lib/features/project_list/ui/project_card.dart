import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.label,
    required this.description,
    required this.percent,
    required this.startDate,
    required this.finishDate,
  });

  final String label;
  final String description;
  final double percent;
  final String startDate;
  final String finishDate;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 175,
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 30,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 234, 254),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'En proceso',
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 20, 71, 230),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 200,
            child: Text(
              'Rediseño completo de la interfaz de usuario de la aplicación móvil principal.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up, size: 18),
                  SizedBox(width: 5),
                  Text('Progreso', style: GoogleFonts.poppins(fontSize: 14)),
                ],
              ),
              Text(
                '${percent.floor()}%',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 7.5),
          SizedBox(
            width: 400,
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 18),
                  Text(
                    'Inicio: $startDate',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 18),
                  Text(
                    'Fin: $finishDate',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
