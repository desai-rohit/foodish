import 'dart:convert';

import 'package:food_delivery/comman/urls.dart';
import 'package:food_delivery/models/add_cart.dart';
import 'package:http/http.dart' as http;

class CartServices{

   Future<List<Addcart>> getListaddcart(currentEmail) async {
    var res = await http.get(Uri.parse("${link}cartlist/$currentEmail"));
    if (res.statusCode == 200) {
      var data = addcartFromJson(res.body.toString());

      return data;
    }
    return [];
  }

  Future<http.Response> updateCart(id, itemcount, totalprice) async {
  return await http.put(
    Uri.parse('${link}cartupdate/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'itemcount': itemcount, "totalprice": totalprice}),
  );
}

Future<http.Response> deleteCart(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('${link}cartdelete/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
}