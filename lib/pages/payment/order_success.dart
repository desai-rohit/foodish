import 'package:flutter/material.dart';
import 'package:food_delivery/pages/bottom_nav/bottom_nav.dart';
import 'package:lottie/lottie.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              repeat: false,
              'assets/animation/order_success.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          const Center(
            child: Text(
              "Order Complate",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.green),
            ),
          ),
          const SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const BottomNav()),
                    (route) => false);
              },
              child: const Text("Continue Shopping"))
        ],
      ),
    );
  }
}
