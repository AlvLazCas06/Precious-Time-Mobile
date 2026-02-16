import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTaskHome extends StatelessWidget {
  const CardTaskHome({
    super.key,
    required this.label,
    this.emoji,
    required this.type,
    required this.color
  });

  final String label;
  final String? emoji;
  final String type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 243, 244, 246) 
                ),
                child: Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color,
                      ),
                    ),
                    Text(emoji != null ? emoji! : ''),
                    Text(type)
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_month_rounded),
              Text('Hoy, 18:00')
            ],
          )
        ],
      ),
    );
  }
}