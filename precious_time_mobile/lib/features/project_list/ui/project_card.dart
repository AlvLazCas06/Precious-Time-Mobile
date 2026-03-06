import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.id,
    required this.label,
    required this.description,
    required this.status,
    required this.percent,
    required this.startDate,
    required this.finishDate,
    this.isDark = false,
  });

  final int id;
  final String label;
  final String description;
  final String status;
  final double percent;
  final String? startDate;
  final String? finishDate;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : null;
    return Container(
      width: 360,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF364153) : Colors.white,
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
                    color: textColor,
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 30,
                decoration: BoxDecoration(
                  color: status == 'en proceso' ? Color.fromARGB(255, 219, 234, 254) : status == 'completado' ? Color.fromARGB(255, 231, 251, 239) : const Color.fromARGB(255, 255, 162, 162),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    status.substring(0, 1).toUpperCase() + status.substring(1),
                    style: GoogleFonts.poppins(
                      color: status == 'en proceso'
                          ? Color.fromARGB(255, 20, 71, 230)
                          : status == 'completado'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(color: textColor),
                ),
              ),
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  SizedBox(
                    width: 37.5,
                    height: 37.5,
                    child: FloatingActionButton(
                      heroTag: 'edit_$id',
                      onPressed: () {
                        String id = this.id.toString();
                        Navigator.pushNamed(
                          context,
                          '/project/edit',
                          arguments: id,
                        );
                      },
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                  SizedBox(
                    width: 37.5,
                    height: 37.5,
                    child: FloatingActionButton(
                      heroTag: 'view_$id',
                      onPressed: () {
                        String id = this.id.toString();
                        Navigator.pushNamed(context, '/project', arguments: id);
                      },
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.visibility_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up, size: 18, color: textColor),
                  SizedBox(width: 5),
                  Text('Progreso', style: GoogleFonts.poppins(fontSize: 14, color: textColor)),
                ],
              ),
              Text(
                '${percent.floor()}%',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: textColor,
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
                  Icon(Icons.calendar_month, size: 18, color: textColor),
                  Text(
                    'Inicio: $startDate',
                    style: GoogleFonts.poppins(fontSize: 16, color: textColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 18, color: textColor),
                  Text(
                    finishDate == null ? 'Sin terminar' : 'Fin: $finishDate',
                    style: GoogleFonts.poppins(fontSize: 16, color: textColor),
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
