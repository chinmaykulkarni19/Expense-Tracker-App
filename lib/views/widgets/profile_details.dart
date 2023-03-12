import 'package:finance/services/database.dart';
import 'package:finance/views/pages/profile_wallet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetails extends StatelessWidget {
  ProfileDetails({Key? key}) : super(key: key);
  final Color borderColor = Color(0xFF291B12);

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  late String name;
  late String email;

  void save(String name, String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("_name", name);
    sharedPreferences.setString("_email", email);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            autofocus: true,
            controller: nameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              hintText: 'Name',
              prefixIcon: const Icon(Icons.account_circle),
            ),
            onChanged: (val) {
              name = val;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              hintText: 'Email',
              prefixIcon: const Icon(Icons.mail_outline),
            ),
            onChanged: (val) {
              email = val;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {
                save(nameController.text, emailController.text);
                DatabaseService()
                    .setProfile(nameController.text, emailController.text);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ProfileWallet()),
                    (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Color(0xFF291B12),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.92,
                    MediaQuery.of(context).size.width * 0.14)),
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
