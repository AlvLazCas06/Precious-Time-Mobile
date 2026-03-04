import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryBoxWidget extends StatelessWidget {
  const SummaryBoxWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.totalTasks,
    this.totalProjects
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final int? totalTasks;
  final int? totalProjects;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 125,
      padding: EdgeInsets.all(15),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, color: iconColor,),
              Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)
            ],
          ),
          totalTasks != null ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(totalTasks != null ? 'Tareas:' : '', style: GoogleFonts.poppins()),
              Text('${totalTasks ?? ''}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17),)
            ],
          ): SizedBox(),
          totalProjects != null ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(totalProjects != null ? 'Proyectos:' : '', style: GoogleFonts.poppins()),
              Text('${totalProjects ?? ''}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17))
            ],
          ) : SizedBox()
        ],
      ),
    );
  }
}