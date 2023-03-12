import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/consts/consts.dart';
import 'package:finance/services/database.dart';
import 'package:finance/views/pages/category_transactions.dart';
import 'package:finance/views/widgets/home_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_tile.dart';

class SeeBudgetCategories extends StatelessWidget {
  const SeeBudgetCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().bg_grey,
        ),
        height: MediaQuery.of(context).size.height * 0.58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 19.0, top: 13.0, bottom: 17.0),
                  child: Text(
                    'All Categories  (${Const().categories.length})',
                    style: GoogleFonts.poppins(
                        color: AppColors().heading1,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: DatabaseService()
                      .firebaseFirestore
                      .collection(DatabaseService().user_email)
                      .doc("profile")
                      .collection("Category-Wise-Limit")
                      .doc(DatabaseService().month)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      DocumentSnapshot<Map<String, dynamic>> map =
                          snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: Const().categories.length,
                          itemBuilder: (context, index) {
                            double limit =
                                map[Const().categories[index]]["limit"];
                            double used =
                                map[Const().categories[index]]["used"];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryTransaction(
                                                  category: Const()
                                                      .categories[index])));
                                },
                                child: CategoryTile(
                                  logo: Const().categoryIcons[index],
                                  category: Const().categories[index],
                                  limit: limit,
                                  used: used,
                                  remaining:
                                      limit - used < 0 ? 0 : limit - used,
                                ),
                              ),
                            );
                          });
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
