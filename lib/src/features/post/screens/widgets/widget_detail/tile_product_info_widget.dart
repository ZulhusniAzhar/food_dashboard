import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TileProductInfoWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const TileProductInfoWidget({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(180),
              ),
            ),
            const SizedBox(width: 10),
            Text(title.toUpperCase())
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            const SizedBox(width: 10),
            Text(
              description.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: tSecondaryColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}
