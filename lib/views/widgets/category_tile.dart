import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key,
      required this.category,
      required this.used,
      required this.remaining,
      required this.limit,
      required this.logo})
      : super(key: key);

  final String logo;
  final String category;
  final double used;
  final double remaining;
  final double limit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        padding: EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(
                backgroundColor: Color(0xFFF6F6F6),
                child: Text(
                  logo,
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Remaining: ₹$remaining",
                      style: GoogleFonts.poppins(fontSize: 14),
                    )
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹ $used",
                    style: GoogleFonts.poppins(
                        color: AppColors().heading1,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "limit: ₹$limit",
                    style: GoogleFonts.poppins(
                        color: AppColors().heading1, fontSize: 14),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
