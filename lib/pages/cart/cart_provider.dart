import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/models/add_cart.dart';
import 'package:food_delivery/pages/cart/cart_services.dart';

class CartProvider extends ChangeNotifier {
  bool isloading = false;
  String cartDataId = '';

  int cartcount = 1;
  dynamic carttottalprice;

  double totalAmount = 0.0;
  double alltotalAmount = 0.0;

  String? orderId;

  cartdataid(id) {
    cartDataId = id;
    notifyListeners();
  }

  isloadingtf(truefalse) {
    isloading = truefalse;

    notifyListeners();
  }

  final cartServices = CartServices();
  List<Addcart> _addCart = [];
  List<Addcart> get cartdata => _addCart;

  Future<void> getAllCart() async {
    isloading = true;
    notifyListeners();
    final response = await cartServices.getListaddcart(currentEmail);
    _addCart = response;
    isloading = false;
    notifyListeners();
  }

  deletecart(id) {
    cartServices.deleteCart(id)
        .then((value) => getAllCart())
        .then((value) => cartdataid(""));
    notifyListeners();
  }

  cartcountUpdate(data) {
    isloading = true;
    cartcount = int.parse(data);
    notifyListeners();
  }

  cartcountIncrease(price) {
    cartcount++;
    carttottalprice = (cartcount * int.parse(price));
    notifyListeners();
  }

  cartcountDecrease(price) {
    if (cartcount == 1) {
      cartcount;
      notifyListeners();
    } else {
      cartcount--;
      carttottalprice = (cartcount * int.parse(price));
      notifyListeners();
    }
    notifyListeners();
  }
}
