import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/home/ui/task_sub_card.dart';

class CardTaskHome extends StatelessWidget {
  const CardTaskHome({
    super.key,
    required this.label,
    required this.priority,
    required this.date,
    required this.emoji,
    required this.category,
    required this.color,
    this.isDark = false,
  });

  final String label;
  final String priority;
  final String? date;
  final String emoji;
  final String category;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : null;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF364153) : Colors.white,
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: textColor,
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
            Row(
              children: [
                Icon(Icons.calendar_month_outlined, color: textColor),
                Text(date ?? '', style: GoogleFonts.poppins(color: textColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
