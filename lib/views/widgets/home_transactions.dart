import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/consts/consts.dart';
import 'package:finance/models/transaction.dart';
import 'package:finance/views/pages/all_transactions.dart';
import 'package:finance/views/widgets/home_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/database.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().bg_grey,
        ),
        height: MediaQuery.of(context).size.height * 0.68,
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
                    'Recent Transactions',
                    style: GoogleFonts.barlow(
                        color: AppColors().heading1,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyTransactions()));
                    log("Pressed See All");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, right: 18.0, bottom: 17.0),
                    child: Text(
                      'See All ',
                      style: GoogleFonts.ubuntu(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors().primary1),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(DatabaseService().user_email)
                    .doc("profile")
                    .collection('Transactions')
                    .doc(DatabaseService().month)
                    .collection("Monthly-Transactions")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    //print(snapshot.data!.docs[0].data());
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No Transactions!"),
                      );
                    }
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 10),
                            child: TransactionTile(
                              name: (data['name']),
                              amount: (data['amount']),
                              category: (data['category']),
                              logo: Const().categoryIcons[
                                  Const().categories.indexOf(data['category'])],
                              date: (data['createdAt'].toDate()),
                              isExpense: (data['isExpense']),
                            ),
                          );
                        });
                  }

                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }
}
