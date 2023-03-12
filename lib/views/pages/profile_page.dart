import 'package:finance/views/widgets/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: Color(0xFFFEBB39),
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
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
                        "Make your account.",
                        style: GoogleFonts.rubik(
                            fontSize: 34,
                            color: Color(0xFF291B12),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tell us about yourself",
                        style: GoogleFonts.merriweather(
                            fontSize: 25, color: Color(0xFF291B12)),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(21))),
                  child: ProfileDetails(),
                ),
              )
            ],
          )),
        ));
  }
}
