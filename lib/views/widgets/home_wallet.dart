import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/services/database.dart';
import 'package:finance/utils/app_utils.dart';
import 'package:finance/views/pages/see_budget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWallet extends StatelessWidget {
  MyWallet({Key? key}) : super(key: key);
  final int remainingDays = Utils().getRemainingDays();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color(0xFFFFFFFF),
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
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: DatabaseService()
                    .firebaseFirestore
                    .collection(DatabaseService().user_email)
                    .doc("profile")
                    .collection("Monthly-Limit")
                    .doc(DatabaseService().month)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var map = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('₹ ${map!["amount"] - map["used-limit"]}',
                            style: GoogleFonts.rubik(
                                color: AppColors().heading1,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          onPressed: () {
                            log("Pressed See budget button");
                            print(Utils().getRemainingDays());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SeeBudget(
                                      limit: map?["amount"] ?? 0.0,
                                      used: map?["used-limit"] ?? 0.0,
                                    )));
                          },
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: AppColors().primary1),
                          child: Text("See Budget",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        )
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                })
          ],
        )),
      ),
    );
  }
}
