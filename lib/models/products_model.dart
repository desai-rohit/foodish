// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String id;
  String image;
  String foodName;
  int price;
  String restorantName;
  String gmail;
  String des;
  String category;

  Products({
    required this.id,
    required this.image,
    required this.foodName,
    required this.price,
    required this.restorantName,
    required this.gmail,
    required this.des,
    required this.category,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["_id"],
        image: json["image"],
        foodName: json["foodName"],
        price: json["price"],
        restorantName: json["restuarantName"],
        gmail: json["gmail"],
        des: json["des"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {                                                                                                                                                                                           
        "_id": id,
        "image": image,
        "foodName": foodName,
        "price": price,
        "restuarantName": restorantName,
        "gmail": gmail,
        "des": des,
        "category": category
      };
}
