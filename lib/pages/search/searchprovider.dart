import 'package:flutter/material.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/services/api_user.dart';

class SearchProvider extends ChangeNotifier {
  bool isloading = false;
  final _apiServices = ApiServices();
  List<Products> _searchResult = [];
  List<Products> get serachData => _searchResult;
  Future<void> searchResult(query) async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getSearchResult(query);
    _searchResult = response;
    isloading = false;
    notifyListeners();
  }
}
