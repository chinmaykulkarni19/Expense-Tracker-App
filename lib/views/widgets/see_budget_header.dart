import 'package:finance/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeBudgetHeader extends StatelessWidget {
  const SeeBudgetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: BackButton(
              color: AppColors().heading1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Text(
              "Budget",
              style: GoogleFonts.poppins(
                  color: AppColors().heading1, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 20.0),
            child: Icon(
              Icons.add,
              size: 28,
              color: AppColors().heading1,
            ),
          ),
        ],
      ),
    );
  }
}
