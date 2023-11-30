import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/pages/bottom_nav/bottom_nav.dart';


class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    currentuseremail();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => currentEmail == "null"
                    ? const LoginPage()
                    : const BottomNav())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
          SizedBox(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
                fontFamily: 'Bobbers',
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                pause: const Duration(milliseconds: 3000),
                animatedTexts: [
                  TyperAnimatedText(
                      textAlign: TextAlign.center,
                      'The food at your doorstep',
                      textStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ],
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    ));
  }
}
