import 'package:flutter/material.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/search/search_services.dart';

class SearchProvider extends ChangeNotifier {
  bool isloading = false;
  final searchservices = Searchservices();
  List<Products> _searchResult = [];
  List<Products> get serachData => _searchResult;
  Future<void> searchResult(query) async {
    isloading = true;
    notifyListeners();
    final response = await searchservices.getSearchResult(query);
    _searchResult = response;
    isloading = false;
    notifyListeners();
  }
}
