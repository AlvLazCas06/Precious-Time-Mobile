import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/home/ui/task_sub_card.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.label,
    required this.description,
    required this.status,
    required this.priority,
    required this.date,
    required this.emoji,
    required this.category,
    required this.color,
  });

  final String label;
  final String description;
  final String status;
  final String priority;
  final String date;
  final String emoji;
  final String category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 37.5,
            height: 37.5,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: status == 'En proceso'
                  ? Color.fromARGB(255, 43, 127, 255)
                  : Color.fromARGB(255, 100, 221, 148),

              child: Icon(
                status == 'En proceso' ? Icons.circle : Icons.check,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 7),
                SizedBox(
                  width: 275,
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    TaskSubCard(color: color, emoji: emoji, label: category),
                    SizedBox(width: 20),
                    TaskSubCard(
                      color: priority == 'Alta'
                          ? Colors.red
                          : priority == 'Media'
                          ? Colors.deepOrangeAccent
                          : Colors.blueAccent,
                      label: priority,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
                  width: 110,
                  decoration: BoxDecoration(
                    color: status == 'En proceso'
                        ? Color.fromARGB(255, 219, 234, 254)
                        : Color.fromARGB(255, 231, 251, 239),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: status == 'En proceso'
                            ? Color.fromARGB(255, 20, 71, 230)
                            : Color.fromARGB(255, 102, 179, 134),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [Icon(Icons.calendar_month_outlined), Text(date)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
