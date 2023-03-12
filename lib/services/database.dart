import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/models/transaction.dart' as t;
import 'package:finance/consts/consts.dart';
import 'package:finance/utils/app_utils.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String user_email = "rohit.22011157@viit.ac.in";
  final String month = Utils().getMonth();

  void setProfile(String name, String email) async {
    await firebaseFirestore.collection(email.trim()).doc("profile").set({
      "name": name.trim(),
      "email": email.trim(),
      "createdAt": DateTime.now()
    });
  }

  void setMonthlyLimit(String amount) async {
    await firebaseFirestore
        .collection(user_email)
        .doc("profile")
        .collection("Monthly-Limit")
        .doc(month)
        .set({
      "amount": double.tryParse(amount.trim()) ?? 0.0,
      "used-limit": 0.0
    });
  }

  void setBudget(List<TextEditingController?>? controllers) async {
    for (int i = 0; i < Const().categories.length; i++) {
      await firebaseFirestore
          .collection(user_email)
          .doc("profile")
          .collection("Category-Wise-Limit")
          .doc(month)
          .set({
        Const().categories[i]: {
          "used": 0.0,
          "limit": double.tryParse(controllers![i]!.text) ?? 0
        }
      }, SetOptions(merge: true));
    }
  }

  void addTransaction(t.Transaction transaction) async {
    // var doc = await firebaseFirestore
    //     .collection(user_email)
    //     .doc("profile")
    //     .collection('Transactions')
    //     .doc(month)
    //     .get();

    // if (!doc.exists) {

    // }

    await firebaseFirestore
        .collection(user_email)
        .doc("profile")
        .collection('Transactions')
        .doc(month)
        .collection("Monthly-Transactions")
        .withConverter<t.Transaction>(
            fromFirestore: (snapshot, _) =>
                t.Transaction.fromJson(snapshot.data()!),
            toFirestore: (transaction, _) => transaction.toJson())
        .add(transaction);
    await transactionHelper(
        transaction.category, transaction.amount, transaction.isExpense);
  }

  Future<void> transactionHelper(
      String category, double amt, bool isExpense) async {
    await firebaseFirestore
        .collection(user_email)
        .doc("profile")
        .collection("Monthly-Limit")
        .doc(month)
        .set({"used-limit": FieldValue.increment(isExpense ? amt : -1 * amt)},
            SetOptions(merge: true));

    await firebaseFirestore
        .collection(user_email)
        .doc("profile")
        .collection("Category-Wise-Limit")
        .doc(month)
        .set({
      category: {"used": FieldValue.increment(isExpense ? amt : -1 * amt)}
    }, SetOptions(merge: true));
  }
}
