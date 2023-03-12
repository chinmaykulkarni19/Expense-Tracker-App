import 'package:finance/views/widgets/see_budget_categories.dart';
import 'package:finance/views/widgets/see_budget_header.dart';
import 'package:finance/views/widgets/see_budget_wallet.dart';
import 'package:flutter/material.dart';

class SeeBudget extends StatelessWidget {
  SeeBudget({Key? key, required this.limit, required this.used})
      : super(key: key);
  final double limit;
  final double used;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), //0xFF414E9B

      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SeeBudgetHeader(),
            SeeBudgetWallet(
              limit: limit,
              used: used,
            ),
            SeeBudgetCategories()
          ],
        )),
      ),
    );
  }
}
