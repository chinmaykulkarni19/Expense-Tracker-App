import 'package:finance/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15.0, left: 20.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Icon(
                Icons.close,
                size: 30,
                color: AppColors().heading1,
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: Text(
          //     'Home',
          //     style: GoogleFonts.notoSans(fontSize: 25),
          //   ),
          // ),
        ],
      ),
    );
  }
}
