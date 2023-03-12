import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/consts/consts.dart';
import 'package:finance/models/transaction.dart';
import 'package:finance/services/database.dart';
import 'package:finance/views/widgets/add_transaction.dart';
import 'package:finance/views/widgets/home_header.dart';
import 'package:finance/views/widgets/home_transactions.dart';
import 'package:finance/views/widgets/home_wallet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checking = true;
  void initialChecks() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //preferences.setInt("last-executed-month", DateTime.now().month);
    // preferences.setInt("monthly-limit", 10000);

    int? mo = preferences.getInt("last-executed-month");

    if (DateTime.now().month != mo) {
      String? li = preferences.getString("_amount");
      List<String>? res = preferences.getStringList("category-wise-limit");
      DatabaseService().setMonthlyLimit(li.toString());
      for (int i = 0; i < Const().categories.length; i++) {
        await DatabaseService()
            .firebaseFirestore
            .collection(DatabaseService().user_email)
            .doc("profile")
            .collection("Category-Wise-Limit")
            .doc(DatabaseService().month)
            .set({
          Const().categories[i]: {
            "used": 0.0,
            "limit": double.tryParse(res![i]) ?? 0
          }
        }, SetOptions(merge: true));
      }
      //not sure
      await DatabaseService()
          .firebaseFirestore
          .collection(DatabaseService().user_email)
          .doc("profile")
          .collection('Transactions')
          .doc(DatabaseService().month)
          .set({"createdAt": DateTime.now()});
      await preferences.setInt("last-executed-month", DateTime.now().month);
    }

    setState(() {
      checking = false;
    });
  }

  @override
  void initState() {
    initialChecks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF), //0xFF414E9B
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().primary1,
        child: const Text(
          "+",
          style: TextStyle(fontSize: 35),
        ),
        onPressed: () async {
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setBool('isFirstTimeUser', true);

          // Box<Transaction> contactsBox = Hive.box<Transaction>("Transactions");
          // contactsBox.add(
          //     Transaction("Idli", "Food & Drinks", 100, true, DateTime.now()));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTransaction()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: checking
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Header(), MyWallet(), Transactions()],
            )),
    );
  }
}
