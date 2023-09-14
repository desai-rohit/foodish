import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/pages/bottom_nav/bottom_nav.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isloading = false;
  final _apiServices = ApiServices();
  //signup page controller
  TextEditingController namecontroller = TextEditingController();
  TextEditingController gmailcontroller = TextEditingController();
  TextEditingController passworController = TextEditingController();

  //login page controller
  TextEditingController loginpassworController = TextEditingController();
  TextEditingController logingmailcontroller = TextEditingController();

  List<UserApi> _userlist = [];
  List<UserApi> get userListData => _userlist;

  final _userServices = UserServices();
  CurrentUserModel? currentUserModel;

  userloginSharedPrefrance(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences
        .setString("email", logingmailcontroller.text)
        .then(
          (value) => currentuseremail(),
        )
        .then(
          (value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomNav())),
        );
    notifyListeners();
  }

  Future<void> getuserall() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getUser();
    _userlist = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> getUser() async {
    isloading = true;
    notifyListeners();
    final response = await _userServices.getUserData(currentEmail);
    currentUserModel = response;

    isloading = false;
    notifyListeners();
  }
}
