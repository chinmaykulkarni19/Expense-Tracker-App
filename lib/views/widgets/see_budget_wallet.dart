import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/services/database.dart';
import 'package:finance/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeBudgetWallet extends StatelessWidget {
  SeeBudgetWallet({Key? key, required this.limit, required this.used})
      : super(key: key);
  final int remainingDays = Utils().getRemainingDays();
  final double limit;
  final double used;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Color(0xFFFFFFFF),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 10),
            child: Text(
              "Left to spent for next $remainingDays days",
              style: GoogleFonts.poppins(
                  color: AppColors().heading1,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 5),
                child: Text('₹ ${limit - used}',
                    style: GoogleFonts.rubik(
                        color: AppColors().heading1,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10, right: 25),
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFFcefad0),
              color: Color(0xFF1fd655),
              value: (used / limit) > 1.0 ? 1.0 : (used / limit),
              minHeight: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  r"₹0",
                  style: GoogleFonts.poppins(
                      color: AppColors().heading1, fontSize: 17),
                ),
                Text(
                  r"₹" + limit.toString(),
                  style: GoogleFonts.poppins(
                      color: AppColors().heading1, fontSize: 17),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 12, right: 25),
            child: Text(
              r"◼ Spent till now: ₹" + used.toString(),
              style: GoogleFonts.poppins(
                  color: AppColors().heading1, fontSize: 18),
            ),
          )
        ],
      )),
    ));
  }
}
