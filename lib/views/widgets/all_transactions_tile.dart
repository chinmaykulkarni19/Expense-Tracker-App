import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(
      {Key? key,
      required this.name,
      required this.category,
      required this.amount,
      required this.logo,
      required this.isExpense})
      : super(key: key);

  final String logo;
  final String name;
  final String category;
  final double amount;
  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        padding: EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(
                backgroundColor: Color(0xFFF6F6F6),
                child: Text(
                  logo,
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      category,
                      style: GoogleFonts.poppins(fontSize: 13),
                    )
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isExpense
                      ? Text(
                          "-₹ $amount",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          "₹ $amount",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
