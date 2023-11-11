import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  bool cardpayment = false;
  bool upipayment = false;

  chash() {
    cardpayment = true;
    upipayment = false;
    notifyListeners();
  }

  paymentui() {
    cardpayment = false;
    upipayment = true;
    notifyListeners();
  }
}
