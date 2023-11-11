import 'package:flutter/material.dart';
import 'package:food_delivery/pages/orderpage/order_services.dart';

class OrderPageProvidr extends ChangeNotifier {
  bool isloading = false;
  int count = 1;
  double? countTotalPrice = 0;

  String favoriteId = '';
  String cartDataId = '';
 final orderServices = Orderservices();
  truefalse(truefalse) {
    isloading = truefalse;
    notifyListeners();
  }

  //order page
  countIncrease(price) {
    count++;
    countTotalPrice = (count * price).toDouble();
    notifyListeners();
  }

  countDecrease(price) {
    if (count == 1) {
      count;
    } else {
      count--;
      countTotalPrice = (count * price).toDouble();
      notifyListeners();
    }
  }



  cartdataid(id) {
    cartDataId = id;
    notifyListeners();
  }

  Future<void> addtocart(productsID, user, image, name, restorantName, gmail,
      price, itemcount, totalprice) async {
    isloading = true;
    notifyListeners();
    await orderServices.addcart(productsID, user, image, name, restorantName,
        gmail, price, itemcount, totalprice);
    isloading = false;
    notifyListeners();
  }
}
