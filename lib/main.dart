import 'package:finance/consts/app_colors.dart';
import 'package:finance/models/transaction.dart';
import 'package:finance/views/pages/confetti_page.dart';
import 'package:finance/views/pages/home_page.dart';
import 'package:finance/views/pages/manage_budget.dart';
import 'package:finance/views/pages/screen_one.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const Middleware(),
      routes: {"/homepage": (context) => const HomePage()},
    );
  }
}

class Middleware extends StatelessWidget {
  const Middleware({Key? key}) : super(key: key);
  Future<bool?> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final bool? isFirstTime = prefs.getBool('isFirstTimeUser');
    return isFirstTime;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data == false) {
            return const ScreenOne();
          }
          if (snapshot.data == true) {
            return const HomePage();
          }
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            color: AppColors().primary1,
          )));
        });
  }
}
