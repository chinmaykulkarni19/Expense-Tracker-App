import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/consts/consts.dart';
import 'package:finance/models/transaction.dart' as t;
import 'package:finance/views/widgets/all_transactions_header.dart';
import 'package:finance/views/widgets/all_transactions_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';

class MyTransactions extends StatefulWidget {
  const MyTransactions({Key? key}) : super(key: key);

  @override
  State<MyTransactions> createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {
  Future<List<Map<String, dynamic>>> getTransactions() async {
    List<Map<String, dynamic>> res = [];
    int stop = 0;
    await DatabaseService()
        .firebaseFirestore
        .collection(DatabaseService().user_email)
        .doc('profile')
        .collection("Transactions")
        .orderBy("createdAt", descending: true)
        .limit(2)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> doc) async {
      for (var element in doc.docs) {
        await DatabaseService()
            .firebaseFirestore
            .collection(DatabaseService().user_email)
            .doc('profile')
            .collection("Transactions")
            .doc(element.id)
            .collection("Monthly-Transactions")
            .orderBy("createdAt", descending: true)
            .get()
            .then((QuerySnapshot<Map<String, dynamic>> value) {
          for (var element in value.docs) {
            print(element.data());
            res.add(element.data());
            stop += 1;
            if (stop > 200) return res;
          }
        });
      }
    });

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), //0xFF414E9B
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AllTransactionsHeader(),
            Expanded(
                child: Container(
              color: AppColors().bg_grey,
              child: FutureBuilder(
                  future: getTransactions(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      //print(snapshot.data!.docs[0].data());

                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];

                            //print(Const().categories.indexOf(data['category']));
                            bool f = (index != 0 &&
                                (snapshot.data![index]['createdAt']
                                            .toDate()
                                            .month !=
                                        snapshot.data![index - 1]['createdAt']
                                            .toDate()
                                            .month ||
                                    snapshot.data![index]['createdAt']
                                            .toDate()
                                            .day !=
                                        snapshot.data![index - 1]['createdAt']
                                            .toDate()
                                            .day));
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (f || index == 0)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Text(
                                        DateFormat.MMMMEEEEd()
                                            .format(data['createdAt'].toDate())
                                            .toString(),
                                        style: GoogleFonts.rubik(
                                            fontSize: 16,
                                            color: Colors.grey.shade800),
                                      ),
                                    ),
                                  TransactionTile(
                                      name: (data['name']),
                                      amount: (data['amount']),
                                      category: (data['category']),
                                      logo: Const().categoryIcons[Const()
                                          .categories
                                          .indexOf(data['category'])],
                                      isExpense: (data['isExpense'])),
                                ],
                              ),
                            );
                          });
                    }

                    return Center(child: CircularProgressIndicator());
                  }),
            ))
          ],
        )),
      ),
    );
  }
}
