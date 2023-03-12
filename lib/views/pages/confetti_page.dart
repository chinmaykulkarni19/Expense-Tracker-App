import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:finance/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfettiPage extends StatefulWidget {
  ConfettiPage({Key? key}) : super(key: key);

  @override
  State<ConfettiPage> createState() => _ConfettiPageState();
}

class _ConfettiPageState extends State<ConfettiPage> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 100,
                    child: Text(
                      'Hurrah, You are Good to Go!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 150,
                    child: DefaultTextStyle(
                      style: GoogleFonts.rubik(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Take hold of your finance',
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            'See where is your money going',
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            'Get insights on your monthly income',
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 250, child: Image.asset("assets/5867.jpg")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    },
                    child: Text("Get Started",
                        style: GoogleFonts.ubuntu(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xFFFEBB39),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 60)),
                  )
                ],
              )),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              // blastDirection: pi / 2,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 5, // set a lower max blast force
              minBlastForce: 2, // set a lower min blast force
              emissionFrequency: 0.1,
              numberOfParticles: 20, // a lot of particles at once
              gravity: 0.1,
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: TextButton(
          //       onPressed: () {
          //         _controllerCenter.play();
          //       },
          //       child: Text('pump')),
          // ),
        ]),
      ),
    );
  }
}
