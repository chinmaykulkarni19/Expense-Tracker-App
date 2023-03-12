import 'dart:developer';

import 'package:finance/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFFEBB39),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "One App\nThat Manages\nYour Money",
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.abel(fontSize: 45, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).popAndPushNamed('/homepage');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 25),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF291B12),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.width * 0.14)),
            )
          ],
        ),
      ),
    );
  }
}
