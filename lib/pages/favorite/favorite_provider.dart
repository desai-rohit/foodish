import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/models/favorite_model.dart';
import 'package:food_delivery/pages/favorite/favorite_services.dart';

class FavoriteProvider extends ChangeNotifier {
  bool isloading = false;
  

  final favoriteService = Favoriteservice();

  List<Favorite> _favorite = [];

  List<Favorite> get favoritedata => _favorite;

  String favoriteId = '';

  favoriteid(id) {
    favoriteId = id;
    notifyListeners();
  }

  Future<void> getAllFavorite() async {
    isloading = true;
    notifyListeners();
    final response = await favoriteService.favoriteList(currentEmail);
    _favorite = response;
    isloading = false;
    notifyListeners();
  }

  favdelete(id) {
    isloading = true;
    notifyListeners();
   Favoriteservice().favoritedelete(id)
        .then((value) => getAllFavorite().then((value) => favoriteid("")));
    isloading = false;
    notifyListeners();
  }
}
