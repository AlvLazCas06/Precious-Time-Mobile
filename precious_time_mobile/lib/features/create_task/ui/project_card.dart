import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.id,
    required this.name,
    required this.progress,
    this.isSelected = false,
    this.onTap,
  });

  final int id;
  final String name;
  final double progress;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final progressPercent = (progress * 100).clamp(0.0, 100.0);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 21, 93, 252)
                : const Color.fromARGB(255, 209, 213, 220),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? const Color.fromARGB(30, 21, 93, 252)
              : Colors.white,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.work_outline,
              size: 20,
              color: Color.fromARGB(255, 106, 114, 130),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: const Color.fromARGB(255, 209, 213, 220),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 21, 93, 252),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${progressPercent.toStringAsFixed(0)}%',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 21, 93, 252),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
