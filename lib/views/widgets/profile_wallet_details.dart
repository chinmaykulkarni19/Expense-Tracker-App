import 'dart:developer';

import 'package:finance/services/database.dart';
import 'package:finance/views/pages/home_page.dart';
import 'package:finance/views/pages/manage_budget.dart';
import 'package:finance/views/pages/profile_wallet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileWalletDetails extends StatelessWidget {
  ProfileWalletDetails({Key? key}) : super(key: key);
  final Color borderColor = Color(0xFF291B12);
  final amountController = TextEditingController();
  Future<void> setPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTimeUser', true);
    log("isFirstTime set to true");
  }

  void save(String amount) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("_amount", amount);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              hintText: 'Amount in Rupees',
              prefixIcon: const Icon(Icons.account_circle),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                print(amountController.text);
                setPrefs();
                save(amountController.text);
                DatabaseService().setMonthlyLimit(amountController.text);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => ManageBudget(
                              amount: int.tryParse(amountController.text) ?? 0,
                            )),
                    (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
                primary: const Color(0xFF291B12),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.92,
                    MediaQuery.of(context).size.width * 0.14)),
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
