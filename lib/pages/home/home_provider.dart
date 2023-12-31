import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/restaurantlist_model.dart';
import 'package:food_delivery/models/slide_model.dart';
import 'package:food_delivery/pages/home/home_services.dart';
import 'package:geolocator/geolocator.dart';

class HomeProvider extends ChangeNotifier {
  bool isloading = false;

  final homeservices = Homeservices();
  CurrentUserModel? user;

  List<RestaurantListModel> _restaurantList = [];
  List<RestaurantListModel> get restaurantListData => _restaurantList;


  String? restauramtGmail;

  List<Products> productsList = [];
  List<Products> get productsListData => productsList;

  double? distanceInMeters;
  double distanceInKm = 0.0;

  List<Slidemodel> _sildelist = [];
  List<Slidemodel> get slideImageData => _sildelist;

  TextEditingController searchController = TextEditingController();

  int activePage = 0;

  double fontsize = 16.0;

  fontsizea() {
    fontsize = 24.0;

    Timer(const Duration(seconds: 1), () {
      fontsize = 16.0;
      notifyListeners();
    });

    notifyListeners();
  }

  slideactivepage(page) {
    activePage = page;
    notifyListeners();
  }

  updategmail(data) {
    restauramtGmail = data;
    notifyListeners();
  }

  Future<void> getUser() async {
    final response = await homeservices.getUserData(currentEmail);
    user = response;
  }

  Future<void> getRestaurants() async {
    isloading = true;
    notifyListeners();
    final response = await homeservices.getrestaurantResult();
    _restaurantList = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> getProducts({required String gmail}) async {
    isloading = true;
    notifyListeners();
    final response = await homeservices.getProductsList(gmail: gmail);
    productsList = response;
    isloading = false;
    productsListData;
    notifyListeners();
  }

  homePageDistance(lat1, lng1, lat2, lng2) {
    distanceInMeters = Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
    distanceInKm = distanceInMeters! * 0.001;
    notifyListeners();
  }

  Future<void> getsldieimage() async {
    // islaoding = true;
    notifyListeners();
    final response = await homeservices.sildeImage();
    _sildelist = response;
    // islaoding = false;
    notifyListeners();
  }

  Future<void> getcategoryProducts(
      {required String gmail, String? category}) async {
    isloading = true;
    notifyListeners();
    final response = await homeservices.getcategoryProductsList(
        gmail: gmail, category: category);
    productsList = response;
    isloading = false;
    productsListData;
    notifyListeners();
  }

  homePageProductsLoad() async {
    isloading = true;
    notifyListeners();
    await getUser();
    if (user!.address![0].area != "") {
      await getRestaurants().then((value) {
        for (var i = 0; i < restaurantListData.length; i++) {
          if (Geolocator.distanceBetween(
                  double.parse(user!.address![0].lat),
                  double.parse(user!.address![0].lng),
                  double.parse(restaurantListData[i].address[0].lat),
                  double.parse(restaurantListData[i].address[0].lng)) <=
              7000) {
            getProducts(gmail: restaurantListData[i].gmail);
            restauramtGmail = restaurantListData[i].gmail;
            homePageDistance(
                double.parse(user!.address![0].lat),
                double.parse(user!.address![0].lng),
                double.parse(restaurantListData[i].address[0].lat),
                double.parse(restaurantListData[i].address[0].lng));
          }
        }
      });
    } else {}
    isloading = false;

    notifyListeners();
  }
}
