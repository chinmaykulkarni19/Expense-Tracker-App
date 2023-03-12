import 'package:finance/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetLimitTile extends StatelessWidget {
  BudgetLimitTile({Key? key, required this.index, required this.tcontroller})
      : super(key: key);
  final int index;
  final TextEditingController? tcontroller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(0xFFF6F6F6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Text(
                    Const().categoryIcons[index].toString(),
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  Const().categories[index].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.rubik(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            SizedBox(
              width: 130.0,
              height: 40,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: tcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 33.0),
                  ),
                  style: TextStyle(fontSize: 23.0, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
