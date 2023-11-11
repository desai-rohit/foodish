import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/pages/myOrders/myorder_services.dart';

class MyOrderProvider extends ChangeNotifier {
  bool isloading = false;

  final myorderServices = MyOrderServices();
  List<OrderModel> _orderLst = [];
  List<OrderModel> get orderListData => _orderLst;

  String? prodcutsRateing;
  List<double> totalrateing = [];
  Future<void> getOrderList() async {
    isloading = true;
    notifyListeners();
    final response = await myorderServices.getCompleteOrder(currentEmail);
    _orderLst = response;
    isloading = false;

    notifyListeners();
  }

  fetchrateing(rateing) {
    prodcutsRateing = rateing;
    notifyListeners();
  }

  updateRateing(id, prateing) {
   myorderServices.rateing(id: id, rateing: prateing).then((value) => getOrderList());
    notifyListeners();
  }
}
