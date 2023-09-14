import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UserProvider extends ChangeNotifier {
  List<OrderModel> completeOrder = [];

  ThemeData lightThemedata = ThemeData();
  ThemeData darkThemedata = ThemeData();

  bool islaoding = false;

  CurrentUserModel? user;

  bool cartProduct = false;

  String? restauramtGmail;

  List result = [];

  Connectivity connectivity = Connectivity();

  isloading(truefalse) {
    islaoding = truefalse;

    notifyListeners();
  }

  emailadd(email) {
    currentEmail = email;
    notifyListeners();
  }

  getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");

    currentEmail = obtainedEmail!;
    notifyListeners();
  }
}
