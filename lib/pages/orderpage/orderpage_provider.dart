import 'package:flutter/material.dart';
import 'package:food_delivery/services/api_user.dart';

class OrderPageProvidr extends ChangeNotifier {
  bool isloading = false;
  int count = 1;
  double? countTotalPrice = 0;

  String favoriteId = '';
  String cartDataId = '';
  final _apiServices = ApiServices();

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

  favoriteid(id) {
    favoriteId = id;
    notifyListeners();
  }

  cartdataid(id) {
    cartDataId = id;
    notifyListeners();
  }

  Future<void> addtocart(productsID, user, image, name, restorantName, gmail,
      price, itemcount, totalprice) async {
    isloading = true;
    notifyListeners();
    await _apiServices.addcart(productsID, user, image, name, restorantName,
        gmail, price, itemcount, totalprice);
    isloading = false;
    notifyListeners();
  }
}
