import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';

class DashboardPostCard1 extends StatelessWidget {
  DashboardPostCard1({
    super.key,
    required this.txtTheme,
    required this.uid,
    required this.postId,
    required this.itemID,
    required this.caption,
    required this.postPhoto,
    // required this.stockItem,
    // required this.timeStart,
    // required this.timeEnd,
    required this.venueBlock,
    required this.venueCollege,
    // required this.createdAt,
  });
  final TextTheme txtTheme;
  final String uid;
  final String postId;
  final String itemID;
  final String caption;
  final String postPhoto;
  // final int stockItem;
  // final DateTime timeStart;
  // final DateTime timeEnd;
  final String venueBlock;
  final String venueCollege;
  // final DateTime createdAt;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: tWhiteColor,
        padding: const EdgeInsets.all(2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${venueBlock.toUpperCase()},${venueCollege.toUpperCase()}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Goose 312',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: tSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              caption.toLowerCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        blurRadius: 8,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      SizedBox(
                        width: 86,
                        child: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            child: Text(
                              '\R\M 12',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: tSecondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Row(
                          children: [
                            const SizedBox(width: 4),
                            Text(
                              '4.5',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: -0,
              child: SizedBox(
                height: 140,
                width: 120,
                child: Hero(
                  tag: postPhoto,
                  child: Image.network(
                    postPhoto,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
