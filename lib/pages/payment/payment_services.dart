
import 'dart:convert';
import 'package:food_delivery/comman/urls.dart';
import 'package:http/http.dart' as http;

class PaymentServices{



Future<http.Response> order(
    {String? name,
    String? gmail,
    String? password,
    String? lat,
    String? lng,
    String? house,
    String? area,
    String? landmark,
    String? user,
    String? image,
    String? foodname,
    String? restorantName,
    String? restorantGmail,
    String? price,
    String? countTotalPrice,
    String? productid,
    String? orderid,
    String? paymentid,
    String? quantity
    }) async {
  return await http.post(
    Uri.parse('${link}order'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "productsID": productid,
      'username': name,
      'useremail': gmail,
      "image": image,
      "foodname": foodname,
      "rating": "0",
      "restorant_name": restorantName,
      "restorant_gmail": restorantGmail,
      "price": price,
      "countTotalPrice": countTotalPrice,
      "orderaccepted": false,
      "ordership": false,
      "orderid": orderid,
      "paymentid": paymentid,
      "quantity": quantity,
      "address": {
        "lat": lat,
        "lng": lng,
        "flatHouseNo": house,
        "area": area,
        "nearbyLandmark": landmark,
      }
    }),
  );
}
}