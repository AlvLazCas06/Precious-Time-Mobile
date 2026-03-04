import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskSubCard extends StatelessWidget {
  const TaskSubCard({
    super.key,
    required this.color,
    this.emoji,
    required this.label,
  });

  final Color color;
  final String? emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return emoji == null
        ? Container(
            height: 25,
            width: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 223, 224, 225),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12.5,
                  height: 12.5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 7.5),
                Text(label.substring(0, 1).toUpperCase() + label.substring(1).toLowerCase(), style: GoogleFonts.poppins()),
              ],
            ),
          )
        : Container(
            height: 25,
            width: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 223, 224, 225),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12.5,
                      height: 12.5,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(emoji!),
                  ],
                ),
                SizedBox(width: 7.5),
                Text(label.substring(0, 1).toUpperCase() + label.substring(1).toLowerCase(), style: GoogleFonts.poppins()),
              ],
            ),
          );
  }
}
