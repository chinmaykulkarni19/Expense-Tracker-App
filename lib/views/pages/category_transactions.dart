import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/views/widgets/all_transactions_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_colors.dart';
import '../../consts/consts.dart';
import '../../services/database.dart';
import '../widgets/all_transactions_header.dart';

class CategoryTransaction extends StatelessWidget {
  CategoryTransaction({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), //0xFF414E9B
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                    top: 10.0,
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.poppins(
                        color: AppColors().heading1, fontSize: 25),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              color: AppColors().bg_grey,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(DatabaseService().user_email)
                      .doc("profile")
                      .collection('Transactions')
                      .doc(DatabaseService().month)
                      .collection("Monthly-Transactions")
                      .where("category", isEqualTo: category)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      //print(snapshot.data!.docs[0].data());
                      return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        print(Const().categories.indexOf(data['category']));
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 10),
                          child: TransactionTile(
                            name: (data['name']),
                            amount: (data['amount']),
                            category: (data['category']),
                            isExpense: (data['isExpense']),
                            logo: Const().categoryIcons[
                                Const().categories.indexOf(data['category'])],
                          ),
                        );
                      }).toList());
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
