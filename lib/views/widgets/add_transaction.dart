import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/consts/app_colors.dart';
import 'package:finance/consts/consts.dart';
import 'package:finance/models/transaction.dart' as t;
import 'package:finance/services/database.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final amount = TextEditingController();
  int tag = 0;
  int isExpense = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text("New Transaction"),
          backgroundColor: AppColors().primary1),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Name'),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                    controller: amount,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Amount'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ChipsChoice<int>.single(
                    value: tag,
                    wrapped: true,
                    onChanged: (val) => setState(() => tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: Const().categories,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ChipsChoice<int>.single(
                    value: isExpense,
                    onChanged: (val) => setState(() => isExpense = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: ["Debit", "Credit"],
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppColors().primary1,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.8, 55)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          t.Transaction transaction = t.Transaction(
                              name: name.text,
                              category: Const().categories[tag],
                              amount: double.tryParse(amount.text) ?? 0.0,
                              isExpense: isExpense == 0 ? true : false,
                              createdAt: DateTime.now());

                          DatabaseService().addTransaction(transaction);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Add"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
