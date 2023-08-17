import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:food_delivery/pages/otherPages/bottom_nav/bottom_nav.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess>
    with TickerProviderStateMixin {
  // bool isloading = false;

  @override
  void initState() {
    
    Timer(const Duration(seconds: 3), () async {
      await Provider.of<UserProvider>(context, listen: false).isloading(true);
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/orderbike.json',
              width: width * 1,
              height: height * 0.5,
              fit: BoxFit.fill,
            ),
            Lottie.asset(
              repeat: false,
              'assets/animation/ordercheck.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            Provider.of<UserProvider>(context, listen: true).islaoding == true
                ? FadeTransition(
                    opacity: Tween<double>(begin: 1, end: 0.5)
                        .animate(AnimationController(
                      vsync: this,
                      duration: const Duration(seconds: 3),
                    )),
                    // duration: const Duration(seconds: 5),
                    child: button(
                        context: context,
                        name: "Continue",
                        onPressd: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNav())).then((value) =>
                              Provider.of<UserProvider>(context, listen: false)
                                  .isloading(false));
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
