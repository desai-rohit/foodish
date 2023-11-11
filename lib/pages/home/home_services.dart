import 'dart:convert';

import 'package:food_delivery/comman/urls.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/restaurantlist_model.dart';
import 'package:food_delivery/models/slide_model.dart';
import 'package:http/http.dart' as http;




class Homeservices {
  Future<CurrentUserModel> getUserData(email) async {
    var res = await http.get(Uri.parse("${link}user/$email"));
    if (res.body.isNotEmpty) {
      var data = currentUserModelFromJson(res.body);
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }
   Future<List<RestaurantListModel>> getrestaurantResult() async {
    var res = await http.get(Uri.parse("${link}restaurantList"));
    if (res.statusCode == 200) {
      var data = restaurantListModelFromJson(res.body.toString());

      return data;
    }
    return [];
  }

  Future<List<Products>> getProductsList({String? gmail}) async {
    var res = await http.get(Uri.parse("${link}products/$gmail"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }

    Future<List<Slidemodel>> sildeImage() async {
    var res = await http.get(Uri.parse("${link}sildeimage"));
    if (res.statusCode == 200) {
      var data = slidemodelFromJson(res.body.toString());

      return data;
    }
    return [];
  }

    Future<List<Products>> getcategoryProductsList(
      {String? gmail, String? category}) async {
    var res = await http.get(Uri.parse("${link}products/$gmail&$category"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<http.Response> updateUser(
    {required String gmail,
    String? lat,
    String? lng,
    String? flat,
    String? area,
    String? landmark}) async {
  return await http.put(
    Uri.parse('${link}userupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "address": [
        {
          "lat": lat,
          "lng": lng,
          "flatHouseNo": flat,
          "area": area,
          "nearbyLandmark": landmark
        }
      ]
    }),
  );
}
}