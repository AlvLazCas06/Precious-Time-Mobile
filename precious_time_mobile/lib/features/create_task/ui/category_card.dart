import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.color,
    required this.emoji,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final Color color;
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 209, 213, 220)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
            )
          ),
          Text(emoji),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
