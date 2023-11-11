import 'dart:convert';

import 'package:food_delivery/comman/urls.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:http/http.dart' as http;


class MyOrderServices{
  Future<http.Response> rateing({required String id, String? rateing}) async {
  return await http.put(
    Uri.parse('${link}rateing/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"rateing": rateing!}),
  );
}
  Future<List<OrderModel>> getCompleteOrder(currentEmail) async {
    var res = await http.get(Uri.parse("${link}userorder/$currentEmail"));
    if (res.statusCode == 200) {
      var data = orderModelFromJson(res.body.toString());
      return data;
    }
    return [];
  }
}