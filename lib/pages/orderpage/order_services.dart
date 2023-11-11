import 'dart:convert';

import 'package:food_delivery/comman/urls.dart';
import 'package:http/http.dart' as http;


class Orderservices{

    Future<http.Response> addcart(productsID, user, image, name, restorantName,
      gmail, price, itemcount, totalprice) async {
    return await http.post(
      Uri.parse('${link}cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "productId": productsID,
        'user': user,
        'image': image,
        'name': name,
        'restorant_name': restorantName,
        "restorant_gmail": gmail,
        "price": price.toString(),
        "itemcount": itemcount,
        "totalprice": totalprice
      }),
    );
  }

  Future<http.Response> addFavorite(
    productsID, user, image, name, restorantName, price) async {
  return await http.post(
    Uri.parse('${link}favorite'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "productsID": productsID,
      'user': user,
      'image': image,
      'foodname': name,
      'restorant_name': restorantName,
      "price": price
    }),
  );
}
}