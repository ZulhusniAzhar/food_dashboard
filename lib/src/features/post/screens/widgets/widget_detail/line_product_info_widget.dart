import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LineProductInfoWidget extends StatelessWidget {
  final String title;
  final String description;

  const LineProductInfoWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 1,
              width: 68,
              color: Colors.grey.shade500,
            ),
          ],
        ),
        const SizedBox(width: 22),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: tSecondaryColor,
          ),
        ),
      ],
    );
  }
}
