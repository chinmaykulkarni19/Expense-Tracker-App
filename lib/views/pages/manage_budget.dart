import 'package:finance/consts/consts.dart';
import 'package:finance/services/database.dart';
import 'package:finance/views/pages/confetti_page.dart';
import 'package:finance/views/pages/home_page.dart';
import 'package:finance/views/widgets/budget_limit_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageBudget extends StatefulWidget {
  ManageBudget({Key? key, required this.amount}) : super(key: key);
  final int amount;

  @override
  State<ManageBudget> createState() => _ManageBudgetState();
}

class _ManageBudgetState extends State<ManageBudget> {
  final List<TextEditingController?>? _controllers = [];

  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFFEBB39),
        body: SafeArea(
            child: Center(
                child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.24,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How much would you give to each category?",
                style: GoogleFonts.rubik(
                    fontSize: 34,
                    color: Color(0xFF291B12),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Monthly Limit : ₹${widget.amount}",
                style:
                    GoogleFonts.rubik(fontSize: 23, color: Color(0xFF291B12)),
              ),
              if (!isValid)
                SizedBox(
                  height: 15,
                ),
              if (!isValid)
                Text(
                  "Your monthly limit is exceeding.\nPlease change the budget.",
                  style: GoogleFonts.rubik(
                      fontSize: 19, color: Color.fromARGB(255, 183, 38, 27)),
                )
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(21))),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: Const().categories.length + 1,
                itemBuilder: (context, index) {
                  if (index == Const().categories.length) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          double temp = 0;
                          for (TextEditingController? t in _controllers!) {
                            temp += double.tryParse(t!.text) ?? 0;
                          }
                          print(temp);
                          if (temp != widget.amount) {
                            isValid = false;
                          } else {
                            isValid = true;
                          }
                          setState(() {});
                          if (isValid) {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            List<String> res = [];
                            for (TextEditingController? text in _controllers!) {
                              res.add(text!.text);
                            }
                            await sharedPreferences.setStringList(
                                "category-wise-limit", res);
                            await sharedPreferences.setInt(
                                "last-executed-month", DateTime.now().month);
                            DatabaseService().setBudget(_controllers);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ConfettiPage()),
                                (route) => false);
                          }
                          print("length" + _controllers!.length.toString());
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF291B12),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.7, 50)),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    );
                  }
                  if (_controllers!.length < 10) {
                    _controllers!.add(TextEditingController(
                        text: " ${widget.amount / Const().categories.length}"));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: BudgetLimitTile(
                        index: index, tcontroller: _controllers![index]),
                  );
                }),
          ),
        ),
      ),
    ]))));
  }
}
